exception LexError of string;

signature LEXER =
sig
	datatype token = Id of string | Key of string
	val scan : string -> token list
end;

signature KEYWORD =
sig
	val alphas : string list
	val symbols : string list
end;

functor Lexer (Keyword : KEYWORD) : LEXER =
struct
	datatype token = Key of string | Id of string
	
	fun member (x:string, l) = List.exists (fn y => x = y) l;
	
	fun alphaTok a = 
		if member(a, Keyword.alphas) then Key(a) else Id(a);
	
	fun symbolic (sy, ss) = 
		case Substring.getc ss of 
			 NONE => (Key sy, ss)
			|SOME (c, ss1) =>
				if member(sy, Keyword.symbols) orelse (not (Char.isPunct c))
				then (Key sy, ss)
				else symbolic (sy ^ (String.str c), ss1)
	
	fun stringId 0 (ss) = ("", ss)
	|	stringId (num) (ss) = 
		case Substring.getc ss of
			NONE => raise LexError ("Nonterminating string")
		|	SOME(#"\\", ss1) => 
				let val (l, r) = stringId (num + 1) (ss1)
				in	("\\" ^ l, r) end
		|	SOME(#"\"", ss1) =>
				let val (l, r) = stringId (num - 1) (ss1)
				in ("\"" ^ l, r) end
		|	SOME(c, ss1) =>
				let val (l, r) = stringId (num) (ss1)
				in (String.str c ^ l, r) end
				
	fun scanning (toks, ss) =
		case Substring.getc ss of
			NONE => rev toks
		|	SOME (#"/", ss1) => (
				case Substring.getc ss1 of
					SOME (#"/", ss2) => scanning (toks, Substring.triml 1 (Substring.dropl (fn x => x <> #"\n") ss2))
				|	_	=> raise LexError ("Invalid character \"/\"") )
		|	SOME (#"\"", ss1) =>
				let val (l, r) = stringId 1 ss1
				in
					scanning (Id("\"" ^ l)::toks, r)
				end
		|	SOME (c, ss1) => 
				if (Char.isAlphaNum c) orelse (c = #"-")
				then 
					let val (id, ss2) = Substring.splitl (fn x => (Char.isAlphaNum x) orelse (x = #".") orelse (x = #"_") orelse (x = #"-")) ss
						val tok = alphaTok (Substring.string id)
					in scanning(tok :: toks, ss2)
					end
				else 
				if Char.isPunct c
					then 
						let val (tok, ss2) = symbolic (String.str c, ss1)
						in scanning (tok :: toks, ss2)
						end
					else
						scanning (toks, Substring.dropl (not o Char.isGraph) ss);

	fun scan a = scanning ([], Substring.full a);
end
