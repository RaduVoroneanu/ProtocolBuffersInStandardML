signature Proto_Handler_Signature =
sig
	type descriptorType
	type protoType
	
	(* Descritor creation functions ----------------------------------------*)
	(* pattern:
		oneofs : (tag_list) -> old_descriptor -> new_descriptor
		message : (tag, message_descriptor) -> old_descriptor -> new_descriptor
		other : tag -> old_descriptor -> new_descriptor*
	*)
	val newDescriptor : descriptorType
	val descriptor_add_int32 : int -> descriptorType -> descriptorType
	val descriptor_add_int64 : int -> descriptorType -> descriptorType
	val descriptor_add_uint32 : int -> descriptorType -> descriptorType
	val descriptor_add_uint64 : int -> descriptorType -> descriptorType
	val descriptor_add_sint32 : int -> descriptorType -> descriptorType
	val descriptor_add_sint64 : int -> descriptorType -> descriptorType
	val descriptor_add_fixed32 : int -> descriptorType -> descriptorType
	val descriptor_add_fixed64 : int -> descriptorType -> descriptorType
	val descriptor_add_sfixed32 : int -> descriptorType -> descriptorType
	val descriptor_add_sfixed64 : int -> descriptorType -> descriptorType
	val descriptor_add_string : int -> descriptorType -> descriptorType
	val descriptor_add_bool : int -> descriptorType -> descriptorType
	val descriptor_add_message : (int * descriptorType) -> descriptorType -> descriptorType
	val descriptor_add_rint32 : int -> descriptorType -> descriptorType
	val descriptor_add_rint64 : int -> descriptorType -> descriptorType
	val descriptor_add_ruint32 : int -> descriptorType -> descriptorType
	val descriptor_add_ruint64 : int -> descriptorType -> descriptorType
	val descriptor_add_rsint32 : int -> descriptorType -> descriptorType
	val descriptor_add_rsint64 : int -> descriptorType -> descriptorType
	val descriptor_add_rfixed32 : int -> descriptorType -> descriptorType
	val descriptor_add_rfixed64 : int -> descriptorType -> descriptorType
	val descriptor_add_rsfixed32 : int -> descriptorType -> descriptorType
	val descriptor_add_rsfixed64 : int -> descriptorType -> descriptorType
	val descriptor_add_rstring : int -> descriptorType -> descriptorType
	val descriptor_add_rbool : int -> descriptorType -> descriptorType
	val descriptor_add_rmessage : (int * descriptorType) -> descriptorType -> descriptorType
	val descriptor_add_oneof : int list -> descriptorType -> descriptorType
	(* Descritor creation functions ----------------------------------------*)
	
	(* Proto abstract ------------------------------------------------------*)
	val newProto : protoType
	
	(* Singular Numeric Fields ---------------------------------------------*)
	(* int32 *)
	val proto_has_int32 : int -> protoType -> bool
	val proto_get_int32 : int -> int -> protoType -> int
	val proto_set_int32 : int -> int -> protoType -> protoType
	val proto_clear_int32 : int -> protoType -> protoType
	
	(* int64 *)
	val proto_has_int64 : int -> protoType -> bool
	val proto_get_int64 : int -> int -> protoType -> int
	val proto_set_int64 : int -> int -> protoType -> protoType
	val proto_clear_int64 : int -> protoType -> protoType
	
	(* uint32 *)
	val proto_has_uint32 : int -> protoType -> bool
	val proto_get_uint32 : int -> int -> protoType -> int
	val proto_set_uint32 : int -> int -> protoType -> protoType
	val proto_clear_uint32 : int -> protoType -> protoType
	
	(* uint64 *)
	val proto_has_uint64 : int -> protoType -> bool
	val proto_get_uint64 : int -> int -> protoType -> int
	val proto_set_uint64 : int -> int -> protoType -> protoType
	val proto_clear_uint64 : int -> protoType -> protoType
	
	(* sint32 *)
	val proto_has_sint32 : int -> protoType -> bool
	val proto_get_sint32 : int -> int -> protoType -> int
	val proto_set_sint32 : int -> int -> protoType -> protoType
	val proto_clear_sint32 : int -> protoType -> protoType
	
	(* sint64 *)
	val proto_has_sint64 : int -> protoType -> bool
	val proto_get_sint64 : int -> int -> protoType -> int
	val proto_set_sint64 : int -> int -> protoType -> protoType
	val proto_clear_sint64 : int -> protoType -> protoType
	
	(* fixed32 *)
	val proto_has_fixed32 : int -> protoType -> bool
	val proto_get_fixed32 : int -> int -> protoType -> int
	val proto_set_fixed32 : int -> int -> protoType -> protoType
	val proto_clear_fixed32 : int -> protoType -> protoType
	
	(* fixed64 *)
	val proto_has_fixed64 : int -> protoType -> bool
	val proto_get_fixed64 : int -> int -> protoType -> int
	val proto_set_fixed64 : int -> int -> protoType -> protoType
	val proto_clear_fixed64 : int -> protoType -> protoType
	
	(* sfixed32 *)
	val proto_has_sfixed32 : int -> protoType -> bool
	val proto_get_sfixed32 : int -> int -> protoType -> int
	val proto_set_sfixed32 : int -> int -> protoType -> protoType
	val proto_clear_sfixed32 : int -> protoType -> protoType
	
	(* sfixed64 *)
	val proto_has_sfixed64 : int -> protoType -> bool
	val proto_get_sfixed64 : int -> int -> protoType -> int
	val proto_set_sfixed64 : int -> int -> protoType -> protoType
	val proto_clear_sfixed64 : int -> protoType -> protoType
	
	(* bool *)
	val proto_has_bool : int -> protoType -> bool
	val proto_get_bool : int -> bool -> protoType -> bool
	val proto_set_bool : int -> bool -> protoType -> protoType
	val proto_clear_bool : int -> protoType -> protoType
	
	(* Singular Numeric fields ---------------------------------------------*)
	
	(* Singular String field -----------------------------------------------*)
	(* string *)
	val proto_has_string : int -> protoType -> bool
	val proto_get_string : int -> string -> protoType -> string
	val proto_set_string : int -> string -> protoType -> protoType
	val proto_clear_string : int -> protoType -> protoType
	(* Singular String field -----------------------------------------------*)
	
	(* Singular Embedded Message fields ------------------------------------*)
	(* message *)
	val proto_has_message : int -> protoType -> bool
	val proto_get_message : int -> protoType -> protoType -> protoType
	val proto_set_message : int -> protoType -> protoType -> protoType
	val proto_clear_message : int -> protoType -> protoType
	(* Singular Embedded Message fields ------------------------------------*)
	
	(* Repeated Numeric fields ---------------------------------------------*)
	(* pattern:
		size_* : tag -> proto -> size
		get_* : tag -> proto -> value
		set_* : tag -> new_value -> old_proto -> new_proto
		add_* : tag -> value -> old_proto -> new_proto
		clear_* : tag -> old_proto -> new_proto
		getnth_* : tag -> position -> proto -> value
		setnth_* : tag -> position -> value -> old_proto -> new_proto
	*)
	
	(* int32 *)
	val proto_repeated_size_int32 : int -> protoType -> int
	val proto_repeated_get_int32 : int -> protoType -> int list
	val proto_repeated_set_int32 : int -> int list -> protoType -> protoType
	val proto_repeated_add_int32 : int -> int -> protoType -> protoType
	val proto_repeated_clear_int32 : int -> protoType -> protoType
	val proto_repeated_getnth_int32 : int -> int -> protoType -> int
	val proto_repeated_setnth_int32 : int -> int -> int -> protoType -> protoType
	
	(* int64 *)
	val proto_repeated_size_int64 : int -> protoType -> int
	val proto_repeated_get_int64 : int -> protoType -> int list
	val proto_repeated_set_int64 : int -> int list -> protoType -> protoType
	val proto_repeated_add_int64 : int -> int -> protoType -> protoType
	val proto_repeated_clear_int64 : int -> protoType -> protoType
	val proto_repeated_getnth_int64 : int -> int -> protoType -> int
	val proto_repeated_setnth_int64 : int -> int -> int -> protoType -> protoType

	(* uint32 *)
	val proto_repeated_size_uint32 : int -> protoType -> int
	val proto_repeated_get_uint32 : int -> protoType -> int list
	val proto_repeated_set_uint32 : int -> int list -> protoType -> protoType
	val proto_repeated_add_uint32 : int -> int -> protoType -> protoType
	val proto_repeated_clear_uint32 : int -> protoType -> protoType
	val proto_repeated_getnth_uint32 : int -> int -> protoType -> int
	val proto_repeated_setnth_uint32 : int -> int -> int -> protoType -> protoType
	
	(* uint64 *)
	val proto_repeated_size_uint64 : int -> protoType -> int
	val proto_repeated_get_uint64 : int -> protoType -> int list
	val proto_repeated_set_uint64 : int -> int list -> protoType -> protoType
	val proto_repeated_add_uint64 : int -> int -> protoType -> protoType
	val proto_repeated_clear_uint64 : int -> protoType -> protoType
	val proto_repeated_getnth_uint64 : int -> int -> protoType -> int
	val proto_repeated_setnth_uint64 : int -> int -> int -> protoType -> protoType
	
	(* sint32 *)
	val proto_repeated_size_sint32 : int -> protoType -> int
	val proto_repeated_get_sint32 : int -> protoType -> int list
	val proto_repeated_set_sint32 : int -> int list -> protoType -> protoType
	val proto_repeated_add_sint32 : int -> int -> protoType -> protoType
	val proto_repeated_clear_sint32 : int -> protoType -> protoType
	val proto_repeated_getnth_sint32 : int -> int -> protoType -> int
	val proto_repeated_setnth_sint32 : int -> int -> int -> protoType -> protoType
	
	(* sint64 *)
	val proto_repeated_size_sint64 : int -> protoType -> int
	val proto_repeated_get_sint64 : int -> protoType -> int list
	val proto_repeated_set_sint64 : int -> int list -> protoType -> protoType
	val proto_repeated_add_sint64 : int -> int -> protoType -> protoType
	val proto_repeated_clear_sint64 : int -> protoType -> protoType
	val proto_repeated_getnth_sint64 : int -> int -> protoType -> int
	val proto_repeated_setnth_sint64 : int -> int -> int -> protoType -> protoType

	(* fixed32 *)
	val proto_repeated_size_fixed32 : int -> protoType -> int
	val proto_repeated_get_fixed32 : int -> protoType -> int list
	val proto_repeated_set_fixed32 : int -> int list -> protoType -> protoType
	val proto_repeated_add_fixed32 : int -> int -> protoType -> protoType
	val proto_repeated_clear_fixed32 : int -> protoType -> protoType
	val proto_repeated_getnth_fixed32 : int -> int -> protoType -> int
	val proto_repeated_setnth_fixed32 : int -> int -> int -> protoType -> protoType
	
	(* fixed64 *)
	val proto_repeated_size_fixed64 : int -> protoType -> int
	val proto_repeated_get_fixed64 : int -> protoType -> int list
	val proto_repeated_set_fixed64 : int -> int list -> protoType -> protoType
	val proto_repeated_add_fixed64 : int -> int -> protoType -> protoType
	val proto_repeated_clear_fixed64 : int -> protoType -> protoType
	val proto_repeated_getnth_fixed64 : int -> int -> protoType -> int
	val proto_repeated_setnth_fixed64 : int -> int -> int -> protoType -> protoType
	
	(* sfixed32 *)
	val proto_repeated_size_sfixed32 : int -> protoType -> int
	val proto_repeated_get_sfixed32 : int -> protoType -> int list
	val proto_repeated_set_sfixed32 : int -> int list -> protoType -> protoType
	val proto_repeated_add_sfixed32 : int -> int -> protoType -> protoType
	val proto_repeated_clear_sfixed32 : int -> protoType -> protoType
	val proto_repeated_getnth_sfixed32 : int -> int -> protoType -> int
	val proto_repeated_setnth_sfixed32 : int -> int -> int -> protoType -> protoType
	
	(* sfixed64 *)
	val proto_repeated_size_sfixed64 : int -> protoType -> int
	val proto_repeated_get_sfixed64 : int -> protoType -> int list
	val proto_repeated_set_sfixed64 : int -> int list -> protoType -> protoType
	val proto_repeated_add_sfixed64 : int -> int -> protoType -> protoType
	val proto_repeated_clear_sfixed64 : int -> protoType -> protoType
	val proto_repeated_getnth_sfixed64 : int -> int -> protoType -> int
	val proto_repeated_setnth_sfixed64 : int -> int -> int -> protoType -> protoType
	
	(* bool *)
	val proto_repeated_size_bool : int -> protoType -> int
	val proto_repeated_get_bool : int -> protoType -> bool list
	val proto_repeated_set_bool : int -> bool list -> protoType -> protoType
	val proto_repeated_add_bool : int -> bool -> protoType -> protoType
	val proto_repeated_clear_bool : int -> protoType -> protoType
	val proto_repeated_getnth_bool : int -> int -> protoType -> bool
	val proto_repeated_setnth_bool : int -> int -> bool -> protoType -> protoType
	(* Repeated Numeric fields ---------------------------------------------*)
	
	(* Repeated String field -----------------------------------------------*)
	(* string *)
	val proto_repeated_size_string : int -> protoType -> int
	val proto_repeated_get_string : int -> protoType -> string list
	val proto_repeated_set_string : int -> string list -> protoType -> protoType
	val proto_repeated_add_string : int -> string -> protoType -> protoType
	val proto_repeated_clear_string : int -> protoType -> protoType
	val proto_repeated_getnth_string : int -> int -> protoType -> string
	val proto_repeated_setnth_string : int -> int -> string -> protoType -> protoType
	(* Repeated String field -----------------------------------------------*)
	
	(* Repeated Embedded Message fields ------------------------------------*)
	(* message *)
	val proto_repeated_size_message : int -> protoType -> int
	val proto_repeated_get_message : int -> protoType -> protoType list
	val proto_repeated_set_message : int -> protoType list -> protoType -> protoType
	val proto_repeated_add_message : int -> protoType -> protoType -> protoType
	val proto_repeated_clear_message : int -> protoType -> protoType
	val proto_repeated_getnth_message : int -> int -> protoType -> protoType
	val proto_repeated_setnth_message : int -> int -> protoType -> protoType -> protoType
	(* Repeated Embedded Message fields ------------------------------------*)

	(* Oneofs function*)
	val proto_oneof_clear : int list -> protoType -> protoType
	val proto_oneof_case : int list -> protoType -> int option
	
	(* serialization / deserialization *)
	val serialize : protoType -> Word8.word list
	val deserialize : descriptorType -> Word8.word list -> protoType
