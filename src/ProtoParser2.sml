structure ProtoKeyword : KEYWORD = 
struct
	val alphas = ["message", "enum", "option", "optional", "required", "repeated", "int32", "int64", "uint32", "uint64", "sint32", "sint64", "bool", "fixed64", "sfixed64", "string", "fixed32", "sfixed32", "optimize_for", "import", "oneof", "default", "service", "rpc", "returns"];
	val symbols = ["{", "}", ";", "=", "[", "]", "(", ")"];
end;

structure ProtoLexer : LEXER = Lexer (ProtoKeyword);

structure ProtoParser : PARSER = Parser (ProtoLexer);

open ProtoParser;
	
datatype optimization = SPEED | CODE_SIZE
and		 variableQuantifier = OPTIONAL | REQUIRED | REPEATED
and		 variableType = INT32 | INT64 | UINT32 | UINT64 | SINT32 | SINT64 | BOOL | FIXED32 | FIXED64 | SFIXED32 | SFIXED64 | STRING | OTHER of string | MESSAGE of string | ENUM of string;

type variable = variableQuantifier * variableType * string * int * (string option)
and  enumField = string * int
and  oneofField = variableType * string * int

datatype messageField = NestedMessage of (string * (messageField list)) |
						NestedEnum of (string * (enumField list)) |
						Variable of variable |
						OneOf of (string * oneofField list)
and		 programField = Message of (string * (messageField list)) |
						Enum of (string * (enumField list)) |
						Option of optimization |
						Import of string |
						Service of string * ((string * string * string) list)
						
type message = string * (messageField list)
type enum = string * (enumField list)
type program = programField list
	
fun stringToInt (s) = 
	case (Int.fromString s) of
				NONE => raise SyntaxError ("Tag not a number")
			| 	SOME q => q;
			
fun variableQuantifierConstruct (x) =
	case x of
		"optional" => OPTIONAL
	|	"required" => REQUIRED
	|	"repeated" => REPEATED
	|	w => raise SyntaxError ("Unexpected quantifier " ^ w)

fun variableTypeConstruct (y) =
	case y of
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

fun variableConstruct4 (((x,y),z), t) = (x, y, z, t, NONE);
fun variableConstruct5 ((((x, y), z), t), w) = (x, y, z, t, w);
fun oneofConstruct ((x, y), z) = (x, y, z);
fun rpcContruct ((x, y), z) = (x, y, z);
	
fun optimizationConstruct (x) =
	case x of
		"SPEED" => SPEED
	|	"CODE_SIZE" => CODE_SIZE
	|	w => raise SyntaxError ("Optimization " ^ w ^ " not supported");
	
fun optimizationParser (x) = (($"option" !-- $"optimize_for" !-- $"=" !-- id --! $";") >> optimizationConstruct ) x
and importParser (x) = (($"import" !-- id --! $";")) x
and variableQuantifierParser (x) = (($"optional" || $"required" || $"repeated") >> variableQuantifierConstruct) x
and variableTypeParser (x) = (($"int32" || $"int64" || $"uint32" || $"uint64" || $"sint32" || $"sint64" || $"bool" || $"fixed32" || $"fixed64" || $"sfixed32" || $"sfixed64" || $"string" || id) >> variableTypeConstruct) x
and variableParser (x) = (
							(( variableQuantifierParser -- variableTypeParser -- id --! $"=" -- (id >> stringToInt) --! $";") >> variableConstruct4)
							|| 
							(( (($"optional") >> variableQuantifierConstruct) -- variableTypeParser -- id --! $"=" -- (id >> stringToInt) --! $"[" --! $"default" --! $"=" -- (id >> SOME) --! $"]" --! $";") >> variableConstruct5) 
						) x
and rpcParser (x) = (($"rpc" !-- id --! $"(" -- id --! $")" --! $"returns" --! $"(" -- id --! $")" --! $";") >> rpcContruct ) x
and messageParser (x) = ($"message" !-- id --! $"{" -- (repeat messageFieldParser) --! $"}") x
and enumParser (x) = ($"enum" !-- id --! $"{" -- (repeat enumFieldParser) --! $"}") x
and oneofParser (x) = ($"oneof" !-- id --! $"{" -- (repeat oneofFieldParser) --! $"}") x
and serviceParser (x) = ($"service" !-- id --! $"{" -- (repeat rpcParser) --! $"}") x
and programParser (x) = (repeat programFieldParser) x
and messageFieldParser (x) = ((messageParser >> NestedMessage) || (enumParser >> NestedEnum) || (variableParser >> Variable) || (oneofParser >> OneOf)) x
and enumFieldParser (x) = (id --! $"=" -- (id >> stringToInt) --! $";") x
and oneofFieldParser (x) = ((variableTypeParser -- id --! $"=" -- (id >> stringToInt) --! $";") >> oneofConstruct) x
and programFieldParser (x) = ((messageParser >> Message) || (enumParser >> Enum) || (optimizationParser >> Option) || (importParser >> Import) || (serviceParser >> Service)) x;
