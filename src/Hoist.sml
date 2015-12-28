(* The function determines using the context, what prefix needs to be added to the name to hoist it.
	The context parameter is a list of pair of the form (message_name, prefix_to_add). The prefixes
	are base on the path from the root message to the nested ones. 
*)
fun hoistName (context) (name) =
	let val s = Substring.string ( Substring.takel (fn x => x <> #".") (Substring.full name))
		val t = List.find (fn (x,_) => x = s) context
	in
		case t of
			SOME(_,x) => x ^ name
		|           _ => raise SyntaxError("Unknown type " ^ name)
	end;
	
(* The function hoists a message. This consists of both pulling nested messages to the top-level and also
	renaming all field types to the new hoisted naming schemas. The parameters are as follows:
	- (name, fieldList) represents the message that need to be hoisted - See ProtoParser for the exact type
	- prefix represents the path to the current nested message (formed of the names separated by '.')
	- context is a list of pairs of the form (message_name, prefix_to_add).
	- answer represents a list of already hoisted elemens to the top level. The generated elements for the current message
		will be added at the beginning of this list in postorder (nested elements first then root
*)
fun hoistMessage (answer) (prefix) (context) ((name, fieldList)) =
	let fun isHoistable(NestedMessage(_)) = true
		|	isHoistable(NestedEnum(_)) = true
		|	isHoistable(_) = false
		val stableList = List.filter (not o isHoistable) fieldList
		fun hoistOneOf (c) ([]) = []
		|	hoistOneOf (c) ((OTHER(w), n, i)::xs) = (OTHER(hoistName c w), n, i) :: (hoistOneOf c (xs))
		|	hoistOneOf (c) ((t, n, i) :: xs) = (t, n, i) :: (hoistOneOf c (xs))
		fun hoistStable (c) ([]) = []
		|	hoistStable (c) (Variable(q, OTHER(w), n, i, d) :: xs) =
				Variable(q, OTHER(hoistName c w), n, i, d) :: (hoistStable (c) (xs))
		|	hoistStable (c) (Variable(w) :: xs) = Variable(w) :: (hoistStable c (xs))
		|	hoistStable (c) (OneOf(name, oneofFieldList) :: xs) = OneOf(name, hoistOneOf c (oneofFieldList)) :: (hoistStable c (xs))
		|	hoistStable (c) (_::xs) = raise SyntaxError("Unexpected message/enum in variable list")
		fun iterate (c) ([]) = Message(prefix^name, hoistStable (c) (stableList)) :: answer
		|	iterate (c) (NestedMessage(n1, l1)::xs) =
				hoistMessage (iterate ((n1, prefix^name^".")::c) (xs)) (prefix^name^".") (c) (n1, l1)
		|	iterate (c) (NestedEnum(n1, l1) ::xs) =
				hoistEnum (iterate ((n1, prefix^name^".")::c) (xs)) (prefix^name^".") (c) (n1, l1)
		|	iterate (c) (_::xs) = iterate (c) (xs)
	in
		iterate (context) (fieldList)
	end
(* The function hoists an enum. The parameters are the same as for hoistMesssage*)
and hoistEnum (answer) (prefix) (_) ((name, fieldList)) =
	Enum(prefix^name, fieldList)::answer
(* The function hoists a program, bringing all nested enums or messages to the top level.
	This is a helper function, requiring keeping track of a context (see hoistMessage for details).
*)
and hoistProgram (_) ([]) = []
|	hoistProgram (c) (Message(name, fieldList) :: xs) = 
		hoistMessage (hoistProgram ((name, "")::c) (xs)) ("") (c) (name, fieldList)
|	hoistProgram (c) (Enum(name, fieldList) :: xs) =
		hoistEnum (hoistProgram ((name, "")::c) (xs)) ("") (c) (name, fieldList)
|	hoistProgram (c) (opt::xs) =
		opt :: (hoistProgram (c) (xs))
		
(* The function which implements the full hoisting of the program. It uses the helper function hoistProgram 
	by providing an initial empty context.*)
fun hoist (t) = hoistProgram [] t;