end;

structure Proto :> Proto_Handler_Signature =
struct
	(* descriptorType and protoType *)
	datatype descriptorFieldType = 
									DInt32 |
									DInt64 |
									DUInt32 |
									DUInt64 |
									DSInt32 |
									DSInt64 |
									DFixed32 |
									DFixed64 |
									DSFixed32 |
									DSFixed64 |
									DString |
									DBool |
									DMessage of ((int * descriptorFieldType) list) * (int list list) |
									DRInt32 |
									DRInt64 |
									DRUInt32 |
									DRUInt64 |
									DRSInt32 |
									DRSInt64 |
									DRFixed32 |
									DRFixed64 |
									DRSFixed32 |
									DRSFixed64 |
									DRString |
									DRBool |
									DRMessage of ((int * descriptorFieldType) list) * (int list list)
	and	protoFieldType = 
									PInt of int |
									PFixed32 of int |
									PFixed64 of int |
									PString of string |
									PMessage of (int * protoFieldType) list |
									PRInt of int list |
									PRFixed32 of int list |
									PRFixed64 of int list |
									PRString of string list |
									PRMessage of ((int * protoFieldType) list) list
	
	type descriptorType = ((int * descriptorFieldType) list) * (int list list)
	type protoType = (int * protoFieldType) list
	
	
	(* Descriptor creator functions *)
	val newDescriptor = ([],[])
	
	fun descriptor_add (tag, value) ([]) = [(tag, value)]
	|	descriptor_add (tag, value) ((t, v) :: xs) = 
			if tag < t then (tag, value) :: (t, v) :: xs
			else if tag = t then (tag, value) :: xs
							else (t, v) :: (descriptor_add (tag, value) (xs))

	fun descriptor_add_int32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DInt32) (descriptorList), oneofs)
	fun descriptor_add_int64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DInt64) (descriptorList), oneofs)
	fun descriptor_add_uint32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DUInt32) (descriptorList), oneofs)
	fun descriptor_add_uint64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DUInt64) (descriptorList), oneofs)
	fun descriptor_add_sint32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DSInt32) (descriptorList), oneofs)
	fun descriptor_add_sint64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DSInt64) (descriptorList), oneofs)
	fun descriptor_add_fixed32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DFixed32) (descriptorList), oneofs)
	fun descriptor_add_fixed64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DFixed64) (descriptorList), oneofs)
	fun descriptor_add_sfixed32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DSFixed32) (descriptorList), oneofs)
	fun descriptor_add_sfixed64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DSFixed64) (descriptorList), oneofs)
	fun descriptor_add_string (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DString) (descriptorList), oneofs)
	fun descriptor_add_bool (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DBool) (descriptorList), oneofs)
	fun descriptor_add_message (tag, descriptor) ((descriptorList, oneofs)) = (descriptor_add (tag, DMessage(descriptor)) (descriptorList), oneofs)
	fun descriptor_add_rint32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRInt32) (descriptorList), oneofs)
	fun descriptor_add_rint64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRInt64) (descriptorList), oneofs)
	fun descriptor_add_ruint32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRUInt32) (descriptorList), oneofs)
	fun descriptor_add_ruint64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRUInt64) (descriptorList), oneofs)
	fun descriptor_add_rsint32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRSInt32) (descriptorList), oneofs)
	fun descriptor_add_rsint64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRSInt64) (descriptorList), oneofs)
	fun descriptor_add_rfixed32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRFixed32) (descriptorList), oneofs)
	fun descriptor_add_rfixed64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRFixed64) (descriptorList), oneofs)
	fun descriptor_add_rsfixed32 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRSFixed32) (descriptorList), oneofs)
	fun descriptor_add_rsfixed64 (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRSFixed64) (descriptorList), oneofs)
	fun descriptor_add_rstring (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRString) (descriptorList), oneofs)
	fun descriptor_add_rbool (tag) ((descriptorList, oneofs)) = (descriptor_add (tag, DRBool) (descriptorList), oneofs)
	fun descriptor_add_rmessage (tag, descriptor) ((descriptorList, oneofs)) = (descriptor_add (tag, DRMessage(descriptor)) (descriptorList), oneofs)
	fun descriptor_add_oneof (l) ((descriptorList, oneofs)) = (descriptorList, l::oneofs)
	
	(* Helper functions *)
	fun isPInt (_, PInt _) = true
	|	isPInt (_) = false
	fun isPFixed32 (_, PFixed32 _) = true
	|	isPFixed32 (_) = false
	fun isPFixed64 (_, PFixed64 _) = true
	|	isPFixed64 (_) = false
	fun isPString (_, PString _) = true
	|	isPString (_) = false
	fun isPMessage (_, PMessage _) = true
	|	isPMessage (_) = false
	fun isPRInt (_, PRInt _) = true
	|	isPRInt (_) = false
	fun isPRFixed32 (_, PRFixed32 _) = true
	|	isPRFixed32 (_) = false
	fun isPRFixed64 (_, PRFixed64 _) = true
	|	isPRFixed64 (_) = false
	fun isPRString (_, PRString _) = true
	|	isPRString (_) = false
	fun isPRMessage (_, PRMessage _) = true
	|	isPRMessage (_) = false
	fun equalsTag (tag) (t, _) = tag = t
	
	infix &&
	fun (f) && (g) = fn x => (f x) andalso (g x)
	
	
	(* Proto creator functions *)
	val newProto = []
	
	(* Helper generic proto functions *)
	fun proto_set (tag, value) ([]) = [(tag, value)]
	|	proto_set (tag, value) ((t, v) :: xs) = 
			if (tag < t) then (tag, value) :: (t, v) :: xs
			else 
				if (tag = t) then (tag, value) :: xs
				else (t, v) :: (proto_set (tag, value) (xs))
				
	fun proto_clear (tag) ([]) = []
	|	proto_clear (tag) ((t, v) :: xs) =
			if (tag < t) then (t, v) :: xs
			else 
				if (tag = t) then xs
				else (t, v) :: (proto_clear (tag) (xs))
				
				
	(* Singular int32 field *)
	fun proto_has_int32 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_int32 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => TwoComplement32.decode (x)
		|	_ => default
	fun proto_set_int32 (tag) (value) (proto) =
		if Limits.isValidint32 (value) then proto_set (tag, PInt(TwoComplement32.encode (value))) (proto)
										else raise InvalidSet("Value is not int32")
	fun proto_clear_int32 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular int64 field *)
	fun proto_has_int64 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_int64 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => TwoComplement64.decode x
		|	_ => default
	fun proto_set_int64 (tag) (value) (proto) =
		if Limits.isValidint64 (value) then proto_set (tag, PInt(TwoComplement64.encode (value))) (proto)
										else raise InvalidSet("Value is not int64")
	fun proto_clear_int64 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular uint32 field *)
	fun proto_has_uint32 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_uint32 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => x
		|	_ => default
	fun proto_set_uint32 (tag) (value) (proto) =
		if Limits.isValiduint32 (value) then proto_set (tag, PInt(value)) (proto)
										else raise InvalidSet("Value is not uint32")
	fun proto_clear_uint32 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular uint64 field *)
	fun proto_has_uint64 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_uint64 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => x
		|	_ => default
	fun proto_set_uint64 (tag) (value) (proto) =
		if Limits.isValiduint64 (value) then proto_set (tag, PInt(value)) (proto)
										else raise InvalidSet("Value is not uint64")
	fun proto_clear_uint64 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular sint32 field *)
	fun proto_has_sint32 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_sint32 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => ZigZag.decode x
		|	_ => default
	fun proto_set_sint32 (tag) (value) (proto) =
		if Limits.isValidsint32 (value) then proto_set (tag, PInt(ZigZag.encode (value))) (proto)
										else raise InvalidSet("Value is not sint32")
	fun proto_clear_sint32 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular sint64 field *)
	fun proto_has_sint64 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_sint64 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => ZigZag.decode x
		|	_ => default
	fun proto_set_sint64 (tag) (value) (proto) =
		if Limits.isValidsint64 (value) then proto_set (tag, PInt(ZigZag.encode (value))) (proto)
										else raise InvalidSet("Value is not sint64")
	fun proto_clear_sint64 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular fixed32 field *)
	fun proto_has_fixed32 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPFixed32) (proto))
	fun proto_get_fixed32 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPFixed32) (proto) of
			SOME(_, PFixed32 x) => x
		|	_ => default
	fun proto_set_fixed32 (tag) (value) (proto) =
		if Limits.isValidfixed32 (value) then proto_set (tag, PFixed32(value)) (proto)
										else raise InvalidSet("Value is not fixed32")
	fun proto_clear_fixed32 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular fixed64 field *)
	fun proto_has_fixed64 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPFixed64) (proto))
	fun proto_get_fixed64 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPFixed64) (proto) of
			SOME(_, PFixed64 x) => x
		|	_ => default
	fun proto_set_fixed64 (tag) (value) (proto) =
		if Limits.isValidfixed64 (value) then proto_set (tag, PFixed64(value)) (proto)
										else raise InvalidSet("Value is not fixed64")
	fun proto_clear_fixed64 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular sfixed32 field *)
	fun proto_has_sfixed32 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPFixed32) (proto))
	fun proto_get_sfixed32 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPFixed32) (proto) of
			SOME(_, PFixed32 x) => ZigZag.decode x
		|	_ => default
	fun proto_set_sfixed32 (tag) (value) (proto) =
		if Limits.isValidsfixed32 (value) then proto_set (tag, PFixed32(ZigZag.encode (value))) (proto)
										else raise InvalidSet("Value is not sfixed32")
	fun proto_clear_sfixed32 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular sfixed64 field *)
	fun proto_has_sfixed64 (tag) (proto) = isSome (List.find (equalsTag (tag) && isPFixed64) (proto))
	fun proto_get_sfixed64 (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPFixed64) (proto) of
			SOME(_, PFixed64 x) => ZigZag.decode x
		|	_ => default
	fun proto_set_sfixed64 (tag) (value) (proto) =
		if Limits.isValidsfixed64 (value) then proto_set (tag, PFixed64(ZigZag.encode (value))) (proto)
										else raise InvalidSet("Value is not sfixed64")
	fun proto_clear_sfixed64 (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular bool field *)
	fun proto_has_bool (tag) (proto) = isSome (List.find (equalsTag (tag) && isPInt) (proto))
	fun proto_get_bool (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPInt) (proto) of
			SOME(_, PInt x) => Boolean.decode x
		|	_ => default
	fun proto_set_bool (tag) (value) (proto) = proto_set (tag, PInt(Boolean.encode (value))) (proto)
	fun proto_clear_bool (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Singular string field *)
	fun proto_has_string (tag) (proto) = isSome (List.find (equalsTag (tag) && isPString) (proto))
	fun proto_get_string (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPString) (proto) of
			SOME(_, PString x) => x
		|	_ => default
	fun proto_set_string (tag) (value) (proto) = proto_set (tag, PString(value)) (proto)
	fun proto_clear_string (tag) (proto) = proto_clear (tag) (proto)

	
	(* Singular message field *)
	fun proto_has_message (tag) (proto) = isSome (List.find (equalsTag (tag) && isPMessage) (proto))
	fun proto_get_message (tag) (default) (proto) = 
		case List.find (equalsTag (tag) && isPMessage) (proto) of
			SOME(_, PMessage x) => x
		|	_ => default
	fun proto_set_message (tag) (value) (proto) = proto_set (tag, PMessage(value)) (proto)
	fun proto_clear_message (tag) (proto) = proto_clear (tag) (proto)
	
	
	(* Repeated helper functions *)
	fun list_set_position (position, value) (l) = List.take (l, position) @ (value::List.drop (l, position+1))
	
	
	(* Repeated int32 field *)
	fun proto_repeated_size_int32 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_int32 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => List.map (TwoComplement32.decode) value
		|	_ => []
	fun proto_repeated_set_int32 (tag) (value) (proto) = 
		if List.all (Limits.isValidint32) value then proto_set (tag, PRInt (List.map (TwoComplement32.encode) value)) proto
												else raise InvalidSet("Values in list are not all int32")
	fun proto_repeated_add_int32 (tag) (value) (proto) =
		if Limits.isValidint32 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [TwoComplement32.encode value])) proto
			|	_ => proto_set (tag, PRInt [TwoComplement32.encode value]) proto
		else raise InvalidSet("Value being added is not int32")
	fun proto_repeated_clear_int32 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_int32 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => TwoComplement32.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_int32 (tag) (position) (value) (proto) =
		if Limits.isValidint32 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, TwoComplement32.encode value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not int32")
		
	
	(* Repeated int64 field *)
	fun proto_repeated_size_int64 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_int64 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => List.map (TwoComplement64.decode) value
		|	_ => []
	fun proto_repeated_set_int64 (tag) (value) (proto) = 
		if List.all (Limits.isValidint64) value then proto_set (tag, PRInt (List.map (TwoComplement64.encode) value)) proto
												else raise InvalidSet("Values in list are not all int64")
	fun proto_repeated_add_int64 (tag) (value) (proto) =
		if Limits.isValidint64 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [TwoComplement64.encode value])) proto
			|	_ => proto_set (tag, PRInt [TwoComplement64.encode value]) proto
		else raise InvalidSet("Value being added is not int64")
	fun proto_repeated_clear_int64 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_int64 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => TwoComplement64.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_int64 (tag) (position) (value) (proto) =
		if Limits.isValidint64 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, TwoComplement64.encode value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not int64")
		
		
	(* Repeated uint32 field *)
	fun proto_repeated_size_uint32 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_uint32 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => value
		|	_ => []
	fun proto_repeated_set_uint32 (tag) (value) (proto) = 
		if List.all (Limits.isValiduint32) value then proto_set (tag, PRInt (value)) proto
												else raise InvalidSet("Values in list are not all uint32")
	fun proto_repeated_add_uint32 (tag) (value) (proto) =
		if Limits.isValiduint32 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [value])) proto
			|	_ => proto_set (tag, PRInt [value]) proto
		else raise InvalidSet("Value being added is not uint32")
	fun proto_repeated_clear_uint32 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_uint32 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_uint32 (tag) (position) (value) (proto) =
		if Limits.isValiduint32 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not uint32")
		
	
	(* Repeated uint64 field *)
	fun proto_repeated_size_uint64 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_uint64 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => value
		|	_ => []
	fun proto_repeated_set_uint64 (tag) (value) (proto) = 
		if List.all (Limits.isValiduint64) value then proto_set (tag, PRInt (value)) proto
												else raise InvalidSet("Values in list are not all uint64")
	fun proto_repeated_add_uint64 (tag) (value) (proto) =
		if Limits.isValiduint64 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [value])) proto
			|	_ => proto_set (tag, PRInt [value]) proto
		else raise InvalidSet("Value being added is not uint64")
	fun proto_repeated_clear_uint64 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_uint64 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => List.nth (value, position)
		|	_	=> raise Subscript
	fun proto_repeated_setnth_uint64 (tag) (position) (value) (proto) =
		if Limits.isValiduint64 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not uint64")
		
		
	(* Repeated sint32 field *)
	fun proto_repeated_size_sint32 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_sint32 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => List.map (ZigZag.decode) value
		|	_ => []
	fun proto_repeated_set_sint32 (tag) (value) (proto) = 
		if List.all (Limits.isValidsint32) value then proto_set (tag, PRInt (List.map (ZigZag.encode) value)) proto
												else raise InvalidSet("Values in list are not all sint32")
	fun proto_repeated_add_sint32 (tag) (value) (proto) =
		if Limits.isValidsint32 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [ZigZag.encode value])) proto
			|	_ => proto_set (tag, PRInt [ZigZag.encode value]) proto
		else raise InvalidSet("Value being added is not sint32")
	fun proto_repeated_clear_sint32 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_sint32 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => ZigZag.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_sint32 (tag) (position) (value) (proto) =
		if Limits.isValidsint32 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, ZigZag.encode value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not sint32")
		
	
	(* Repeated sint64 field *)
	fun proto_repeated_size_sint64 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_sint64 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => List.map (ZigZag.decode) value
		|	_ => []
	fun proto_repeated_set_sint64 (tag) (value) (proto) = 
		if List.all (Limits.isValidsint64) value then proto_set (tag, PRInt (List.map (ZigZag.encode) value)) proto
												else raise InvalidSet("Values in list are not all sint64")
	fun proto_repeated_add_sint64 (tag) (value) (proto) =
		if Limits.isValidsint64 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [ZigZag.encode value])) proto
			|	_ => proto_set (tag, PRInt [ZigZag.encode value]) proto
		else raise InvalidSet("Value being added is not sint64")
	fun proto_repeated_clear_sint64 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_sint64 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => ZigZag.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_sint64 (tag) (position) (value) (proto) =
		if Limits.isValidsint64 value then
			case List.find (equalsTag (tag) && isPRInt) proto of
				SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, ZigZag.encode value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not sint64")

		
	(* Repeated fixed32 field *)
	fun proto_repeated_size_fixed32 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed32) (proto) of
			SOME (_, PRFixed32 l) => List.length l
		|	_ => 0
	fun proto_repeated_get_fixed32 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRFixed32) proto of
			SOME(_, PRFixed32 value) => value
		|	_ => []
	fun proto_repeated_set_fixed32 (tag) (value) (proto) = 
		if List.all (Limits.isValidfixed32) value then proto_set (tag, PRFixed32 (value)) proto
												else raise InvalidSet("Values in list are not all fixed32")
	fun proto_repeated_add_fixed32 (tag) (value) (proto) =
		if Limits.isValidfixed32 value then
			case List.find (equalsTag (tag) && isPRFixed32) proto of
				SOME (_, PRFixed32 l) => proto_set (tag, PRFixed32 (l @ [value])) proto
			|	_ => proto_set (tag, PRFixed32 [value]) proto
		else raise InvalidSet("Value being added is not fixed32")
	fun proto_repeated_clear_fixed32 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_fixed32 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed32) proto of
			SOME (_, PRFixed32 value) => List.nth (value, position)
		|	_	=> raise Subscript
	fun proto_repeated_setnth_fixed32 (tag) (position) (value) (proto) =
		if Limits.isValidfixed32 value then
			case List.find (equalsTag (tag) && isPRFixed32) proto of
				SOME(_, PRFixed32 l) => proto_set (tag, PRFixed32 (list_set_position (position, value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not fixed32")
		
	
	(* Repeated fixed64 field *)
	fun proto_repeated_size_fixed64 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed64) (proto) of
			SOME (_, PRFixed64 l) => List.length l
		|	_ => 0
	fun proto_repeated_get_fixed64 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRFixed64) proto of
			SOME(_, PRFixed64 value) => value
		|	_ => []
	fun proto_repeated_set_fixed64 (tag) (value) (proto) = 
		if List.all (Limits.isValidfixed64) value then proto_set (tag, PRFixed64 (value)) proto
												else raise InvalidSet("Values in list are not all fixed64")
	fun proto_repeated_add_fixed64 (tag) (value) (proto) =
		if Limits.isValidfixed64 value then
			case List.find (equalsTag (tag) && isPRFixed64) proto of
				SOME (_, PRFixed64 l) => proto_set (tag, PRFixed64 (l @ [value])) proto
			|	_ => proto_set (tag, PRFixed64 [value]) proto
		else raise InvalidSet("Value being added is not fixed64")
	fun proto_repeated_clear_fixed64 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_fixed64 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed64) proto of
			SOME (_, PRFixed64 value) => List.nth (value, position)
		|	_	=> raise Subscript
	fun proto_repeated_setnth_fixed64 (tag) (position) (value) (proto) =
		if Limits.isValidfixed64 value then
			case List.find (equalsTag (tag) && isPRFixed64) proto of
				SOME(_, PRFixed64 l) => proto_set (tag, PRFixed64 (list_set_position (position, value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not fixed64")
		
		
	(* Repeated sfixed32 field *)
	fun proto_repeated_size_sfixed32 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed32) (proto) of
			SOME (_, PRFixed32 l) => List.length l
		|	_ => 0
	fun proto_repeated_get_sfixed32 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRFixed32) proto of
			SOME(_, PRFixed32 value) => List.map (ZigZag.decode) value
		|	_ => []
	fun proto_repeated_set_sfixed32 (tag) (value) (proto) = 
		if List.all (Limits.isValidsfixed32) value then proto_set (tag, PRFixed32 (List.map (ZigZag.encode) value)) proto
												else raise InvalidSet("Values in list are not all sfixed32")
	fun proto_repeated_add_sfixed32 (tag) (value) (proto) =
		if Limits.isValidsfixed32 value then
			case List.find (equalsTag (tag) && isPRFixed32) proto of
				SOME (_, PRFixed32 l) => proto_set (tag, PRFixed32 (l @ [ZigZag.encode value])) proto
			|	_ => proto_set (tag, PRFixed32 [ZigZag.encode value]) proto
		else raise InvalidSet("Value being added is not sfixed32")
	fun proto_repeated_clear_sfixed32 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_sfixed32 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed32) proto of
			SOME (_, PRFixed32 value) => ZigZag.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_sfixed32 (tag) (position) (value) (proto) =
		if Limits.isValidsfixed32 value then
			case List.find (equalsTag (tag) && isPRFixed32) proto of
				SOME(_, PRFixed32 l) => proto_set (tag, PRFixed32 (list_set_position (position, ZigZag.encode value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not sfixed32")
		
	
	(* Repeated sfixed64 field *)
	fun proto_repeated_size_sfixed64 (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed64) (proto) of
			SOME (_, PRFixed64 l) => List.length l
		|	_ => 0
	fun proto_repeated_get_sfixed64 (tag) (proto) =
		case List.find (equalsTag (tag) && isPRFixed64) proto of
			SOME(_, PRFixed64 value) => List.map (ZigZag.decode) value
		|	_ => []
	fun proto_repeated_set_sfixed64 (tag) (value) (proto) = 
		if List.all (Limits.isValidsfixed64) value then proto_set (tag, PRFixed64 (List.map (ZigZag.encode) value)) proto
												else raise InvalidSet("Values in list are not all sfixed64")
	fun proto_repeated_add_sfixed64 (tag) (value) (proto) =
		if Limits.isValidsfixed64 value then
			case List.find (equalsTag (tag) && isPRFixed64) proto of
				SOME (_, PRFixed64 l) => proto_set (tag, PRFixed64 (l @ [ZigZag.encode value])) proto
			|	_ => proto_set (tag, PRFixed64 [ZigZag.encode value]) proto
		else raise InvalidSet("Value being added is not sfixed64")
	fun proto_repeated_clear_sfixed64 (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_sfixed64 (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRFixed64) proto of
			SOME (_, PRFixed64 value) => ZigZag.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_sfixed64 (tag) (position) (value) (proto) =
		if Limits.isValidsfixed64 value then
			case List.find (equalsTag (tag) && isPRFixed64) proto of
				SOME(_, PRFixed64 l) => proto_set (tag, PRFixed64 (list_set_position (position, ZigZag.encode value) l)) proto
			|	_ => raise Subscript
		else raise InvalidSet("Value is not sfixed64")
		
	
	(* Repeated bool field *)
	fun proto_repeated_size_bool (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) (proto) of
			SOME (_, PRInt l) => List.length l
		|	_ => 0
	fun proto_repeated_get_bool (tag) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt value) => List.map (Boolean.decode) value
		|	_ => []
	fun proto_repeated_set_bool (tag) (value) (proto) =  proto_set (tag, PRInt (List.map (Boolean.encode) value)) proto
	fun proto_repeated_add_bool (tag) (value) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt l) => proto_set (tag, PRInt (l @ [Boolean.encode value])) proto
		|	_ => proto_set (tag, PRInt [Boolean.encode value]) proto
	fun proto_repeated_clear_bool (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_bool (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME (_, PRInt value) => Boolean.decode (List.nth (value, position))
		|	_	=> raise Subscript
	fun proto_repeated_setnth_bool (tag) (position) (value) (proto) =
		case List.find (equalsTag (tag) && isPRInt) proto of
			SOME(_, PRInt l) => proto_set (tag, PRInt (list_set_position (position, Boolean.encode value) l)) proto
		|	_ => raise Subscript
		
	
	(* Repeated string field *)
	fun proto_repeated_size_string (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRString) (proto) of
			SOME (_, PRString l) => List.length l
		|	_ => 0
	fun proto_repeated_get_string (tag) (proto) =
		case List.find (equalsTag (tag) && isPRString) proto of
			SOME(_, PRString value) => value
		|	_ => []
	fun proto_repeated_set_string (tag) (value) (proto) =  proto_set (tag, PRString (value)) proto
	fun proto_repeated_add_string (tag) (value) (proto) =
		case List.find (equalsTag (tag) && isPRString) proto of
			SOME (_, PRString l) => proto_set (tag, PRString (l @ [value])) proto
		|	_ => proto_set (tag, PRString [value]) proto
	fun proto_repeated_clear_string (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_string (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRString) proto of
			SOME (_, PRString value) => List.nth (value, position)
		|	_	=> raise Subscript
	fun proto_repeated_setnth_string (tag) (position) (value) (proto) =
		case List.find (equalsTag (tag) && isPRString) proto of
			SOME(_, PRString l) => proto_set (tag, PRString (list_set_position (position, value) l)) proto
		|	_ => raise Subscript
		
	
	(* Repeated message field *)
	fun proto_repeated_size_message (tag) (proto) = 
		case List.find (equalsTag (tag) && isPRMessage) (proto) of
			SOME (_, PRMessage l) => List.length l
		|	_ => 0
	fun proto_repeated_get_message (tag) (proto) =
		case List.find (equalsTag (tag) && isPRMessage) proto of
			SOME(_, PRMessage value) => value
		|	_ => []
	fun proto_repeated_set_message (tag) (value) (proto) =  proto_set (tag, PRMessage (value)) proto
	fun proto_repeated_add_message (tag) (value) (proto) =
		case List.find (equalsTag (tag) && isPRMessage) proto of
			SOME (_, PRMessage l) => proto_set (tag, PRMessage (l @ [value])) proto
		|	_ => proto_set (tag, PRMessage [value]) proto
	fun proto_repeated_clear_message (tag) (proto) = proto_clear (tag) proto
	fun proto_repeated_getnth_message (tag) (position) (proto) = 
		case List.find (equalsTag (tag) && isPRMessage) proto of
			SOME (_, PRMessage value) => List.nth (value, position)
		|	_	=> raise Subscript
	fun proto_repeated_setnth_message (tag) (position) (value) (proto) =
		case List.find (equalsTag (tag) && isPRMessage) proto of
			SOME(_, PRMessage l) => proto_set (tag, PRMessage (list_set_position (position, value) l)) proto
		|	_ => raise Subscript
	
	(* OneOf function *)
	fun memberOneof (x) (l) = isSome (List.find (fn y => x = y) l)
	
	fun proto_oneof_clear (oneofs) (proto) = List.filter (fn (tag, _) => not (memberOneof (tag) (oneofs))) proto
	fun proto_oneof_case (oneofs) (proto) =
		case List.find (fn (tag, _) => memberOneof (tag) (oneofs)) proto of
			SOME (t, _) => SOME(t)
		|	_ => NONE
	
	(* serialization *)
	val kWireVarint = 0
	val kWireFixed64 = 1
	val kWireLenghtDelimiter = 2
	val kWireFixed32 = 5
	
	fun serialize ([]) = []
	|	serialize ((tag, PInt value)::xs) = Varint.serialize (tag * 8 + kWireVarint)  @ ( Varint.serialize (value) @ serialize (xs))
	|	serialize ((tag, PFixed32 value) :: xs) = Varint.serialize (tag * 8 + kWireFixed32) @ (Fixed32.serialize (value) @ serialize (xs))
	|	serialize ((tag, PFixed64 value) :: xs) = Varint.serialize (tag * 8 + kWireFixed64) @ (Fixed64.serialize (value) @ serialize (xs))
	|	serialize ((tag, PString value) :: xs) = Varint.serialize (tag * 8 + kWireLenghtDelimiter) @ (StringHandler.serialize (value) @ serialize (xs))
	|	serialize ((tag, PMessage value) :: xs) = 
		let val l = serialize value 
		in
			Varint.serialize (tag * 8 + kWireLenghtDelimiter) @ (
				Varint.serialize (List.length l) @ (
					l @ serialize (xs)
				)
			)
		end
	|	serialize ((tag, PRInt value) :: xs) = serialize (List.map (fn x => (tag, PInt x)) value) @ serialize (xs)
	|	serialize ((tag, PRFixed32 value) :: xs) = serialize (List.map (fn x => (tag, PFixed32 x)) value) @ serialize (xs)
	|	serialize ((tag, PRFixed64 value) :: xs) = serialize (List.map (fn x => (tag, PFixed64 x)) value) @ serialize (xs)
	|	serialize ((tag, PRString value) :: xs) = serialize (List.map (fn x => (tag, PString x)) value) @ serialize (xs)
	|	serialize ((tag, PRMessage value) :: xs) = serialize (List.map (fn x => (tag, PMessage x)) value) @ serialize (xs)
	
	fun filterOneof (tag) ([]) (proto) = proto
	|	filterOneof (tag) (x::xs) (proto) =
			if memberOneof tag x then proto_oneof_clear x proto
			else filterOneof (tag) (xs) (proto)
			
	fun deserializeHelp (_) ([]) (result) = result
	|	deserializeHelp ((descriptor, oneofs)) (xs) (result) =
			let val (tag_wire, xs2) = Varint.deserialize (xs)
				val (tag, wire) = (tag_wire div 8, tag_wire mod 8)
				val dType = List.find (fn (t, _) => t = tag) descriptor
			in
				case (dType, wire) of
					(SOME (_, DInt32), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = TwoComplement32.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_int32 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DInt64), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = TwoComplement64.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_int64 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DUInt32), 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_uint32 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DUInt64), 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_uint64 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DSInt32), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_sint32 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DSInt64), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_sint64 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DBool), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = Boolean.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_bool tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DFixed32), 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_fixed32 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DFixed64), 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_fixed64 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DSFixed32), 5) => let val (value, xs3) = Fixed32.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_sfixed32 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DSFixed64), 1) => let val (value, xs3) = Fixed64.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_sfixed64 tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DString), 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_set_string tag value (filterOneof tag oneofs (result))) end
				|	(SOME (_, DMessage(d)), 2) => 
						let val (l, xs3) = Varint.deserialize (xs2)
							val value = deserialize d (List.take (xs3, l))
						in
							deserializeHelp ((descriptor, oneofs)) (List.drop (xs3, l)) (proto_set_message tag value (filterOneof tag oneofs (result)))
						end
				|	(SOME (_, DRInt32), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = TwoComplement32.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_int32 tag value (result)) end
				|	(SOME (_, DRInt64), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = TwoComplement64.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_int64 tag value (result)) end
				|	(SOME (_, DRUInt32), 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_uint32 tag value (result)) end
				|	(SOME (_, DRUInt64), 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_uint64 tag value (result)) end
				|	(SOME (_, DRSInt32), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_sint32 tag value (result)) end
				|	(SOME (_, DRSInt64), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_sint64 tag value (result)) end
				|	(SOME (_, DRBool), 0) => let val (value, xs3) = Varint.deserialize (xs2) val value = Boolean.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_bool tag value (result)) end
				|	(SOME (_, DRFixed32), 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_fixed32 tag value (result)) end
				|	(SOME (_, DRFixed64), 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_fixed64 tag value (result)) end
				|	(SOME (_, DRSFixed32), 5) => let val (value, xs3) = Fixed32.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_sfixed32 tag value (result)) end
				|	(SOME (_, DRSFixed64), 1) => let val (value, xs3) = Fixed64.deserialize (xs2) val value = ZigZag.decode value in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_sfixed64 tag value (result)) end
				|	(SOME (_, DRString), 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (proto_repeated_add_string tag value (result)) end
				|	(SOME (_, DRMessage(d)), 2) => 
						let val (l, xs3) = Varint.deserialize (xs2)
							val value = deserialize d (List.take (xs3, l))
						in
							deserializeHelp ((descriptor, oneofs)) (List.drop (xs3, l)) (proto_repeated_add_message tag value (result))
						end
				|	(_, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (result) end
				|	(_, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (result) end
				|	(_, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (xs3) (result) end
				|	(_, 2) => let val (l, xs3) = Varint.deserialize (xs2) in deserializeHelp ((descriptor, oneofs)) (List.drop (xs3,l)) (result) end
				|	(_, _) => raise DeserializationError ("Invalid wire found")
			end
	and deserialize (descriptor) (xs) = deserializeHelp (descriptor) (xs) (newProto) 
end;