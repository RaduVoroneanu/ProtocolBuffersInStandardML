(* The Protocol Buffer documentation describes what tags are valid
	[https://developers.google.com/protocol-buffers/docs/proto#assigning-tags]
*)
(* message tags have to be at least 1*)
val kFirstTag = 1;
val kLastTag = 536870911;
val kFirstReservedTag = 19000;
val kLastReserverTag = 19999;
fun isValidEnumTag (x) = x >= 0;
fun isReservedTag (x) = (x >= kFirstReservedTag andalso x <= kLastReserverTag);
fun isValidMessageTag (x) = (x >= kFirstTag andalso x <= kLastTag andalso not(isReservedTag x));
fun countAppearance l x = List.length (List.filter (fn y => x = y) l)

fun verifyProgram (_) ([]) = true
|	verifyProgram (context) (Message(name, fieldList)::xs) =
	let val tags = List.map (fn Variable(_, _, _, i) => i) fieldList
		val names = List.map (fn Variable(_, _, n, _) => n) fieldList
		val types = List.map (fn Variable(_, t, _, _) => t) fieldList
	in
		if List.exists (not o isValidMessageTag) tags then raise SyntaxError("Invalid tag in message " ^ name)
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
		if List.exists (not o isValidEnumTag) tags then raise SyntaxError("Invalid tag in enum " ^ name)
		else
		if List.exists (fn x => countAppearance tags x <> 1) tags then raise SyntaxError("Duplicate tag in enum " ^ name)
		else
		if List.exists (fn x => countAppearance names x <> 1) names then raise SyntaxError("Duplicate name in enum " ^ name)
		else verifyProgram (name::context) (xs)
	end
|	verifyProgram (context) (_::xs) = verifyProgram (context) (xs);
	
fun verify (l) = verifyProgram [] (l);
