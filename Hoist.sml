(* The function determines the prefix of the string up to the first '.' *)
fun firstPoint (s) = 
	let val c = String.explode s
		fun iterate ([]) = []
		|	iterate (#"." :: _) = []
		|   iterate (x::xs) = x::iterate(xs)
	in
		String.implode (iterate c)
	end;
	
(* The function determines using the context, what prefix needs to be added to the name to hoist it.
	The context parameter is a list of pair of the form (message_name, prefix_to_add). The prefixes
	are base on the path from the root message to the nested ones. 
*)
fun hoistName (context) (name) =
	let val s = firstPoint(name)
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
	let fun isVariable(Variable(_)) = true
		|	isVariable(_) = false
		val variableList = List.filter (isVariable) fieldList
		fun hoistVariable (c) ([]) = []
		|	hoistVariable (c) (Variable(q, OTHER(w), n, i) :: xs) =
				Variable(q, OTHER(hoistName c w), n, i) :: (hoistVariable (c) (xs))
		|	hoistVariable (c) (Variable(w) :: xs) = Variable(w) :: (hoistVariable c (xs))
		|	hoistVariable (c) (_::xs) = raise SyntaxError("Unexpected message/enum in variable list")
		fun iterate (c) ([]) = Message(prefix^name, hoistVariable (c) (variableList)) :: answer
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
|	hoistProgram (c) (o::xs) =
		o:: (hoistProgram (c) (xs))
		
(* The function which implements the full hoisting of the program. It uses the helper function hoistProgram 
	by providing an initial empty context.*)
fun hoist (t) = hoistProgram [] t;