(* The Protocol Buffer documentation describes what tags are valid
	[https://developers.google.com/protocol-buffers/docs/proto#assigning-tags]
*)
val kFirstTag = 1;
val kLastTag = 536870911;
val kFirstReservedTag = 19000;
val kLastReserverTag = 19999;
val kPow32 = 4294967296;
val kPow64 = 18446744073709551616;

fun isValidEnumTag (x) = x >= 0;
fun isReservedTag (x) = (x >= kFirstReservedTag andalso x <= kLastReserverTag);
fun isValidMessageTag (x) = (x >= kFirstTag andalso x <= kLastTag andalso not(isReservedTag x));
fun isValidMessageFieldName ("") = false
|	isValidMessageFieldName (x) = Char.isAlpha(String.sub (x,0)) andalso (List.all (fn x => (Char.isAlphaNum x) orelse (x = #"_")) (String.explode x));
fun isValidMessageName ("") = false
|	isValidMessageName (x) = Char.isAlpha(String.sub (x,0)) andalso (List.all (fn x => (Char.isAlphaNum x) orelse (x = #".")) (String.explode x));
fun isValidEnumFieldName (s) = isValidMessageFieldName s;
fun isValidEnumName (s) = isValidMessageName s;
fun isValidInt32 (s) = 
	case Int.fromString s of	
		NONE => false
	|	SOME(x) => (x < kPow32 div 2) andalso (x >= ~kPow32 div 2);
fun isValidInt64 (s) = 
	case Int.fromString s of
		NONE => false
	|	SOME(x) => (x < kPow64 div 2) andalso (x >= ~kPow64 div 2);
fun isValidSInt32 (s) = isValidInt32 (s);
fun isValidSInt64 (s) = isValidSInt64 (s);
fun isValidUInt32 (s) = 
	case Int.fromString s of
		NONE => false
	|	SOME(x) => (x >= 0) andalso (x < kPow32);
fun isValidUInt64 (s) = 
	case Int.fromString s of
		NONE => false
	|	SOME(x) => (x >= 0) andalso (x < kPow64);
fun isValidBool (s) = isSome (Bool.fromString s);
fun isValidFixed32 (s) = isValidInt32 (s);
fun isValidSFixed32 (s) = isValidInt32 (s);
fun isValidFixed64 (s) = isValidInt64 (s);
fun isValidSFixed64 (s) = isValidInt64 (s);
fun isValidString (s) = (String.isPrefix "\"" s) andalso (String.isSuffix "\"" s);
fun isValidEnum (context) (name, s) =
	case List.find (fn (n,_) => n = name) context of
		NONE => false
	|	SOME(_, fieldList) => isSome (List.find (fn (x, _) => x = s) fieldList)

fun countAppearance l x = List.length (List.filter (fn y => x = y) l)

fun verifyProgram (_) ([]) = true
|	verifyProgram (context) (Message(name, fieldList)::xs) =
	let fun getTags (Variable(_, _, _, i, _)) = [i]
		|	getTags (OneOf(_, fields)) = List.map (fn (_, _, i) => i) fields
		|	getTags (_) = []
		fun getNames (Variable(_, _, n, _, _)) = [n]
		|	getNames (OneOf(name, fields)) = name :: (List.map (fn (_, n, _) => n) fields)
		|	getNames (_) = []
		fun getTypes (Variable(_, t, _, _, _)) = [t]
		|	getTypes (OneOf(_, fields)) = List.map (fn (t, _, _) => t) fields
		|	getTypes (_) = []
		val tags = List.foldr (op@) [] (List.map getTags (fieldList))
		val names = List.foldr (op@) [] (List.map getNames (fieldList))
		val types = List.foldr (op@) [] (List.map getTypes (fieldList))
	in
		if List.exists (fn x => x = name) context then raise SyntaxError("Duplicate name " ^ name)
		else
		if not(isValidMessageName(name)) then raise SyntaxError("Invalid message name " ^ name)
		else
		if List.exists (not o isValidMessageTag) tags then raise SyntaxError("Invalid tag in message " ^ name)
		else
		if List.exists (not o isValidMessageFieldName) names then raise SyntaxError("Invalid name in message " ^ name)
		else
		if List.exists (fn x => countAppearance tags x <> 1) tags then raise SyntaxError("Duplicate tag in message " ^ name)
		else
		if List.exists (fn x => countAppearance names x <> 1) names then raise SyntaxError("Duplicate name in message " ^ name)
		else
		if List.exists (fn x => case x of MESSAGE(w) => countAppearance context w = 0 
										| 	 ENUM(w) => countAppearance context w = 0
										| _ => false) 
						types then raise SyntaxError("Unknown type in message " ^ name)
		else verifyProgram (name::context) (xs)
	end
|	verifyProgram (context) (Enum(name, fieldList)::xs) = 
	let val tags = List.map (fn (_, i) => i) fieldList
		val names = List.map (fn (n, _) => n) fieldList
	in
		if List.exists (fn x => x = name) context then raise SyntaxError("Duplicate name " ^ name)
		else
		if not(isValidEnumName(name)) then raise SyntaxError("Invalid enum name " ^ name)
		else
		if List.exists (not o isValidEnumTag) tags then raise SyntaxError("Invalid tag in enum " ^ name)
		else
		if List.exists (not o isValidEnumFieldName) names then raise SyntaxError("Invalid name in enum " ^ name)
		else
		if List.exists (fn x => countAppearance tags x <> 1) tags then raise SyntaxError("Duplicate tag in enum " ^ name)
		else
		if List.exists (fn x => countAppearance names x <> 1) names then raise SyntaxError("Duplicate name in enum " ^ name)
		else verifyProgram (name::context) (xs)
	end
|	verifyProgram (context) (_::xs) = verifyProgram (context) (xs);
	
fun verifyDefault (_) ([]) = true
|	verifyDefault (context) (Message(name, fieldList)::xs) = 
		let val optList = List.filter (fn x => case x of Variable(OPTIONAL, _, _, _, SOME(_)) => true | _ => false) fieldList
			fun checkDefault (_) ([]) = true
			|	checkDefault (context) (Variable(_, MESSAGE(n), _, _, SOME(x))::xs) = raise SyntaxError ("Optional messages fields should not have default values " ^ name)
			|	checkDefault (context) (Variable(_, ENUM(n), _, _, SOME(x))::xs) = 
					if (isValidEnum context (n, x)) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default enum value for " ^ name ^ " in " ^ name)
			|	checkDefault (context) (Variable(_, INT32, _, _, SOME(x))::xs) = 
					if (isValidInt32 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default int32 value in " ^ name)
			|	checkDefault (context) (Variable(_, INT64, _, _, SOME(x))::xs) = 
					if (isValidInt64 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default int64 value in " ^ name)
			|	checkDefault (context) (Variable(_, SINT32, _, _, SOME(x))::xs) = 
					if (isValidSInt32 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default sint32 value in " ^ name)
			|	checkDefault (context) (Variable(_, SINT64, _, _, SOME(x))::xs) = 
					if (isValidSInt64 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default sint64 value in " ^ name)
			|	checkDefault (context) (Variable(_, UINT32, _, _, SOME(x))::xs) = 
					if (isValidUInt32 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default uint32 value in " ^ name)
			|	checkDefault (context) (Variable(_, UINT64, _, _, SOME(x))::xs) = 
					if (isValidUInt64 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default uint64 value in " ^ name)
			|	checkDefault (context) (Variable(_, BOOL, _, _, SOME(x))::xs) = 
					if (isValidBool x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default bool value in " ^ name)
			|	checkDefault (context) (Variable(_, FIXED32, _, _, SOME(x))::xs) = 
					if (isValidFixed32 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default fixed32 value in " ^ name)
			|	checkDefault (context) (Variable(_, SFIXED32, _, _, SOME(x))::xs) = 
					if (isValidSFixed32 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default sfixed32 value in " ^ name)
			|	checkDefault (context) (Variable(_, FIXED64, _, _, SOME(x))::xs) = 
					if (isValidFixed64 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default fixed64 value in " ^ name)
			|	checkDefault (context) (Variable(_, SFIXED64, _, _, SOME(x))::xs) = 
					if (isValidSFixed64 x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default sfixed64 value in " ^ name)
			|	checkDefault (context) (Variable(_, STRING, _, _, SOME(x))::xs) = 
					if (isValidString x) then (checkDefault (context) (xs))
					else raise SyntaxError("Invalid default string value in " ^ name)
			|	checkDefault (_) (_::xs) = raise SyntaxError("Unexpected case while checking default in " ^ name)
		in
			(checkDefault (context) (optList)) andalso (verifyDefault context (xs))
		end
|	verifyDefault (context) (Enum(name, fieldList)::xs) = verifyDefault ((name, fieldList)::context) (xs)
|	verifyDefault (context) (_::xs) = verifyDefault (context) (xs);

fun verify (l) = (verifyProgram [] (l)) andalso (verifyDefault [] (l));
