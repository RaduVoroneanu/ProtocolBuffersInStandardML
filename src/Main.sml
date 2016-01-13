use "Lexer.sml";
use "Parser.sml";
use "ProtoParser2.sml";
use "Import.sml";
use "Hoist.sml";
use "Verify.sml";
use "Exception.sml";
use "Limits.sml";
use "Varint.sml";
use "StringHandler.sml";
use "TwoComplement.sml";
use "Boolean.sml";
use "ZigZag.sml";
use "Fixed.sml";
use "Lens.sml";
use "Proto.sml";
use "Defaults.sml";

val result = import "../Examples/example5.proto"
val result = hoist result
val result = verify result;

use "../Examples/example5_codelength.sml";