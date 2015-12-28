(* The Protocol Buffer documentation describes what tags are valid
	[https://developers.google.com/protocol-buffers/docs/proto#assigning-tags]
*)
val kFirstTag = 1;
val kLastTag = 536870911;
val kFirstReservedTag = 19000;
val kLastReserverTag = 19999;

fun isValidEnumTag (x) = x >= 0;
fun isReservedTag (x) = (x >= kFirstReservedTag andalso x <= kLastReserverTag);
fun isValidMessageTag (x) = (x >= kFirstTag andalso x <= kLastTag andalso not(isReservedTag x));
fun isValidMessageFieldName ("") = false
|	isValidMessageFieldName (x) = Char.isAlpha(String.sub (x,0)) andalso (List.all (fn x => (Char.isAlphaNum x) orelse (x = #"_")) (String.explode x));
fun isValidMessageName ("") = false
|	isValidMessageName (x) = Char.isAlpha(String.sub (x,0)) andalso (List.all (fn x => (Char.isAlphaNum x) orelse (x = #".")) (String.explode x));
fun isValidEnumFieldName (s) = isValidMessageFieldName s;
fun isValidEnumName (s) = isValidMessageName s;

fun countAppearance l x = List.length (List.filter (fn y => x = y) l)

(*TODO check default values to be valid*)
fun verifyProgram (_) ([]) = true
|	verifyProgram (context) (Message(name, fieldList)::xs) =
	let fun getTags (Variable(_, _, _, i, _)) = [i]
		|	getTags (OneOf(_, fields)) = List.map (fn (_, _, i) => i) fields
		fun getNames (Variable(_, _, n, _, _)) = [n]
		|	getNames (OneOf(name, fields)) = name :: (List.map (fn (_, n, _) => n) fields)
		fun getTypes (Variable(_, t, _, _, _)) = [t]
		|	getTypes (OneOf(_, fields)) = List.map (fn (t, _, _) => t) fields
		val tags = List.foldr (op@) [] (List.map getTags (fieldList))
		val names = List.foldr (op@) [] (List.map getNames (fieldList))
		val types = List.foldr (op@) [] (List.map getTypes (fieldList))
	in
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
		if List.exists (fn x => case x of OTHER(w) => countAppearance context w = 0 | _ => false) types then raise SyntaxError("Unknown type in message " ^ name)
		else verifyProgram (name::context) (xs)
	end
|	verifyProgram (context) (Enum(name, fieldList)::xs) = 
	let val tags = List.map (fn (_, i) => i) fieldList
		val names = List.map (fn (n, _) => n) fieldList
	in
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
	
fun verify (l) = verifyProgram [] (l);
