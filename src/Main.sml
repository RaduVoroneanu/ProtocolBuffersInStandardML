use "Lexer.sml";
use "Parser.sml";
use "ProtoParser2.sml";
use "Import.sml";
use "Hoist.sml";

val result = import "../Examples/example4.proto"
val result = hoist result;