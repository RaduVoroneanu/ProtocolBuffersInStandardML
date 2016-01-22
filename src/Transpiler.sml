signature TRANSPILER =
sig
	val writeFile : (string * string) -> unit
	val generate : string * string -> unit
end;

structure Transpiler :> TRANSPILER =
struct

	fun writeFile (out_path, data) =
		let val outputStream = TextIO.openOut out_path
		in
			TextIO.output(outputStream, data); TextIO.closeOut outputStream
		end
		
	fun replace (b, a) (input) = String.map (fn x => if x = b then a else x) input
	fun toUpper (input) = String.map (Char.toUpper) input
	fun separate (_) ([]) = ""
	|	separate (_) ([x]) = x
	|	separate (separator) (x::y::xs) = x ^ separator ^ (separate separator (y::xs))
	fun toProtoType (INT32) = "int32"
	|	toProtoType (INT64) = "int64"
	|	toProtoType (UINT32) = "uint32"
	|	toProtoType (UINT64) = "uint64"
	|	toProtoType (SINT32) = "sint32"
	|	toProtoType (SINT64) = "sint64"
	|	toProtoType (BOOL) = "bool"
	|	toProtoType (FIXED32) = "fixed32"
	|	toProtoType (FIXED64) = "fixed64"
	|	toProtoType (SFIXED32) = "sfixed32"
	|	toProtoType (SFIXED64) = "sfixed64"
	|	toProtoType (STRING) = "string"
	|	toProtoType (MESSAGE(_)) = "message"
	|	toProtoType (ENUM(_)) = "uint32"
	fun toSMLType (INT32) = "int"
	|	toSMLType (INT64) = "int"
	|	toSMLType (UINT32) = "int"
	|	toSMLType (UINT64) = "int"
	|	toSMLType (SINT32) = "int"
	|	toSMLType (SINT64) = "int"
	|	toSMLType (BOOL) = "bool"
	|	toSMLType (FIXED32) = "int"
	|	toSMLType (FIXED64) = "int"
	|	toSMLType (SFIXED32) = "int"
	|	toSMLType (SFIXED64) = "int"
	|	toSMLType (STRING) = "string"
	|	toSMLType (MESSAGE(name)) = replace (#".", #"_") (name) ^ ".t"
	|	toSMLType (ENUM(name)) = replace (#".", #"_") (name) ^ ".t"
	
	fun enumDatatype (l) = separate (" | ") (List.map (fn (x, _) => x) (l)) 
	fun enumVal (l) = separate ("\n") (List.map (fn (x, _) => "\tval k" ^ x ^ " = " ^ x) (l))
	fun enumToInt (l) = separate ("\n\t|\t") (List.map (fn (x, y) => "toInt (" ^ x ^ ") = " ^ Int.toString (y)) l)
	fun enumFromInt (l) = separate ("\n\t|\t") (List.map (fn (x, y) => "fromInt (" ^ Int.toString(y) ^ ") = " ^ x) l)
	
	fun generateEnum (name, cases) = 
		let	val first::_ = cases
		in
			"structure " ^ (replace (#".", #"_") (name)) ^ " =\n" ^
			"struct\n" ^
			"\tdatatype t = " ^ (enumDatatype cases) ^ "\n\n" ^
			(enumVal (cases)) ^ "\n" ^
			"\tval kdefault = " ^ (#1(first)) ^ "\n\n" ^
			"\tfun " ^ (enumToInt (cases)) ^ "\n\n" ^
			"\tfun " ^ (enumFromInt (cases)) ^ "\n\t|\tfromInt (_) = " ^ (#1(first)) ^ "\n" ^ 
			"end;"
		end
		
	fun messageTags (cases) = 
		let fun f (Variable(_, _, n, i, _)) = "\tval k" ^ n ^ "Tag = " ^ Int.toString (i)
			|	f (OneOf(n, c)) = 
					"\tval k" ^ n ^ "Tags = [" ^ (separate (", ") (List.map (fn (_, _, i) => Int.toString i) c)) ^ "]\n"^
					messageTags (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c)
		in
			separate ("\n") (List.map (f) cases)
		end
	fun messageDescriptor (cases) =
		let fun f (Variable(q, t, n, _, _)) = 
					"\tval descriptor = Proto.descriptor_add_" ^ (case q of REPEATED => "r" | _ => "") ^
					(toProtoType t) ^ 
					(
						case t of 
							MESSAGE(w) => " (k" ^ n ^ "Tag, " ^ (replace (#".", #"_") w) ^ ".descriptor) descriptor"
						|	_ => " k" ^ n ^ "Tag descriptor"
					)
			|	f (OneOf(n, c)) =
					"\tval descriptor = Proto.descriptor_add_oneof k" ^ n ^ "Tags descriptor\n" ^ 
					messageDescriptor (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c)
		in
			separate ("\n") (List.map (f) cases)
		end
	
	fun messageSizeAccessor (oneof) (context) (cases) =
		let fun f (_) (Variable(REPEATED, MESSAGE(name), n, _, _)) =
					(
					case List.find (fn x => x = name) context of
						SOME(_) => 
							"\tfun size_" ^ n ^ " (proto : t) : int = Proto.proto_repeated_size_message k" ^ n ^ "Tag proto\n" ^
							"\tfun get_" ^ n ^ " (proto : t) : " ^ (replace (#".", #"_") name) ^ ".t list = Proto.proto_repeated_get_message k" ^ n ^ "Tag proto\n" ^
							"\tfun set_" ^ n ^ " (value : " ^ (replace (#".", #"_") name) ^ ".t list) (proto : t) : t = Proto.proto_repeated_set_message k" ^ n ^ "Tag value proto\n" ^
							"\tfun add_" ^ n ^ " (value : " ^ (replace (#".", #"_") name) ^ ".t) (proto : t) : t = Proto.proto_repeated_add_message k" ^ n ^ "Tag value proto\n" ^
							"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_repeated_clear_message k" ^ n ^ "Tag proto\n" ^
							"\tval lens_" ^ n ^ " : (t, " ^ (replace (#".", #"_") name) ^ ".t list) Lens = { get = get_" ^ n ^ ", set = set_" ^ n ^ "}\n" ^
							"\tfun get_nth_" ^ n ^ " (position : int) (proto : t) : " ^ (replace (#".", #"_") name) ^ ".t = Proto.proto_repeated_getnth_message k" ^ n ^ "Tag position proto\n" ^
							"\tfun set_nth_" ^ n ^ " (position : int) (value : " ^ (replace (#".", #"_") name) ^ ".t) (proto : t) : t = Proto.proto_repeated_setnth_message k" ^ n ^ "Tag position value proto\n" ^
							"\tfun lens_nth_" ^ n ^ " (position : int) : (t, " ^ (replace (#".", #"_") name) ^ ".t) Lens = { get = get_nth_" ^ n ^ " position, set = set_nth_" ^ n ^ " position}\n"
					|	NONE => "HEllo"
					)		
			|	f (_) (Variable(REPEATED, ENUM(name), n, _, _)) =
					"\tfun size_" ^ n ^ " (proto : t) : int = Proto.proto_repeated_size_uint32 k" ^ n ^ "Tag proto \n" ^
					"\tfun get_" ^ n ^ " (proto : t) : " ^ (replace (#".", #"_") name) ^ ".t list = List.map (fn x => " ^ (replace (#".", #"_") name) ^ ".fromInt x) (Proto.proto_repeated_get_uint32 k" ^ n ^ "Tag proto)\n" ^
					"\tfun set_" ^ n ^ " (value : " ^ (replace (#".", #"_") name) ^ ".t list) (proto : t) : t = Proto.proto_repeated_set_uint32 k" ^ n ^ "Tag (List.map (fn x => " ^ (replace (#".", #"_") name) ^ ".toInt x) value) proto\n" ^
					"\tfun add_" ^ n ^ " (value : " ^ (replace (#".", #"_") name) ^ ".t) (proto : t) : t = Proto.proto_repeated_add_uint32 k" ^ n ^ "Tag (" ^ (replace (#".", #"_") name) ^ ".toInt value) proto\n" ^
					"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_repeated_clear_uint32 k" ^ n ^ "Tag proto\n" ^
					"\tval lens_" ^ n ^ " : (t, " ^ (replace (#".", #"_") name) ^ ".t list) Lens = { get = get_" ^ n ^ ", set = set_" ^ n ^ "}\n" ^
					"\tfun get_nth_" ^ n ^ " (position : int) (proto : t) : " ^ (replace (#".", #"_") name) ^ ".t = " ^ (replace (#".", #"_") name) ^ ".fromInt (Proto.proto_repeated_getnth_uint32 k" ^ n ^ "Tag position proto)\n" ^
					"\tfun set_nth_" ^ n ^ " (position : int) (value : " ^ (replace (#".", #"_") name) ^ ".t) (proto : t) : t = Proto.proto_repeated_setnth_uint32 k" ^ n ^ "Tag position (" ^ (replace (#".", #"_") name) ^ ".toInt value) proto\n" ^
					"\tfun lens_nth_" ^ n ^ " (position : int) : (t, " ^ (replace (#".", #"_") name) ^ ".t) Lens = { get = get_nth_" ^ n ^ " position, set = set_nth_" ^ n ^ " position}\n"
			|	f (_) (Variable(REPEATED, t, n, _, _)) =
					"\tfun size_" ^ n ^ " (proto : t) : int = Proto.proto_repeated_size_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag proto\n" ^
					"\tfun get_" ^ n ^ " (proto : t) : " ^ (toSMLType t) ^ " list = Proto.proto_repeated_get_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag proto\n" ^
					"\tfun set_" ^ n ^ " (value : " ^ (toSMLType t) ^ " list) (proto : t) : t = Proto.proto_repeated_set_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag value proto\n" ^
					"\tfun add_" ^ n ^ " (value : " ^ (toSMLType t) ^ ") (proto : t) : t = Proto.proto_repeated_add_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag value proto\n" ^
					"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_repeated_clear_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag proto\n" ^
					"\tval lens_" ^ n ^ " : (t, " ^ (toSMLType t) ^ " list) Lens = { get = get_" ^ n ^ ", set = set_" ^ n ^ "}\n" ^
					"\tfun get_nth_" ^ n ^ " (position : int) (proto : t) : " ^ (toSMLType t) ^ " = Proto.proto_repeated_getnth_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag position proto\n" ^
					"\tfun set_nth_" ^ n ^ " (position : int) (value : " ^ (toSMLType t) ^ ") (proto : t) : t = Proto.proto_repeated_setnth_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag position value proto\n" ^
					"\tfun lens_nth_" ^ n ^ " (position : int) : (t, " ^ (toSMLType t) ^ ") Lens = { get = get_nth_" ^ n ^ " position, set = set_nth_" ^ n ^ " position}\n"
			|	f (oneof) (Variable(_, MESSAGE(name), n, _, _)) =
					(
					case List.find (fn x => x = name) context of
						SOME(_) =>
							"\tfun has_" ^ n ^ " (proto : t) : bool = Proto.proto_has_message k" ^ n ^ "Tag proto\n" ^
							"\tfun get_" ^ n ^ " (proto : t) : " ^ (replace (#".", #"_") name) ^ ".t = Proto.proto_get_message k" ^ n ^ "Tag " ^ (replace (#".", #"_") name) ^ ".new proto\n" ^
							"\tfun set_" ^ n ^ " (value : " ^ (replace (#".", #"_") name) ^ ".t) (proto : t) : t = Proto.proto_set_message k" ^ n ^ "Tag value " ^ (if oneof="" then "proto" else "(clear_" ^ oneof ^ " proto)") ^ "\n" ^
							"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_clear_message k" ^ n ^ "Tag proto\n" ^
							"\tval lens_" ^ n ^ " : (t, " ^ (replace (#".", #"_") name) ^ ".t) Lens = { get = get_" ^ n ^ ", set = set_" ^ n ^ " }\n"
					|	NONE => "HELLO"
					)
			|	f (oneof) (Variable(_, ENUM(name), n, _, d)) =
					"\tfun has_" ^ n ^ " (proto : t) : bool = Proto.proto_has_uint32 k" ^ n ^ "Tag proto\n" ^
					"\tfun get_" ^ n ^ " (proto : t) : " ^ (replace (#".", #"_") name) ^ ".t = " ^ (replace (#".", #"_") name) ^ ".fromInt (Proto.proto_get_uint32 k" ^ n ^ "Tag (" ^ (replace (#".", #"_") name) ^ ".toInt " ^ (replace (#".", #"_") name) ^ ".k" ^ (case d of NONE => "default" | SOME(s) => s) ^ ") proto)\n" ^
					"\tfun set_" ^ n ^ " (value : " ^ (replace (#".", #"_") name) ^ ".t) (proto : t) : t = Proto.proto_set_uint32 k" ^ n ^ "Tag (" ^ (replace (#".", #"_") name) ^ ".toInt value) " ^ (if oneof="" then "proto" else "(clear_" ^ oneof ^ " proto)") ^ "\n" ^
					"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_clear_uint32 k" ^ n ^ "Tag proto\n" ^
					"\tval lens_" ^ n ^ " : (t, " ^ (replace (#".", #"_") name) ^ ".t) Lens = { get = get_" ^ n ^ ", set = set_" ^ n ^ " }\n"
			|	f (oneof) (Variable(_, t, n, _, d)) =
					"\tfun has_" ^ n ^ " (proto : t) : bool = Proto.proto_has_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag proto\n" ^
					"\tfun get_" ^ n ^ " (proto : t) : " ^ (toSMLType t) ^ " = Proto.proto_get_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag " ^ 
						(
						case d of 
							SOME(w) => if t = STRING orelse t = BOOL then w
										else (Int.toString o valOf o Int.fromString) w 
						| NONE => "Defaults.k" ^ (toProtoType t)
						) ^ " proto\n" ^
					"\tfun set_" ^ n ^ " (value : " ^ (toSMLType t) ^ ") (proto : t) : t = Proto.proto_set_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag value " ^ (if oneof="" then "proto" else "(clear_" ^ oneof ^ " proto)") ^ "\n" ^
					"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_clear_" ^ (toProtoType t) ^ " k" ^ n ^ "Tag proto\n" ^
					"\tval lens_" ^ n ^ " : (t, " ^ (toSMLType t) ^ ") Lens = { get = get_" ^ n ^ ", set = set_" ^ n ^ " }\n"
			|	f (_) (OneOf (n, cases)) = 
					"\tdatatype type" ^ n ^ " = " ^(separate " | " ("NOT_SET" :: (List.map (fn (_, n, _) => "k" ^ n) cases))) ^ "\n" ^
					"\tfun case_" ^ n ^ " (proto : t) = \n" ^
					"\t\tcase Proto.proto_oneof_case k" ^ n ^ "Tags proto of\n\t\t\t" ^
					(separate ("\n\t\t|\t") (List.map (fn (_, n, i) => "SOME("^ Int.toString(i) ^") => k" ^ n) cases)) ^
					"\n\t\t|\t_ => NOT_SET\n" ^
					"\tfun clear_" ^ n ^ " (proto : t) : t = Proto.proto_oneof_clear k" ^ n ^ "Tags proto\n\n" ^
					(messageSizeAccessor (n) (context) (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) cases))
		in
			separate ("\n") (List.map (f oneof) cases)
		end;
		
	fun messageIsValid (cases) =
		let fun req (Variable(REQUIRED, _, n, _, _)) = "\t\tif not (has_" ^ n ^ " proto) then false else"
			|	req (_) = ""
			fun mes (Variable(REPEATED, MESSAGE(name), n, _, _)) = "\t\tif not (List.all " ^ (replace (#".", #"_") name) ^ ".isValid (get_" ^ n ^ " proto)) then false else"
			|	mes (Variable(_, MESSAGE(name), n, _, _)) = "\t\tif not (has_" ^ n ^ " proto andalso " ^ (replace (#".", #"_") name) ^ ".isValid (get_" ^ n ^ " proto)) then false else"
			|	mes (OneOf(_, c)) = messageIsValid (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c)
			|	mes (_) = ""
			val r = List.map req cases
			val m = List.map mes cases
			val l = List.filter (fn x => x <> "") (r @ m)
		in
			(separate ("\n") (l))
		end
		
	fun generateMessageSize (context) (name, cases) = 
		"structure " ^ (replace (#".", #"_") (name)) ^ " =\n" ^
		"struct\n" ^
		"\ttype t = Proto.protoType\n\n" ^
		"\tval new : t = Proto.newProto\n\n" ^
		(messageTags cases) ^ "\n\n" ^ 
		"\tval descriptor = Proto.newDescriptor\n" ^
		(messageDescriptor cases) ^ "\n\n" ^
		(messageSizeAccessor "" context cases) ^ "\n" ^
		"\tfun isValid (proto : t) =\n" ^ 
		(messageIsValid cases) ^ "\n" ^
		"\t\ttrue\n\n" ^
		"\tfun serializeUnsafe (proto : t) : Word8.word list = Proto.serialize proto\n" ^
		"\tfun deserializeUnsafe (value : Word8.word list) : t = Proto.deserialize descriptor value\n\n" ^
		"\tfun serialize (proto : t) =\n" ^
		"\t\tif isValid proto then serializeUnsafe proto\n" ^
		"\t\telse raise SerializationError(\"Proto is missing required fields\")\n" ^
		"\tfun deserialize (xs : Word8.word list) =\n" ^
		"\t\tlet val proto = deserializeUnsafe xs \n" ^
		"\t\tin\n" ^
		"\t\t\tif isValid proto then proto\n" ^
		"\t\t\telse raise DeserializationError(\"Proto is missing fields\")\n" ^
		"\t\tend\n" ^
		"end;"
	
	fun messageSpeedSigTags (cases) =
		let fun f (Variable(_, _, n, _, _)) = "\tval k" ^ n ^ "Tag : int"
			|	f (OneOf (n, c)) = "\tval k" ^ n ^ "Tags : int list\n" ^ (messageSpeedSigTags (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c))
		in
			separate ("\n") (List.map f cases)
		end
		
	fun messageSpeedSigAccessor (cases) =
		let fun f (Variable(REPEATED, t, n, _, _)) =
					"\tval size_" ^ n ^ " : t -> int\n" ^
					"\tval get_" ^ n ^ " : t -> " ^ (toSMLType t) ^ " list\n" ^
					"\tval set_" ^ n ^ " : " ^ (toSMLType t) ^ " list -> t -> t\n" ^
					"\tval add_" ^ n ^ " : " ^ (toSMLType t) ^ " -> t -> t\n" ^
					"\tval clear_" ^ n ^ " : t -> t\n" ^
					"\tval lens_" ^ n ^ " : (t, " ^ (toSMLType t) ^ " list) Lens\n" ^
					"\tval get_nth_" ^ n ^ " : int -> t -> " ^ (toSMLType t) ^ "\n" ^
					"\tval set_nth_" ^ n ^ " : int -> " ^ (toSMLType t) ^ " -> t -> t\n" ^
					"\tval lens_nth_" ^ n ^ " : int -> (t, " ^ (toSMLType t) ^ ") Lens\n"
			|	f (Variable(_, t, n, _, _)) = 
					"\tval has_" ^ n ^ " : t -> bool\n" ^
					"\tval get_" ^ n ^ " : t -> " ^ (toSMLType t) ^ "\n" ^
					"\tval set_" ^ n ^ " : " ^ (toSMLType t) ^ " -> t -> t\n" ^
					"\tval clear_" ^ n ^ " : t -> t\n" ^
					"\tval lens_" ^ n ^ " : (t, " ^ (toSMLType t) ^ ") Lens\n"
			|	f (OneOf(_, c)) =
					"\tdatatype typeNestedOneOf = NOT_SET | " ^
					(separate (" | ") (List.map (fn (_, n, _) => "k" ^ n) c)) ^ "\n" ^
					"\tval case_NestedOneOf : t -> typeNestedOneOf\n" ^
					"\tval clear_NestedOneOf : t -> t\n\n" ^
					(messageSpeedSigAccessor (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c))
		in
			separate ("\n") (List.map f cases)
		end
		
	fun messageSpeedOneofDatatype (cases) =
		let fun f (OneOf (n, c)) = 
					"\tdatatype datatype" ^ n ^ " = " ^ 
					(separate (" | ") (List.map (fn (t, n, _) => toUpper n ^ " of " ^ (toSMLType t)) c))
			|	f (_) = ""
		in
			separate ("\n") (List.filter (fn x => x <> "") (List.map f cases))
		end
		
	fun messageSpeedType (cases) =
		let fun f (Variable(q, t, n, _, _)) = 
					(toUpper n) ^ " : " ^ (toSMLType t) ^ (if q = REPEATED then " list" else "") ^ " option"
			|	f (OneOf(n, _)) = (toUpper n) ^ " : datatype" ^ n ^ " option"
		in
			separate (", ") (List.map f cases)
		end
		
	fun messageSpeedNew (cases) =
		let fun f (Variable(_, _, n, _, _)) = (toUpper n) ^ " = NONE"
			|	f (OneOf(n, _)) = (toUpper n) ^ " = NONE"
		in
			separate (", ") (List.map f cases)
		end
		
	fun newRecord (fields) (name) (replace) =
		"{ " ^ separate (", ") (List.map (fn x => if x = name then replace else (toUpper x) ^ " = #" ^ (toUpper x) ^ " t") fields) ^ " }"
		
	fun messageSpeedStructAccessor (cases) =
		let val fields = List.map (fn x => case x of Variable(_, _, n, _, _) => n | OneOf(n, _) => n) cases
			fun needsLimits (MESSAGE(_)) = false
			|	needsLimits (ENUM(_)) = false
			|	needsLimits (STRING) = false
			|	needsLimits (BOOL) = false
			|	needsLimits (_) = true
			fun defaults (NONE, MESSAGE(name)) = (replace (#".", #"_") name) ^ ".new"
			|	defaults (NONE, ENUM(name)) = (replace (#".", #"_") name) ^ ".kdefault"
			|	defaults (NONE, tt) = "Defaults.k" ^ (toProtoType tt)
			|	defaults (SOME(value), ENUM(name)) = (replace (#".", #"_") name) ^ ".k" ^ value
			|	defaults (SOME(value), BOOL) = value
			|	defaults (SOME(value), STRING) = value
			|	defaults (SOME(value), _) = (Int.toString o valOf o Int.fromString) (value)
			fun f (_) (Variable(REPEATED, tt, n, _, _)) =
					"\tfun size_" ^ n ^ " (t) = \n" ^
					"\t\tcase #" ^ (toUpper n) ^ " t of\n" ^
					"\t\t\tSOME(l) => List.length l\n" ^
					"\t\t|\t_ => 0\n" ^
					"\tfun get_" ^ n ^ " (t) = \n" ^
					"\t\tcase #" ^ (toUpper n) ^ " t of\n" ^
					"\t\t\tSOME(l) => l\n" ^
					"\t\t|\t_ => []\n" ^
					"\tfun set_" ^ n ^ " (value) (t) = \n" ^ 
					"\t\t" ^ (if needsLimits (tt) then "if List.all Limits.isValid" ^ (toProtoType tt) ^ " value then " else "") ^ 
					newRecord fields n (toUpper n ^ " = SOME(value)") ^ 
					(if needsLimits tt then "\n\t\telse raise InvalidSet(\"Values are not " ^ (toProtoType tt) ^ "\")" else "") ^ "\n" ^
					"\tfun add_" ^ n ^ " (value) (t) = \n" ^
					"\t\tlet val xs = get_" ^ n ^ " t\n" ^
					"\t\tin\n" ^
					"\t\t\t" ^ (if needsLimits tt then "if Limits.isValid" ^ (toProtoType tt) ^ " value then " else "") ^
					newRecord fields n (toUpper n ^ " = SOME(xs @ [value])") ^
					(if needsLimits tt then "\n\t\t\telse raise InvalidSet(\"Value is not " ^ (toProtoType tt) ^ "\")" else "") ^ "\n" ^
					"\t\tend\n" ^
					"\tfun clear_" ^ n ^ " (t) = " ^ newRecord fields n (toUpper n ^ " = NONE") ^ "\n" ^
					"\tval lens_" ^ n ^ " = { get = get_" ^ n ^ ", set = set_" ^ n ^ " }\n" ^
					"\tfun get_nth_" ^ n ^ " (position) (t) = List.nth (get_" ^ n ^ " t, position)\n" ^
					"\tfun set_nth_" ^ n ^ " (position) (value) (t) = \n" ^
					"\t\tlet val xs = get_" ^ n ^ " t\n" ^
					"\t\tin\n" ^
					"\t\t\t" ^ (if needsLimits tt then "if Limits.isValid" ^ (toProtoType tt) ^ " value then " else "") ^
					newRecord fields n (toUpper n ^ " = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1)))") ^
					(if needsLimits tt then "\n\t\t\telse raise InvalidSet(\"Value is not " ^ (toProtoType tt) ^ "\")" else "") ^ "\n" ^
					"\t\tend\n" ^
					"\tfun lens_nth_" ^ n ^ " (position) = { get = get_nth_" ^ n ^ " position, set = set_nth_" ^ n ^ " position }\n"
			|	f ("") (Variable(_, tt, n, _, d)) =
					"\tfun has_" ^ n ^ " (t) = isSome (#" ^ (toUpper n) ^ " t)\n" ^
					"\tfun get_" ^ n ^ " (t) = \n" ^
					"\t\tcase #" ^ (toUpper n) ^ " t of\n" ^
					"\t\t\tSOME(value) => value\n" ^
					"\t\t|\t_ => " ^ defaults (d, tt) ^ "\n" ^
					"\tfun set_" ^ n ^ " (value) (t) = \n" ^
					"\t\t" ^ (if needsLimits tt then "if Limits.isValid" ^ (toProtoType tt) ^ " value then " else "") ^
					newRecord fields n (toUpper n ^ " = SOME(value)") ^
					(if needsLimits tt then "\n\t\telse raise InvalidSet(\"Value is not " ^ (toProtoType tt) ^ "\")" else "") ^ "\n" ^
					"\tfun clear_" ^ n ^ " (t) = " ^ 
					newRecord fields n (toUpper n ^ " = NONE") ^ "\n" ^
					"\tval lens_" ^ n ^ " = { get = get_" ^ n ^ ", set = set_" ^ n ^ " }\n"
			|	f (oneof) (Variable(_, tt, n, _, d)) =
						"\tfun has_" ^ n ^ " (t) = \n" ^
						"\t\tcase #" ^ (toUpper oneof) ^ " t of \n" ^
						"\t\t\tSOME(" ^ (toUpper n) ^ " _) => true \n" ^
						"\t\t|\t_ => false \n " ^
						"\tfun get_" ^ n ^ " (t) = \n" ^
						"\t\tcase #" ^ (toUpper oneof) ^ " t of\n" ^
						"\t\t\tSOME(" ^ (toUpper n) ^ " value) => value\n" ^
						"\t\t|\t_ => " ^ defaults (d, tt) ^ "\n" ^
						"\tfun set_" ^ n ^ " (value) (t) =\n" ^
						"\t\t" ^ (if needsLimits tt then "if Limits.isValid" ^ (toProtoType tt) ^ " value then " else "") ^
						newRecord fields oneof (toUpper oneof ^ " = SOME(" ^ toUpper n ^" value)") ^
						(if needsLimits tt then "\n\t\telse raise InvalidSet(\"Value is not " ^ (toProtoType tt) ^ "\")" else "") ^ "\n" ^
						"\tfun clear_" ^ n ^ " (t) =\n" ^
						"\t\tcase #" ^ (toUpper oneof) ^ " t of\n" ^
						"\t\t\tSOME(" ^ (toUpper n) ^ " value) => " ^
						newRecord fields oneof (toUpper oneof ^ " = NONE") ^ "\n" ^
						"\t\t|\t_ => t\n" ^
						"\tval lens_" ^ n ^ " = { get = get_" ^ n ^ ", set = set_" ^ n ^ " }\n"
			|	f (_) (OneOf (n, c)) =
					"\tdatatype type" ^ n ^ " = NOT_SET | " ^ (separate (" | ") (List.map (fn (_, n, _) => "k" ^ n) c)) ^ "\n" ^
					"\tfun case_NestedOneOf (t) = \n" ^
					"\t\tcase #" ^ (toUpper n) ^ " t of\n\t\t" ^
					(separate ("\n\t\t|") (List.map (fn (_, n, _) => "\tSOME(" ^ (toUpper n) ^ " _) => k" ^ n) c)) ^ "\n" ^
					"\t\t|\t_ => NOT_SET\n" ^ 
					"\tfun clear_NestedOneOf (t) = " ^
					newRecord fields n (toUpper n ^ " = NONE") ^ "\n\n" ^
					separate ("\n") (List.map (fn (t, nn, i) => f (n) (Variable(OPTIONAL, t, nn, i, NONE))) c)
			|	f (_) (_) = "HELLO\n"
		in
			separate ("\n") (List.map (f "") cases)
		end
	
	fun messageSpeedSerialize (cases) = 
		let fun f (Variable(REPEATED, INT32, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (TwoComplement32.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, INT64, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (TwoComplement64.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, UINT32, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, UINT64, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, SINT32, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (ZigZag.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, SINT64, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (ZigZag.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, BOOL, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (Boolean.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, ENUM(name), n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (" ^ (replace (#".", #"_") name) ^ ".toInt x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, FIXED32, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 5) @ Fixed32.serialize (x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, FIXED64, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 1) @ Fixed64.serialize (x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, SFIXED32, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 5) @ Fixed32.serialize (ZigZag.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, SFIXED64, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 1) @ Fixed64.serialize (ZigZag.encode x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, STRING, n, _, _)) = "\t\t\tList.concat (List.map (fn x => Varint.serialize (k" ^ n ^ "Tag * 8 + 2) @ StringHandler.serialize (x)) (get_" ^ n ^ " p))"
			|	f (Variable(REPEATED, MESSAGE(name), n, _, _)) = "\t\t\tList.concat (List.map (fn x => let val l = " ^ (replace (#".", #"_") name) ^ ".serializeUnsafe (x) in Varint.serialize(k" ^ n ^ "Tag * 8 + 2) @ Varint.serialize (List.length l) @ l end) (get_" ^ n ^ " p))"
			|	f (Variable(_, INT32, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (TwoComplement32.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, INT64, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (TwoComplement64.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, UINT32, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (get_" ^ n ^ " p) else []"
			|	f (Variable(_, UINT64, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (get_" ^ n ^ " p) else []"
			|	f (Variable(_, SINT32, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (ZigZag.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, SINT64, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (ZigZag.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, BOOL, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (Boolean.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, ENUM(name), n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 0) @ Varint.serialize (" ^ (replace (#".", #"_") name) ^ ".toInt (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, FIXED32, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 5) @ Fixed32.serialize (get_" ^ n ^ " p) else []"
			|	f (Variable(_, FIXED64, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 1) @ Fixed64.serialize (get_" ^ n ^ " p) else []"
			|	f (Variable(_, SFIXED32, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 5) @ Fixed32.serialize (ZigZag.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, SFIXED64, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 1) @ Fixed64.serialize (ZigZag.encode (get_" ^ n ^ " p)) else []"
			|	f (Variable(_, STRING, n, _, _)) = "\t\t\tif has_" ^ n ^ " p then Varint.serialize (k" ^ n ^ "Tag * 8 + 2) @ StringHandler.serialize (get_" ^ n ^ " p) else []"
			|	f (Variable(_, MESSAGE(name), n, _, _)) = "\t\t\tif has_" ^ n ^ " p then let val l = " ^ (replace (#".", #"_") name) ^ ".serializeUnsafe (get_" ^ n ^ " p) in Varint.serialize(k" ^ n ^ "Tag * 8 + 2) @ Varint.serialize (List.length l) @ l end else []"
			|	f (OneOf(_, c)) = messageSpeedSerialize (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c)
		in
			separate (",\n") (List.map f (cases))
		end
	
	fun messageSpeedDeserialize (cases) =
		let fun f (Variable(r, INT32, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (TwoComplement32.decode value) p) end"
			|	f (Variable(r, INT64, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (TwoComplement64.decode value) p) end"
			|	f (Variable(r, UINT32, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (value) p) end"
			|	f (Variable(r, UINT64, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (value) p) end"
			|	f (Variable(r, SINT32, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (ZigZag.decode value) p) end"
			|	f (Variable(r, SINT64, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (ZigZag.decode value) p) end"
			|	f (Variable(r, BOOL, n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (Boolean.decode value) p) end"
			|	f (Variable(r, ENUM(name), n, tag, _)) = "(" ^ Int.toString tag ^ ", 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (" ^ (replace (#".", #"_") name) ^ ".fromInt value) p) end"
			|	f (Variable(r, FIXED32, n, tag, _)) = "(" ^ Int.toString tag ^ ", 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (value) p) end"
			|	f (Variable(r, FIXED64, n, tag, _)) = "(" ^ Int.toString tag ^ ", 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (value) p) end"
			|	f (Variable(r, SFIXED32, n, tag, _)) = "(" ^ Int.toString tag ^ ", 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (ZigZag.decode value) p) end"
			|	f (Variable(r, SFIXED64, n, tag, _)) = "(" ^ Int.toString tag ^ ", 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (ZigZag.decode value) p) end"
			|	f (Variable(r, STRING, n, tag, _)) = "(" ^ Int.toString tag ^ ", 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeUnsafeHelp (xs3) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (value) p) end"
			|	f (Variable(r, MESSAGE(name), n, tag, _)) = "(" ^ Int.toString tag ^ ", 2) => let val (l, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (" ^ (if r = REPEATED then "add" else "set" ) ^ "_" ^ n ^ " (" ^ (replace (#".", #"_") name) ^ ".deserialize (List.take(xs3, l))) p) end"
			|	f (OneOf(_, c)) = messageSpeedDeserialize (List.map (fn (t, n, i) => Variable(OPTIONAL, t, n, i, NONE)) c)
		in
			separate ("\n\t\t\t|\t") (List.map f (cases))
		end

	fun generateMessageSpeed (name, cases) =
			"signature " ^ (replace (#".", #"_") (toUpper name)) ^ " =\n" ^
			"sig\n" ^
			"\ttype t\n" ^
			"\tval new : t\n" ^
			"\tval descriptor : Proto.descriptorType\n\n" ^
			(messageSpeedSigTags cases) ^ "\n\n" ^
			(messageSpeedSigAccessor cases) ^ "\n" ^
			"\tval isValid : t -> bool\n" ^
			"\tval serializeUnsafe : t -> Word8.word list\n" ^
			"\tval deserializeUnsafe : Word8.word list -> t\n" ^
			"\tval serialize : t -> Word8.word list\n" ^
			"\tval deserialize : Word8.word list -> t\n" ^
			"end;\n" ^
			"structure " ^ (replace (#".", #"_") name) ^ " :> " ^ (replace (#".", #"_") (toUpper name)) ^ " =\n" ^
			"struct\n" ^
			(case messageSpeedOneofDatatype cases of "" => "" | s => s ^ "\n") ^
			"\ttype t = { " ^ (messageSpeedType cases) ^ " }\n\n" ^ 
			"\tval new = { " ^ (messageSpeedNew cases) ^ " }\n\n" ^
			(messageTags cases) ^ "\n\n" ^
			"\tval descriptor = Proto.newDescriptor\n" ^
			(messageDescriptor cases) ^ "\n\n" ^
			(messageSpeedStructAccessor cases) ^ "\n" ^
			"\tfun isValid (proto) =\n" ^ 
			(messageIsValid cases) ^ "\n" ^
			"\t\ttrue\n\n" ^
			"\tfun serializeUnsafe (p) =\n" ^
			"\t\tList.concat [\n" ^
			(messageSpeedSerialize cases) ^ "\n" ^
			"\t\t]\n" ^
			"\tfun deserializeUnsafeHelp ([]) (p) = p\n" ^
			"\t|\tdeserializeUnsafeHelp (xs) (p) =\n" ^
			"\t\tlet val (tag_wire, xs2) = Varint.deserialize(xs)\n" ^
			"\t\t\tval (tag, wire) = (tag_wire div 8, tag_wire mod 8)\n" ^
			"\t\tin\n" ^
			"\t\t\tcase (tag, wire) of\n\t\t\t\t" ^
			(case (messageSpeedDeserialize cases) of "" => "\t\t\t\t" | s => s ^ "\n\t\t\t|\t") ^
			"(_, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end\n" ^
			"\t\t\t|\t(_, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end\n" ^
			"\t\t\t|\t(_, 2) => let val (l, xs3) = Varint.deserialize(xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (p) end\n" ^
			"\t\t\t|\t(_, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end\n" ^
			"\t\t\t|\t(_, _) => raise DeserializationError(\"Unknow wire type\")\n" ^
			"\t\tend\n" ^
			"\tfun deserializeUnsafe (xs) = deserializeUnsafeHelp (xs) (new)\n\n" ^
			"\tfun serialize (proto) =\n" ^
			"\t\tif isValid proto then serializeUnsafe proto\n" ^
			"\t\telse raise SerializationError(\"Proto is missing required fields\")\n" ^
			"\tfun deserialize (xs) =\n" ^
			"\t\tlet val proto = deserializeUnsafe xs \n" ^
			"\t\tin\n" ^
			"\t\t\tif isValid proto then proto\n" ^
			"\t\t\telse raise DeserializationError(\"Proto is missing fields\")\n" ^
			"\t\tend\n" ^
			"end;"
		
	fun generateHelp (_) (_) ([]) = ""
	|	generateHelp (_) (context) (Option CODE_SIZE :: xs) = generateHelp (false) context xs
	|	generateHelp (_) (context) (Option SPEED :: xs) = generateHelp (true) context xs
	|	generateHelp (opt) (context) (Enum (name, cases) :: xs) = 
			generateEnum (name, cases) ^ ("\n\n") ^ (generateHelp opt context xs)
	|	generateHelp (opt) (context) (Message (name, cases) :: xs) = 
			if opt then generateMessageSpeed (name, cases) ^ ("\n\n") ^ (generateHelp opt context xs)
			else generateMessageSize (context) (name, cases) ^ ("\n\n") ^ (generateHelp opt (name::context) xs)
	
	fun generate (in_path, out_path) = 
		let val result = import in_path
			val result = hoist result
			val _ = verify result
		in
			writeFile (out_path, generateHelp true [] result)
		end
end;