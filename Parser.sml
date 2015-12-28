signature PARSER =
sig
	exception SyntaxError of string
	type token
	val id : token list -> string * token list
	val $ : string -> token list -> string * token list
	val empty : 'a -> 'b list * 'a
	val || : ('a -> 'b) * ('a -> 'b) -> 'a -> 'b
	val !! : ('a -> 'b * 'c) -> 'a -> 'b * 'c
	val -- : ('a -> 'b * 'c) * ('c -> 'd * 'e) -> 'a -> ('b * 'd) * 'e
	val !-- : ('a -> 'b * 'c) * ('c -> 'd * 'e) -> 'a -> 'd * 'e
	val --! : ('a -> 'b * 'c) * ('c -> 'd * 'e) -> 'a -> 'b * 'e
	val >> : ('a -> 'b * 'c) * ('b -> 'd) -> 'a -> 'd * 'c
	val repeat : ('a -> 'b * 'a) -> 'a -> 'b list * 'a
end;
	
exception Fail of string;

infix 0 ||;
infix 1 >>;
infix 2 --;
infix 2 !--;
infix 2 --!;

functor Parser (Lex : LEXER) : PARSER =
struct

	exception SyntaxError of string;
	
	type token = Lex.token;

	fun id (Lex.Id(x) :: xs) = (x, xs)
	|	id (_) 				 = raise SyntaxError("Identifier not found");
	
	fun $ s (Lex.Key(x) :: xs) =
		if s = x
		then (x, xs)
		else raise SyntaxError(s ^ " expected but " ^ x ^ " found")
	|   $ s (Lex.Id(x) :: xs) = raise SyntaxError(s ^ " expected but " ^ x ^ " found")
	|	$ s ([]) = raise SyntaxError(s ^ " expected but nothing found");
	
	fun empty xs = ([], xs);
	
	fun (ph1 || ph2) (xs) = ph1 xs
						  handle SyntaxError _ => ph2 xs;
	
	fun !! ph (xs) = ph xs
					 handle SyntaxError msg => raise Fail ("Syntax error: " ^ msg);
	
	fun (ph1 -- ph2) (xs) = 
		let val (h1, t1) = ph1 (xs)
			val (h2, t2) = ph2 (t1)
		in
			((h1,h2), t2)
		end;
	
	fun (ph1 !-- ph2) (xs) = 
		let val (h1, t1) = ph1 (xs)
			val (h2, t2) = ph2 (t1)
		in
			(h2, t2)
		end;
		
	fun (ph1 --! ph2) (xs) = 
		let val (h1, t1) = ph1 (xs)
			val (h2, t2) = ph2 (t1)
		in
			(h1, t2)
		end;
	
	fun (ph >> f) (xs) =
		let val (h, t) = ph (xs)
		in 
			(f h, t)
		end;
	
	fun repeat ph (xs) = ( ( (ph -- (repeat ph)) >> (op::) ) || empty ) (xs);
end
