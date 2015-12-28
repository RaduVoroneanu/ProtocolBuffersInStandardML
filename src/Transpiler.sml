fun readFile (s) =
	let fun readInStream (stream) =
			let val line = TextIO.inputLine stream
			in 
				case line of
					NONE => ""
				|	SOME s => s ^ (readInStream stream)
			end
	in
		readInStream (TextIO.openIn s)
	end;

fun writeFile (destination, result) =
	let val outputStream = TextIO.openOut destination
	in
		TextIO.output(outputStream, result); TextIO.closeOut outputStream
	end;
	
fun toUpper (s) = String.map (Char.toUpper) s;
fun subChar (s) = String.map (fn x => if x = #"." then #"_" else x) s;

fun tokenError (ProtoLexer.Id(x)) = raise SyntaxError ("Error while parsing " ^ x)
|   tokenError (ProtoLexer.Key(x)) = raise SyntaxError ("Error while parsing" ^ x);

fun firstPoint (s) = 
	let val c = String.explode s
		fun iterate ([]) = []
		|	iterate (#"." :: _) = []
		|   iterate (x::xs) = x::iterate(xs)
	in
		String.implode (iterate c)
	end;
	
fun hoistName (context) (name) =
	let val s = firstPoint(name)
		val t = List.filter (fn (x,_) => x = s) context
	in
		case t of
			(_,x)::xs => x ^ name
		|           _ => name
	end;
	
fun messageHoist (prefix) (context) (Message(name, fields)) =
	let fun iterate (c) ([]) = []
		|	iterate (c) (x::xs) =
				case x of
					FieldMessage(Message(n, f)) => 
						(FieldMessage( messageHoist (prefix^name^".") (c) (Message(n,f)) ))  ::
						(iterate ((n, prefix^name^".") :: c) (xs))
				|   FieldEnum(Enum(n, f)) =>
						(FieldEnum(Enum(prefix^name^"."^n, f))) :: (iterate ((n, prefix^name^".") :: c) xs)
				|	MessageVariable(x,OTHER(s),y,z) =>
						(MessageVariable(x,OTHER(hoistName c (s)),y,z)) :: (iterate (c) (xs)) 
				|	MessageVariable(x,s,y,z) => (MessageVariable(x,s,y,z)) :: (iterate (c) (xs)) 
	in
		Message(prefix^name, iterate (context) fields)
	end;

fun typeMessageVariable(t) =
	case t of
		OTHER(x) => (subChar x) ^ ".t"
	|	INT32    => "int"
	|   STRING   => "string";
	
fun applySignatureVariable(MessageVariable(q, t, n, _)) =
	let val ts = typeMessageVariable(t)
	in
		if q = REPEATED then
			"\tval size_" ^ n ^ " : t -> int\n" ^
			"\tval get_" ^ n ^ " : t -> " ^ ts ^ " list\n" ^
			"\tval set_" ^ n ^ " : " ^ ts ^ " list -> t -> t\n" ^
			"\tval get_nth_" ^ n ^ " : int -> t -> " ^ ts ^ "\n" ^
			"\tval set_nth_" ^ n ^ " : int -> " ^ ts ^ " -> t -> t\n" ^
			"\tval lens_" ^ n ^ " : (t, " ^ ts ^ " list) Lens\n" ^
			"\tval lens_nth_" ^ n ^ " : int -> (t, " ^ ts ^ ") Lens\n"
		else
			"\tval has_" ^ n ^ " : t -> bool\n" ^
			"\tval get_" ^ n ^ " : t -> " ^ ts ^ "\n" ^
			"\tval set_" ^ n ^ " : " ^ ts ^ " -> t -> t\n" ^
			"\tval lens_" ^ n ^ " : (t, " ^ ts ^ ") Lens\n"
	end;
	
fun structGenerate (f) (variables) = 
	let val t = List.foldr (fn (x,y) => x ^ ", " ^ y) "" (List.map f variables)
	in
		if (List.length variables) = 0 then "{ " ^ t ^ "}"
		else  "{" ^ (String.substring(t, 0, (String.size t) - 2)) ^ "}"
	end;
	
fun applyMessageNew (MessageVariable(q, _, n, _)) = 
	if q = REPEATED then (toUpper n) ^ "=[]"
					else (toUpper n) ^ "=NONE";
					
fun applyMessageType (MessageVariable(q, t, n, _)) =
	let val ts = typeMessageVariable (t)
	in
		if q = REPEATED then (toUpper n) ^ " : " ^ ts ^ " list"
						else (toUpper n) ^ " : " ^ ts ^ " option"
	end;

fun applySet (alternative) (name) (MessageVariable(_, _, n, _)) =
	if name = n then (toUpper n) ^ "=" ^ alternative
				else (toUpper n) ^ "=(#" ^ (toUpper n) ^ " x)";
			
			
fun applyStructureVariable (var) (MessageVariable(q, t, n, _)) =
	let val ts = typeMessageVariable(t)
	in
		if q = REPEATED then 
			"\tfun size_" ^ n ^ " (x : t) = List.length (#" ^ (toUpper n) ^ " x)\n" ^
			"\tfun get_" ^ n ^ " (x : t) = (#" ^ (toUpper n) ^ " x)\n" ^
			"\tfun set_" ^ n ^ " value (x : t) = "  ^ (structGenerate (applySet "value" n) var) ^ "\n" ^
			"\tfun get_nth_" ^ n ^ " (pos : int) (x : t) = List.nth (#" ^ (toUpper n) ^ " x, pos)\n" ^
			"\tfun set_nth_" ^ n ^ " (pos : int) value (x : t) = " ^ 
				(structGenerate (applySet ("(List.take (# " ^ (toUpper n) ^ " x, pos)) @ (value :: (List.drop (#" ^ (toUpper n) ^ " x, pos + 1))) ") n) var) ^ "\n" ^
			"\tval lens_" ^ n ^ " = {get=get_" ^ n ^ ", set=set_" ^ n ^ "}\n" ^
			"\tfun lens_nth_" ^ n ^ " (n : int) = {get = (get_nth_" ^ n ^ " n), set = (set_nth_" ^ n ^ " n)}\n"
		else 
			"\tfun has_" ^ n ^ " (x : t) = Option.isSome (#" ^ (toUpper n) ^ " x)\n" ^
			"\tfun get_" ^ n ^ " (x : t) = Option.valOf (#" ^ (toUpper n) ^ " x)\n" ^
			"\tfun set_" ^ n ^ " (value : " ^ ts ^ ") (x : t) = " ^ (structGenerate (applySet "SOME(value)" n) var) ^ "\n" ^
			"\tval lens_" ^ n ^ " = { get = get_" ^ n ^ ", set = set_" ^ n ^ "}\n"
	end;
	
fun enumGenerate (Enum(name, fields)) = 
	let val t = List.foldr (fn ((n1, _), n2) => toUpper(n1) ^ "| " ^ n2) "" (fields)
		val tt = if List.length fields = 0 then t else String.substring(t, 0, (String.size t) - 2)
	in 
		"signature " ^ (toUpper (subChar name)) ^ " = sig\n" ^ 
		"\ttype t\n" ^
		(List.foldr (op^) "" (List.map (fn (x, _) => "\tval " ^ x ^ " : t\n") fields)) ^
		"end;\n" ^
		"structure " ^ (subChar name) ^ " :> " ^ (toUpper (subChar name)) ^ " = struct\n" ^
		"\tdatatype t = " ^ tt ^ "\n" ^
		(List.foldr (op^) "" (List.map (fn (x, _) => "\tval " ^ x ^ " = " ^ (toUpper x) ^ "\n") fields)) ^
		"end;\n"
	end;

fun messageGenerate (Message(name, fields)) =
	let fun isHoist(MessageVariable _) = false
		|   isHoist(_) = true
		val hoist = List.filter (isHoist) fields
		val var = List.filter (not o isHoist) fields
		fun applySignatureHoist (FieldMessage(x)) = messageGenerate(x)
		|	applySignatureHoist (FieldEnum(x)) = enumGenerate(x)
	in
		(List.foldr (op^) "" (List.map applySignatureHoist hoist)) ^ "\n" ^ 
		"signature " ^ (toUpper (subChar name)) ^ " = sig\n" ^ 
		"\ttype t\n" ^
		"\tval new : t\n" ^
		(List.foldr (op^) "" (List.map applySignatureVariable var)) ^ 
		"end;\n" ^ 
		"structure " ^ (subChar name) ^ " :> " ^ (toUpper (subChar name)) ^ " = struct\n" ^
		"\ttype t = " ^ (structGenerate (applyMessageType) var) ^ "\n" ^
		"\tval new = " ^ (structGenerate (applyMessageNew) var) ^ "\n" ^
		(List.foldr (op^) "" (List.map (applyStructureVariable var) var)) ^
		"end;\n"
	end;
	
fun transpile source (destination) =
	let val input = readFile source
		val tokens = ProtoLexer.scan input
		val (parsed, tok) = messageParser tokens
		val tree = case tok of
						[] => messageHoist "" [] (parsed)
					|   x::xs => tokenError x
		val result = 
			"type ('a,'b) Lens = {get: 'a -> 'b, set: 'b -> 'a -> 'a}\n\n" ^
			"fun get (lens : ('a, 'b) Lens) (data : 'a) = (#get lens) data\n" ^
			"fun set (lens : ('a, 'b) Lens) (value : 'b) (data : 'a) = (#set lens) value (data)\n\n" ^
			"infix +>\n" ^
			"fun (l : ('a, 'b) Lens) +> (r : ('b, 'c) Lens) : ('a, 'c) Lens =\n" ^
			"\t{\n" ^
			"\t\tget = fn x => (#get r) ((#get l) x),\n" ^
			"\t\tset = fn x => (fn y => (#set l) ((#set r) x ((#get l) y)) y)\n" ^
			"\t}\n\n" ^ (messageGenerate tree)
	in
		writeFile (destination, result)
	end;
	
val it = 3;