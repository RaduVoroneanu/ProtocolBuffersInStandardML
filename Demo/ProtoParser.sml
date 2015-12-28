use "Parser.sml";

structure ProtoKeyword : KEYWORD =
struct
	val alphas = ["enum", "message", "optional", "repeated", "required", "int32", "string"];
	val symbols = ["{", "}", ";", "="];
end;

structure ProtoLexer : LEXER = Lexer (ProtoKeyword);

structure ProtoParser : PARSER = Parser (ProtoLexer);
open ProtoParser;

datatype message  = Message of (string * (messageField list))
and 	 enum = Enum of (string * ((string*int) list))
and      messageField = FieldMessage of message | MessageVariable of (messageVariableQuantifier * messageVariableType * string * int) | FieldEnum of enum
and      messageVariableQuantifier = OPTIONAL | REPEATED | REQUIRED
and      messageVariableType = INT32 | STRING | OTHER of string

fun stringToInt (s) = 
	case (Int.fromString s) of
				NONE => raise SyntaxError ("Tag not a number")
			| 	SOME q => q;
			
fun messageVariableConstruct (((x,y),z),t) = 
	let val x1 = 
			case x of
				"optional" => OPTIONAL
			|	"repeated" => REPEATED
			|	"required" => REQUIRED
		val y1 = 
			case y of 
				"int32" => INT32
			|	"string" => STRING
			|   w       => OTHER(w)
		val t1 = stringToInt t
	in
		MessageVariable(x1, y1, z, t1)
	end;

fun messageParser (x) = (($"message" !-- (id) --! ($"{") -- (repeat messageFieldParser) --! ($"}")) >> Message) x
and messageFieldParser (x) = ((messageParser >> FieldMessage) || (messageVariableParser >> messageVariableConstruct) || (enumParser >> FieldEnum)) x
and messageVariableParser (x) = (($"optional" || $"repeated" || $"required") -- 
								($"int32" || ($"string") || (id)) -- (id) --!
								($"=") -- (id) --! ($";")) x
and enumParser (x) = ( (($"enum") !-- (id) --! ($"{") -- (repeat enumVariableParser) --! ($"}")) >> Enum ) x
and enumVariableParser (x) = ((id) --! ($"=") -- ((id) >> stringToInt) --! ($";")) x;
								