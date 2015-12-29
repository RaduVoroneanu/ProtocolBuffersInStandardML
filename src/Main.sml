use "Lexer.sml";
use "Parser.sml";
use "ProtoParser2.sml";
use "Import.sml";
use "Hoist.sml";
use "Verify.sml";
use "Exception.sml";
use "Varint.sml";
use "TwoComplement.sml";
use "ZigZag.sml";

val result = import "../Examples/example4.proto"
val result = hoist result
val result = verify result;