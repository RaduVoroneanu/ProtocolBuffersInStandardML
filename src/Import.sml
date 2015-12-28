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

fun isImport (Import(_)) = true
|	isImport (_) = false;

val directoryDelimiter = #"/";

fun relativePath (original, relative) = 
	(Substring.string (Substring.dropr (fn x => x <> directoryDelimiter) (Substring.full original)) ) ^ relative;

fun import (s) = 
	let val input = readFile (s)
		val toks = ProtoLexer.scan input
		val (programFields, remaining) = programParser toks
		fun iterate ([]) = []
		|	iterate (x::xs) = 
				case x of
					Import(path) => (import (relativePath (s, Substring.string (Substring.substring (path, 1, String.size path - 2))))) @ (iterate xs)
				|	x => x :: (iterate xs)
	in
		case remaining of	
			[] => iterate (programFields)
		|	ProtoLexer.Id(x)::xs => raise SyntaxError("Syntax error while parsing " ^ x ^ " in " ^ s)
		|	ProtoLexer.Key(x)::xs => raise SyntaxError("Syntax error while parsing " ^ x ^ " in " ^ s)
	end;