structure ProtoKeyword : KEYWORD = 
struct
	val alphas = ["message", "enum", "option", "optional", "required", "repeated", "int32", "int64", "uint32", "uint64", "sint32", "sint64", "bool", "fixed64", "sfixed64", "string", "fixed32", "sfixed32", "optimize_for"];
	val symbols = ["{", "}", ";", "="];
end;

structure ProtoLexer : LEXER = Lexer (ProtoKeyword);

structure ProtoParser : PARSER = Parser (ProtoLexer);

open ProtoParser;
	
datatype optimization = SPEED | CODE_SIZE
and		 variableQuantifier = OPTIONAL | REQUIRED | REPEATED
and		 variableType = INT32 | INT64 | UINT32 | UINT64 | SINT32 | SINT64 | BOOL | FIXED32 | FIXED64 | SFIXED32 | SFIXED64 | STRING | OTHER of string | MESSAGE of string | ENUM of string;

type variable = variableQuantifier * variableType * string * int
and  enumField = string * int

datatype messageField = NestedMessage of (string * (messageField list)) |
						NestedEnum of (string * (enumField list)) |
						Variable of variable
and		 programField = Message of (string * (messageField list)) |
						Enum of (string * (enumField list)) |
						Option of optimization
						
type message = string * (messageField list)
type enum = string * (enumField list)
type program = programField list
	
fun stringToInt (s) = 
	case (Int.fromString s) of
				NONE => raise SyntaxError ("Tag not a number")
			| 	SOME q => q;
			
fun variableConstruct (((x,y),z), t) =
	let val x1 = case x of
					"optional" => OPTIONAL
				|	"required" => REQUIRED
				|	"repeated" => REPEATED
				|	w => raise SyntaxError ("Unexpected quantifier " ^ w)
		val y1 = case y of
					"int32" => INT32
				|	"int64" => INT64
				|	"uint32" => UINT32
				|	"uint64" => UINT64
				|	"sint32" => SINT32
				|	"sint64" => SINT64
				|	"bool" => BOOL
				|	"fixed32" => FIXED32
				|	"fixed64" => FIXED64
				|	"sfixed32" => SFIXED32
				|	"sfixed64" => SFIXED64
				|	"string" => STRING
				|	w => OTHER(w)
		val t1 = stringToInt t
	in
		(x1, y1, z, t1)
	end;
	
fun optimizationConstruct (x) =
	case x of
		"SPEED" => SPEED
	|	"CODE_SIZE" => CODE_SIZE
	|	w => raise SyntaxError ("Optimization " ^ w ^ " not supported");
	
fun optimizationParser (x) = (($"option" !-- $"optimize_for" !-- $"=" !-- id --! $";") >> optimizationConstruct ) x
and variableParser (x) = ((($"optional" || $"required" || $"repeated") -- 
						 ($"int32" || $"int64" || $"uint32" || $"uint64" || $"sint32" || $"sint64" || $"bool" || $"fixed32" || $"fixed64" || $"sfixed32" || $"sfixed64" || $"string" || id) 
						 -- id --! $"=" -- id --! $";") >> variableConstruct) x
and messageParser (x) = ($"message" !-- id --! $"{" -- (repeat messageFieldParser) --! $"}") x
and enumParser (x) = ($"enum" !-- id --! $"{" -- (repeat enumFieldParser) --! $"}") x
and programParser (x) = (repeat programFieldParser) x
and messageFieldParser (x) = ((messageParser >> NestedMessage) || (enumParser >> NestedEnum) || (variableParser >> Variable)) x
and enumFieldParser (x) = (id --! $"=" -- (id >> stringToInt) --! $";") x
and programFieldParser (x) = ((messageParser >> Message) || (enumParser >> Enum) || (optimizationParser >> Option) ) x;

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

val (tree, l) = programParser (ProtoLexer.scan (readFile "example4.proto"));
case l of 
	[] => true
|	x::xs => raise SyntaxError("Couldn't parse all file");

val hoistedTree = hoist tree;
val correct = verify hoistedTree;