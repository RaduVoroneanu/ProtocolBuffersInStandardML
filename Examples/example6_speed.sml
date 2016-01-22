structure MainMessage2_NestedEnum =
struct
	datatype t = CASE0 | CASE1 | CASE2

	val kCASE0 = CASE0
	val kCASE1 = CASE1
	val kCASE2 = CASE2
	val kdefault = CASE0

	fun toInt (CASE0) = 0
	|	toInt (CASE1) = 1
	|	toInt (CASE2) = 2

	fun fromInt (0) = CASE0
	|	fromInt (1) = CASE1
	|	fromInt (2) = CASE2
	|	fromInt (_) = CASE0
end;

signature MAINMESSAGE2_NESTEDMESSAGE =
sig
	type t
	val new : t
	val descriptor : Proto.descriptorType
	
	val kfield1Tag : int
	val kfield2Tag : int
	val kfield3Tag : int
	val kfield4Tag : int
	val kfield5Tag : int
	val kfield6Tag : int
	val kfield7Tag : int
	val kfield8Tag : int
	val kfield9Tag : int
	val kfield10Tag : int
	val kfield11Tag : int
	val kfield12Tag : int
	val kfield13Tag : int
	
	val has_field1 : t -> bool
	val get_field1 : t -> int
	val set_field1 : int -> t -> t
	val clear_field1 : t -> t
	val lens_field1 : (t, int) Lens

	val has_field2 : t -> bool
	val get_field2 : t -> int
	val set_field2 : int -> t -> t
	val clear_field2 : t -> t
	val lens_field2 : (t, int) Lens

	val has_field3 : t -> bool
	val get_field3 : t -> int
	val set_field3 : int -> t -> t
	val clear_field3 : t -> t
	val lens_field3 : (t, int) Lens

	val has_field4 : t -> bool
	val get_field4 : t -> int
	val set_field4 : int -> t -> t
	val clear_field4 : t -> t
	val lens_field4 : (t, int) Lens

	val has_field5 : t -> bool
	val get_field5 : t -> int
	val set_field5 : int -> t -> t
	val clear_field5 : t -> t
	val lens_field5 : (t, int) Lens

	val has_field6 : t -> bool
	val get_field6 : t -> int
	val set_field6 : int -> t -> t
	val clear_field6 : t -> t
	val lens_field6 : (t, int) Lens

	val has_field7 : t -> bool
	val get_field7 : t -> bool
	val set_field7 : bool -> t -> t
	val clear_field7 : t -> t
	val lens_field7 : (t, bool) Lens

	val has_field8 : t -> bool
	val get_field8 : t -> MainMessage2_NestedEnum.t
	val set_field8 : MainMessage2_NestedEnum.t -> t -> t
	val clear_field8 : t -> t
	val lens_field8 : (t, MainMessage2_NestedEnum.t) Lens

	val has_field9 : t -> bool
	val get_field9 : t -> int
	val set_field9 : int -> t -> t
	val clear_field9 : t -> t
	val lens_field9 : (t, int) Lens

	val has_field10 : t -> bool
	val get_field10 : t -> int
	val set_field10 : int -> t -> t
	val clear_field10 : t -> t
	val lens_field10 : (t, int) Lens

	val has_field11 : t -> bool
	val get_field11 : t -> int
	val set_field11 : int -> t -> t
	val clear_field11 : t -> t
	val lens_field11 : (t, int) Lens

	val has_field12 : t -> bool
	val get_field12 : t -> int
	val set_field12 : int -> t -> t
	val clear_field12 : t -> t
	val lens_field12 : (t, int) Lens

	val has_field13 : t -> bool
	val get_field13 : t -> string
	val set_field13 : string -> t -> t
	val clear_field13 : t -> t
	val lens_field13 : (t, string) Lens

	val isValid : t -> bool
	val serializeUnsafe : t -> Word8.word list
	val deserializeUnsafe : Word8.word list -> t
	val serialize : t -> Word8.word list
	val deserialize : Word8.word list -> t
end;
structure MainMessage2_NestedMessage :> MAINMESSAGE2_NESTEDMESSAGE =
struct
	type t = { FIELD1: int option, FIELD2: int option, FIELD3 : int option, FIELD4 : int option, FIELD5 : int option, FIELD6 : int option, FIELD7 : bool option, FIELD8 : MainMessage2_NestedEnum.t option, FIELD9 : int option, FIELD10 : int option, FIELD11 : int option, FIELD12 : int option, FIELD13 : string option }
	val new = { FIELD1 = NONE, FIELD2 = NONE, FIELD3 = NONE, FIELD4 = NONE, FIELD5 = NONE, FIELD6 = NONE, FIELD7 = NONE, FIELD8 = NONE, FIELD9 = NONE, FIELD10 = NONE, FIELD11 = NONE, FIELD12 = NONE, FIELD13 = NONE }
	
	val kfield1Tag = 1
	val kfield2Tag = 2
	val kfield3Tag = 3
	val kfield4Tag = 4
	val kfield5Tag = 5
	val kfield6Tag = 6
	val kfield7Tag = 7
	val kfield8Tag = 8
	val kfield9Tag = 9
	val kfield10Tag = 10
	val kfield11Tag = 11
	val kfield12Tag = 12
	val kfield13Tag = 13
	
	val descriptor = Proto.newDescriptor
	val descriptor = Proto.descriptor_add_rint32 kfield1Tag descriptor
	val descriptor = Proto.descriptor_add_rint64 kfield2Tag descriptor
	val descriptor = Proto.descriptor_add_ruint32 kfield3Tag descriptor
	val descriptor = Proto.descriptor_add_ruint64 kfield4Tag descriptor
	val descriptor = Proto.descriptor_add_rsint32 kfield5Tag descriptor
	val descriptor = Proto.descriptor_add_rsint64 kfield6Tag descriptor
	val descriptor = Proto.descriptor_add_rbool kfield7Tag descriptor
	val descriptor = Proto.descriptor_add_ruint32 kfield8Tag descriptor
	val descriptor = Proto.descriptor_add_rfixed32 kfield9Tag descriptor
	val descriptor = Proto.descriptor_add_rfixed64 kfield10Tag descriptor
	val descriptor = Proto.descriptor_add_rsfixed32 kfield11Tag descriptor
	val descriptor = Proto.descriptor_add_rsfixed64 kfield12Tag descriptor
	val descriptor = Proto.descriptor_add_rstring kfield13Tag descriptor
	
	fun has_field1 (t) = isSome (#FIELD1 t)
	fun get_field1 (t) = 
		case #FIELD1 t of
			SOME(value) => value
		|	_ => 1
	fun set_field1 (value) (t) = 
		if Limits.isValidint32 value then { FIELD1 = SOME(value), FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not int32")
	fun clear_field1 (t) = { FIELD1 = NONE, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field1 = { get = get_field1, set = set_field1 }

	fun has_field2 (t) = isSome (#FIELD2 t)
	fun get_field2 (t) = 
		case #FIELD2 t of
			SOME(value) => value
		|	_ => Defaults.kint64
	fun set_field2 (value) (t) = 
		if Limits.isValidint64 value then { FIELD1 = #FIELD1 t, FIELD2 = SOME(value), FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not int64")
	fun clear_field2 (t) = { FIELD1 = #FIELD1 t, FIELD2 = NONE, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field2 = { get = get_field2, set = set_field2 }

	fun has_field3 (t) = isSome (#FIELD3 t)
	fun get_field3 (t) = 
		case #FIELD3 t of
			SOME(value) => value
		|	_ => Defaults.kuint32
	fun set_field3 (value) (t) = 
		if Limits.isValiduint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = SOME(value), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not uint32")
	fun clear_field3 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = NONE, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field3 = { get = get_field3, set = set_field3 }

	fun has_field4 (t) = isSome (#FIELD4 t)
	fun get_field4 (t) = 
		case #FIELD4 t of
			SOME(value) => value
		|	_ => Defaults.kuint64
	fun set_field4 (value) (t) = 
		if Limits.isValiduint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = SOME(value), FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not uint64")
	fun clear_field4 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = NONE, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field4 = { get = get_field4, set = set_field4 }
	
	fun has_field5 (t) = isSome (#FIELD5 t)
	fun get_field5 (t) = 
		case #FIELD5 t of
			SOME(value) => value
		|	_ => Defaults.ksint32
	fun set_field5 (value) (t) = 
		if Limits.isValidsint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = SOME(value), FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not sint32")
	fun clear_field5 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = NONE, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field5 = { get = get_field5, set = set_field5 }
	
	fun has_field6 (t) = isSome (#FIELD6 t)
	fun get_field6 (t) = 
		case #FIELD6 t of
			SOME(value) => value
		|	_ => Defaults.ksint64
	fun set_field6 (value) (t) = 
		if Limits.isValidsint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = SOME(value), FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not sint64")
	fun clear_field6 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = NONE, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field6 = { get = get_field6, set = set_field6 }
	
	fun has_field7 (t) = isSome (#FIELD7 t)
	fun get_field7 (t) =
		case #FIELD7 t of
			SOME(value) => value
		|	_ => true
	fun set_field7 (value) (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = SOME(value), FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	fun clear_field7 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = NONE, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field7 = { get = get_field7, set = set_field7 }

	fun has_field8 (t) = isSome (#FIELD8 t)
	fun get_field8 (t) =
		case #FIELD8 t of
			SOME(value) => value
		|	_ => MainMessage2_NestedEnum.kCASE2
	fun set_field8 (value) (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = SOME(value), FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	fun clear_field8 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = NONE, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field8 = { get = get_field8, set = set_field8 }

	fun has_field9 (t) = isSome (#FIELD9 t)
	fun get_field9 (t) = 
		case #FIELD9 t of
			SOME(value) => value
		|	_ => Defaults.kfixed32
	fun set_field9 (value) (t) = 
		if Limits.isValidfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = SOME(value), FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not fixed32")
	fun clear_field9 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = NONE, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field9 = { get = get_field9, set = set_field9 }

	fun has_field10 (t) = isSome (#FIELD10 t)
	fun get_field10 (t) = 
		case #FIELD10 t of
			SOME(value) => value
		|	_ => Defaults.kfixed64
	fun set_field10 (value) (t) = 
		if Limits.isValidfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = SOME(value), FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not fixed64")
	fun clear_field10 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = NONE, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field10 = { get = get_field10, set = set_field10 }
	
	fun has_field11 (t) = isSome (#FIELD11 t)
	fun get_field11 (t) = 
		case #FIELD11 t of
			SOME(value) => value
		|	_ => Defaults.ksfixed32
	fun set_field11 (value) (t) = 
		if Limits.isValidsfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = SOME(value), FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not sfixed32")
	fun clear_field11 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = NONE, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field11 = { get = get_field11, set = set_field11 }
	
	fun has_field12 (t) = isSome (#FIELD12 t)
	fun get_field12 (t) = 
		case #FIELD12 t of
			SOME(value) => value
		|	_ => Defaults.ksfixed64
	fun set_field12 (value) (t) = 
		if Limits.isValidsfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = SOME(value), FIELD13 = #FIELD13 t }
		else raise InvalidSet("Value is not sfixed64")
	fun clear_field12 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = NONE, FIELD13 = #FIELD13 t }
	val lens_field12 = { get = get_field12, set = set_field12 }
	
	fun has_field13 (t) = isSome (#FIELD13 t)
	fun get_field13 (t) =
		case #FIELD13 t of
			SOME(value) => value
		|	_ => Defaults.kstring
	fun set_field13 (value) (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = SOME(value) }
	fun clear_field13 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = NONE }
	val lens_field13 = { get = get_field13, set = set_field13 }
	
	fun isValid (proto) = 
		if not (has_field2 proto) then false else
		if not (has_field4 proto) then false else
		if not (has_field6 proto) then false else
		if not (has_field10 proto) then false else
		if not (has_field12 proto) then false else
		true
		
	fun serializeUnsafe (p) = 
		List.concat [
			if has_field1 p then Varint.serialize (kfield1Tag * 8 + 0) @ Varint.serialize (TwoComplement32.encode (get_field1 p)) else [],
			if has_field2 p then Varint.serialize (kfield2Tag * 8 + 0) @ Varint.serialize (TwoComplement64.encode (get_field2 p)) else [],
			if has_field3 p then Varint.serialize (kfield3Tag * 8 + 0) @ Varint.serialize (get_field3 p) else [],
			if has_field4 p then Varint.serialize (kfield4Tag * 8 + 0) @ Varint.serialize (get_field4 p) else [],
			if has_field5 p then Varint.serialize (kfield5Tag * 8 + 0) @ Varint.serialize (ZigZag.encode (get_field5 p)) else [],
			if has_field6 p then Varint.serialize (kfield6Tag * 8 + 0) @ Varint.serialize (ZigZag.encode (get_field6 p)) else [],
			if has_field7 p then Varint.serialize (kfield7Tag * 8 + 0) @ Varint.serialize (Boolean.encode (get_field7 p)) else [],
			if has_field8 p then Varint.serialize (kfield8Tag * 8 + 0) @ Varint.serialize (MainMessage2_NestedEnum.toInt (get_field8 p)) else [],
			if has_field9 p then Varint.serialize (kfield9Tag * 8 + 5) @ Fixed32.serialize (get_field9 p) else [],
			if has_field10 p then Varint.serialize (kfield10Tag * 8 + 1) @ Fixed64.serialize (get_field10 p) else [],
			if has_field11 p then Varint.serialize (kfield11Tag * 8 + 5) @ Fixed32.serialize (ZigZag.encode (get_field11 p)) else [],
			if has_field12 p then Varint.serialize (kfield12Tag * 8 + 1) @ Fixed64.serialize (ZigZag.encode (get_field12 p)) else [],
			if has_field13 p then Varint.serialize (kfield13Tag * 8 + 2) @ StringHandler.serialize (get_field13 p) else []
		]
		
	fun deserializeUnsafeHelp ([]) (p) = p
	|	deserializeUnsafeHelp (xs) (p) = 
		let val (tag_wire, xs2) = Varint.deserialize xs
			val (tag, wire) = (tag_wire  div 8, tag_wire mod 8)
		in
			case (tag, wire) of
				(1, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field1 (TwoComplement32.decode value) p) end
			|	(2, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field2 (TwoComplement64.decode value) p) end
			|	(3, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field3 (value) p) end
			|	(4, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field4 (value) p) end
			|	(5, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field5 (ZigZag.decode value) p) end
			|	(6, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field6 (ZigZag.decode value) p) end
			|	(7, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field7 (Boolean.decode value) p) end
			|	(8, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field8 (MainMessage2_NestedEnum.fromInt value) p) end
			|	(9, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field9 (value) p) end
			|	(10, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field10 (value) p) end
			|	(11, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field11 (ZigZag.decode value) p) end
			|	(12, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field12 (ZigZag.decode value) p) end
			|	(13, 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field13 (value) p) end
			|	(_, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, _) => raise DeserializationError("Unknow wire type")
		end
	fun deserializeUnsafe (xs) = deserializeUnsafeHelp (xs) (new)

	fun serialize (proto) =
		if isValid proto then serializeUnsafe proto
		else raise SerializationError("Proto is missing required fields")
	fun deserialize (xs) = 
		let val proto = deserializeUnsafe xs 
		in
			if isValid proto then proto
			else raise DeserializationError("Proto is missing fields")
		end
end;

signature MAINMESSAGE2_NESTEDMESSAGE2 = 
sig
	type t
	val new : t
	val descriptor : Proto.descriptorType
	
	val kfield1Tag : int
	val kfield2Tag : int
	val kfield3Tag : int
	val kfield4Tag : int
	val kfield5Tag : int
	val kfield6Tag : int
	val kfield7Tag : int
	val kfield8Tag : int
	val kfield9Tag : int
	val kfield10Tag : int
	val kfield11Tag : int
	val kfield12Tag : int
	val kfield13Tag : int
	
	val size_field1 : t -> int
	val get_field1 : t -> int list
	val set_field1 : int list -> t -> t
	val add_field1 : int -> t -> t
	val clear_field1 : t -> t
	val lens_field1 : (t, int list) Lens
	val get_nth_field1 : int -> t -> int
	val set_nth_field1 : int -> int -> t -> t
	val lens_nth_field1 : int -> (t, int) Lens
	
	val size_field2 : t -> int
	val get_field2 : t -> int list
	val set_field2 : int list -> t -> t
	val add_field2 : int -> t -> t
	val clear_field2 : t -> t
	val lens_field2 : (t, int list) Lens
	val get_nth_field2 : int -> t -> int
	val set_nth_field2 : int -> int -> t -> t
	val lens_nth_field2 : int -> (t, int) Lens
	
	val size_field3 : t -> int
	val get_field3 : t -> int list
	val set_field3 : int list -> t -> t
	val add_field3 : int -> t -> t
	val clear_field3 : t -> t
	val lens_field3 : (t, int list) Lens
	val get_nth_field3 : int -> t -> int
	val set_nth_field3 : int -> int -> t -> t
	val lens_nth_field3 : int -> (t, int) Lens
	
	val size_field4 : t -> int
	val get_field4 : t -> int list
	val set_field4 : int list -> t -> t
	val add_field4 : int -> t -> t
	val clear_field4 : t -> t
	val lens_field4 : (t, int list) Lens
	val get_nth_field4 : int -> t -> int
	val set_nth_field4 : int -> int -> t -> t
	val lens_nth_field4 : int -> (t, int) Lens
	
	val size_field5 : t -> int
	val get_field5 : t -> int list
	val set_field5 : int list -> t -> t
	val add_field5 : int -> t -> t
	val clear_field5 : t -> t
	val lens_field5 : (t, int list) Lens
	val get_nth_field5 : int -> t -> int
	val set_nth_field5 : int -> int -> t -> t
	val lens_nth_field5 : int -> (t, int) Lens
	
	val size_field6 : t -> int
	val get_field6 : t -> int list
	val set_field6 : int list -> t -> t
	val add_field6 : int -> t -> t
	val clear_field6 : t -> t
	val lens_field6 : (t, int list) Lens
	val get_nth_field6 : int -> t -> int
	val set_nth_field6 : int -> int -> t -> t
	val lens_nth_field6 : int -> (t, int) Lens
	
	val size_field7 : t -> int
	val get_field7 : t -> bool list
	val set_field7 : bool list -> t -> t
	val add_field7 : bool -> t -> t
	val clear_field7 : t -> t
	val lens_field7 : (t, bool list) Lens
	val get_nth_field7 : int -> t -> bool
	val set_nth_field7 : int -> bool -> t -> t
	val lens_nth_field7 : int -> (t, bool) Lens
	
	val size_field8 : t -> int
	val get_field8 : t -> MainMessage2_NestedEnum.t list
	val set_field8 : MainMessage2_NestedEnum.t list -> t -> t
	val add_field8 : MainMessage2_NestedEnum.t -> t -> t
	val clear_field8 : t -> t
	val lens_field8 : (t, MainMessage2_NestedEnum.t list) Lens
	val get_nth_field8 : int -> t -> MainMessage2_NestedEnum.t
	val set_nth_field8 : int -> MainMessage2_NestedEnum.t -> t -> t
	val lens_nth_field8 : int -> (t, MainMessage2_NestedEnum.t) Lens
	
	val size_field9 : t -> int
	val get_field9 : t -> int list
	val set_field9 : int list -> t -> t
	val add_field9 : int -> t -> t
	val clear_field9 : t -> t
	val lens_field9 : (t, int list) Lens
	val get_nth_field9 : int -> t -> int
	val set_nth_field9 : int -> int -> t -> t
	val lens_nth_field9 : int -> (t, int) Lens
	
	val size_field10 : t -> int
	val get_field10 : t -> int list
	val set_field10 : int list -> t -> t
	val add_field10 : int -> t -> t
	val clear_field10 : t -> t
	val lens_field10 : (t, int list) Lens
	val get_nth_field10 : int -> t -> int
	val set_nth_field10 : int -> int -> t -> t
	val lens_nth_field10 : int -> (t, int) Lens
	
	val size_field11 : t -> int
	val get_field11 : t -> int list
	val set_field11 : int list -> t -> t
	val add_field11 : int -> t -> t
	val clear_field11 : t -> t
	val lens_field11 : (t, int list) Lens
	val get_nth_field11 : int -> t -> int
	val set_nth_field11 : int -> int -> t -> t
	val lens_nth_field11 : int -> (t, int) Lens
	
	val size_field12 : t -> int
	val get_field12 : t -> int list
	val set_field12 : int list -> t -> t
	val add_field12 : int -> t -> t
	val clear_field12 : t -> t
	val lens_field12 : (t, int list) Lens
	val get_nth_field12 : int -> t -> int
	val set_nth_field12 : int -> int -> t -> t
	val lens_nth_field12 : int -> (t, int) Lens

	val size_field13 : t -> int
	val get_field13 : t -> string list
	val set_field13 : string list -> t -> t
	val add_field13 : string -> t -> t
	val clear_field13 : t -> t
	val lens_field13 : (t, string list) Lens
	val get_nth_field13 : int -> t -> string
	val set_nth_field13 : int -> string -> t -> t
	val lens_nth_field13 : int -> (t, string) Lens
	
	val isValid : t -> bool
	val serializeUnsafe : t -> Word8.word list
	val deserializeUnsafe : Word8.word list -> t
	val serialize : t -> Word8.word list
	val deserialize : Word8.word list -> t
end;
structure MainMessage2_NestedMessage2 :> MAINMESSAGE2_NESTEDMESSAGE2 =
struct
	type t = { FIELD1: int list option, FIELD2: int list option, FIELD3 : int list option, FIELD4 : int list option, FIELD5 : int list option, FIELD6 : int list option, FIELD7 : bool list option, FIELD8 : MainMessage2_NestedEnum.t list option, FIELD9 : int list option, FIELD10 : int list option, FIELD11 : int list option, FIELD12 : int list option, FIELD13 : string list option }
	val new = { FIELD1 = NONE, FIELD2 = NONE, FIELD3 = NONE, FIELD4 = NONE, FIELD5 = NONE, FIELD6 = NONE, FIELD7 = NONE, FIELD8 = NONE, FIELD9 = NONE, FIELD10 = NONE, FIELD11 = NONE, FIELD12 = NONE, FIELD13 = NONE }
	
	val kfield1Tag = 1
	val kfield2Tag = 2
	val kfield3Tag = 3
	val kfield4Tag = 4
	val kfield5Tag = 5
	val kfield6Tag = 6
	val kfield7Tag = 7
	val kfield8Tag = 8
	val kfield9Tag = 9
	val kfield10Tag = 10
	val kfield11Tag = 11
	val kfield12Tag = 12
	val kfield13Tag = 13
	
	val descriptor = Proto.newDescriptor
	val descriptor = Proto.descriptor_add_rint32 kfield1Tag descriptor
	val descriptor = Proto.descriptor_add_rint64 kfield2Tag descriptor
	val descriptor = Proto.descriptor_add_ruint32 kfield3Tag descriptor
	val descriptor = Proto.descriptor_add_ruint64 kfield4Tag descriptor
	val descriptor = Proto.descriptor_add_rsint32 kfield5Tag descriptor
	val descriptor = Proto.descriptor_add_rsint64 kfield6Tag descriptor
	val descriptor = Proto.descriptor_add_rbool kfield7Tag descriptor
	val descriptor = Proto.descriptor_add_ruint32 kfield8Tag descriptor
	val descriptor = Proto.descriptor_add_rfixed32 kfield9Tag descriptor
	val descriptor = Proto.descriptor_add_rfixed64 kfield10Tag descriptor
	val descriptor = Proto.descriptor_add_rsfixed32 kfield11Tag descriptor
	val descriptor = Proto.descriptor_add_rsfixed64 kfield12Tag descriptor
	val descriptor = Proto.descriptor_add_rstring kfield13Tag descriptor
	
	fun size_field1 (t) = 
		case #FIELD1 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field1 (t) = 
		case #FIELD1 t of
			SOME(l) => l
		|	_ => []
	fun set_field1 (value) (t) =
		if List.all Limits.isValidint32 value then { FIELD1 = SOME(value), FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not int32")
	fun add_field1 (value) (t) = 
		let val xs = get_field1 t
		in
			if Limits.isValidint32 value then { FIELD1 = SOME(xs @ [value]), FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not int32")
		end
	fun clear_field1 (t) = { FIELD1 = NONE, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field1 = { get = get_field1, set = set_field1 }
	fun get_nth_field1 (position) (t) = List.nth (get_field1 t, position)
	fun set_nth_field1 (position) (value) (t) = 
		let val xs = get_field1 t
		in
			if Limits.isValidint32 value then { FIELD1 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not int32")
		end;
	fun lens_nth_field1 (position) = { get = get_nth_field1 position, set = set_nth_field1 position }	
	
	fun size_field2 (t) = 
		case #FIELD2 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field2 (t) = 
		case #FIELD2 t of
			SOME(l) => l
		|	_ => []
	fun set_field2 (value) (t) =
		if List.all Limits.isValidint64 value then { FIELD1 = #FIELD1 t, FIELD2 = SOME(value), FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not int64")
	fun add_field2 (value) (t) = 
		let val xs = get_field2 t
		in
			if Limits.isValidint64 value then { FIELD1 = #FIELD1 t, FIELD2 = SOME(xs @ [value]), FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not int64")
		end
	fun clear_field2 (t) = { FIELD1 = #FIELD1 t, FIELD2 = NONE, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field2 = { get = get_field2, set = set_field2 }
	fun get_nth_field2 (position) (t) = List.nth (get_field2 t, position)
	fun set_nth_field2 (position) (value) (t) = 
		let val xs = get_field2 t
		in
			if Limits.isValidint64 value then { FIELD1 = #FIELD1 t, FIELD2 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not int64")
		end;
	fun lens_nth_field2 (position) = { get = get_nth_field2 position, set = set_nth_field2 position }

	fun size_field3 (t) = 
		case #FIELD3 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field3 (t) = 
		case #FIELD3 t of
			SOME(l) => l
		|	_ => []
	fun set_field3 (value) (t) =
		if List.all Limits.isValiduint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = SOME(value), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not uint32")
	fun add_field3 (value) (t) = 
		let val xs = get_field3 t
		in
			if Limits.isValiduint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = SOME(xs @ [value]), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not uint32")
		end
	fun clear_field3 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = NONE, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field3 = { get = get_field3, set = set_field3 }
	fun get_nth_field3 (position) (t) = List.nth (get_field3 t, position)
	fun set_nth_field3 (position) (value) (t) = 
		let val xs = get_field3 t
		in
			if Limits.isValiduint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not uint32")
		end;
	fun lens_nth_field3 (position) = { get = get_nth_field3 position, set = set_nth_field3 position }	

	fun size_field4 (t) = 
		case #FIELD4 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field4 (t) = 
		case #FIELD4 t of
			SOME(l) => l
		|	_ => []
	fun set_field4 (value) (t) =
		if List.all Limits.isValiduint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = SOME(value), FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not uint64")
	fun add_field4 (value) (t) = 
		let val xs = get_field4 t
		in
			if Limits.isValiduint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = SOME(xs @ [value]), FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not uint64")
		end
	fun clear_field4 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = NONE, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field4 = { get = get_field4, set = set_field4 }
	fun get_nth_field4 (position) (t) = List.nth (get_field4 t, position)
	fun set_nth_field4 (position) (value) (t) = 
		let val xs = get_field4 t
		in
			if Limits.isValiduint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not uint64")
		end;
	fun lens_nth_field4 (position) = { get = get_nth_field4 position, set = set_nth_field4 position }	

	fun size_field5 (t) = 
		case #FIELD5 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field5 (t) = 
		case #FIELD5 t of
			SOME(l) => l
		|	_ => []
	fun set_field5 (value) (t) =
		if List.all Limits.isValidsint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = SOME(value), FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not sint32")
	fun add_field5 (value) (t) = 
		let val xs = get_field5 t
		in
			if Limits.isValidsint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = SOME(xs @ [value]), FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sint32")
		end
	fun clear_field5 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = NONE, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field5 = { get = get_field5, set = set_field5 }
	fun get_nth_field5 (position) (t) = List.nth (get_field5 t, position)
	fun set_nth_field5 (position) (value) (t) = 
		let val xs = get_field5 t
		in
			if Limits.isValidsint32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sint32")
		end;
	fun lens_nth_field5 (position) = { get = get_nth_field5 position, set = set_nth_field5 position }	

	fun size_field6 (t) = 
		case #FIELD6 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field6 (t) = 
		case #FIELD6 t of
			SOME(l) => l
		|	_ => []
	fun set_field6 (value) (t) =
		if List.all Limits.isValidsint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = SOME(value), FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not sint64")
	fun add_field6 (value) (t) = 
		let val xs = get_field6 t
		in
			if Limits.isValidsint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = SOME(xs @ [value]), FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sint64")
		end
	fun clear_field6 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = NONE, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field6 = { get = get_field6, set = set_field6 }
	fun get_nth_field6 (position) (t) = List.nth (get_field6 t, position)
	fun set_nth_field6 (position) (value) (t) = 
		let val xs = get_field6 t
		in
			if Limits.isValidsint64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sint64")
		end;
	fun lens_nth_field6 (position) = { get = get_nth_field6 position, set = set_nth_field6 position }
	
	fun size_field7 (t) = 
		case #FIELD7 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field7 (t) = 
		case #FIELD7 t of
			SOME(l) => l
		|	_ => []
	fun set_field7 (value) (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = SOME(value), FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	fun add_field7 (value) (t) = 
		let val xs = get_field7 t
		in 
			{ FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = SOME(xs @ [value]), FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t } 
		end
	fun clear_field7 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = NONE, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field7 = { get = get_field7, set = set_field7 }
	fun get_nth_field7 (position) (t) = List.nth (get_field7 t, position)
	fun set_nth_field7 (position) (value) (t) = 
		let val xs = get_field7 t
		in
			{ FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		end;
	fun lens_nth_field7 (position) = { get = get_nth_field7 position, set = set_nth_field7 position }
	
	fun size_field8 (t) = 
		case #FIELD8 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field8 (t) = 
		case #FIELD8 t of
			SOME(l) => l
		|	_ => []
	fun set_field8 (value) (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = SOME(value), FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	fun add_field8 (value) (t) = 
		let val xs = get_field8 t
		in 
			{ FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = SOME(xs @ [value]), FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t } 
		end
	fun clear_field8 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = NONE, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field8 = { get = get_field8, set = set_field8 }
	fun get_nth_field8 (position) (t) = List.nth (get_field8 t, position)
	fun set_nth_field8 (position) (value) (t) = 
		let val xs = get_field8 t
		in
			{ FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		end;
	fun lens_nth_field8 (position) = { get = get_nth_field8 position, set = set_nth_field8 position }

	fun size_field9 (t) = 
		case #FIELD9 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field9 (t) = 
		case #FIELD9 t of
			SOME(l) => l
		|	_ => []
	fun set_field9 (value) (t) =
		if List.all Limits.isValidfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = SOME(value), FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not fixed32")
	fun add_field9 (value) (t) = 
		let val xs = get_field9 t
		in
			if Limits.isValidfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = SOME(xs @ [value]), FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not fixed32")
		end
	fun clear_field9 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = NONE, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field9 = { get = get_field9, set = set_field9 }
	fun get_nth_field9 (position) (t) = List.nth (get_field9 t, position)
	fun set_nth_field9 (position) (value) (t) = 
		let val xs = get_field9 t
		in
			if Limits.isValidfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not fixed32")
		end;
	fun lens_nth_field9 (position) = { get = get_nth_field9 position, set = set_nth_field9 position }
	
	fun size_field10 (t) = 
		case #FIELD10 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field10 (t) = 
		case #FIELD10 t of
			SOME(l) => l
		|	_ => []
	fun set_field10 (value) (t) =
		if List.all Limits.isValidfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = SOME(value), FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not fixed64")
	fun add_field10 (value) (t) = 
		let val xs = get_field10 t
		in
			if Limits.isValidfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = SOME(xs @ [value]), FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not fixed64")
		end
	fun clear_field10 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = NONE, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field10 = { get = get_field10, set = set_field10 }
	fun get_nth_field10 (position) (t) = List.nth (get_field10 t, position)
	fun set_nth_field10 (position) (value) (t) = 
		let val xs = get_field10 t
		in
			if Limits.isValidfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not fixed64")
		end;
	fun lens_nth_field10 (position) = { get = get_nth_field10 position, set = set_nth_field10 position }
	
	fun size_field11 (t) = 
		case #FIELD11 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field11 (t) = 
		case #FIELD11 t of
			SOME(l) => l
		|	_ => []
	fun set_field11 (value) (t) =
		if List.all Limits.isValidsfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = SOME(value), FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not sfixed32")
	fun add_field11 (value) (t) = 
		let val xs = get_field11 t
		in
			if Limits.isValidsfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = SOME(xs @ [value]), FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sfixed32")
		end
	fun clear_field11 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = NONE, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field11 = { get = get_field11, set = set_field11 }
	fun get_nth_field11 (position) (t) = List.nth (get_field11 t, position)
	fun set_nth_field11 (position) (value) (t) = 
		let val xs = get_field11 t
		in
			if Limits.isValidsfixed32 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sfixed32")
		end;
	fun lens_nth_field11 (position) = { get = get_nth_field11 position, set = set_nth_field11 position }
	
	fun size_field12 (t) = 
		case #FIELD12 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field12 (t) = 
		case #FIELD12 t of
			SOME(l) => l
		|	_ => []
	fun set_field12 (value) (t) =
		if List.all Limits.isValidsfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = SOME(value), FIELD13 = #FIELD13 t }
		else raise InvalidSet("Values are not sfixed64")
	fun add_field12 (value) (t) = 
		let val xs = get_field12 t
		in
			if Limits.isValidsfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = SOME(xs @ [value]), FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sfixed64")
		end
	fun clear_field12 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = NONE, FIELD13 = NONE }
	val lens_field12 = { get = get_field12, set = set_field12 }
	fun get_nth_field12 (position) (t) = List.nth (get_field12 t, position)
	fun set_nth_field12 (position) (value) (t) = 
		let val xs = get_field12 t
		in
			if Limits.isValidsfixed64 value then { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))), FIELD13 = #FIELD13 t }
			else raise InvalidSet("Value is not sfixed64")
		end;
	fun lens_nth_field12 (position) = { get = get_nth_field12 position, set = set_nth_field12 position }
	
	fun size_field13 (t) = 
		case #FIELD13 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field13 (t) = 
		case #FIELD13 t of
			SOME(l) => l
		|	_ => []
	fun set_field13 (value) (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = SOME(value) }
	fun add_field13 (value) (t) = 
		let val xs = get_field13 t
		in 
			{ FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = SOME(xs @ [value]) } 
		end
	fun clear_field13 (t) = { FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = #FIELD13 t }
	val lens_field13 = { get = get_field13, set = set_field13 }
	fun get_nth_field13 (position) (t) = List.nth (get_field13 t, position)
	fun set_nth_field13 (position) (value) (t) = 
		let val xs = get_field13 t
		in
			{ FIELD1 = #FIELD1 t, FIELD2 = #FIELD2 t, FIELD3 = #FIELD3 t, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t, FIELD6 = #FIELD6 t, FIELD7 = #FIELD7 t, FIELD8 = #FIELD8 t, FIELD9 = #FIELD9 t, FIELD10 = #FIELD10 t, FIELD11 = #FIELD11 t, FIELD12 = #FIELD12 t, FIELD13 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))) }
		end;
	fun lens_nth_field13 (position) = { get = get_nth_field13 position, set = set_nth_field13 position }
	
	fun isValid (proto) = 
		true
		
	fun serializeUnsafe (p) =
		List.concat [
			List.concat (List.map (fn x => Varint.serialize (kfield1Tag * 8 + 0) @ Varint.serialize (TwoComplement32.encode x)) (get_field1 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield2Tag * 8 + 0) @ Varint.serialize (TwoComplement64.encode x)) (get_field2 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield3Tag * 8 + 0) @ Varint.serialize (x)) (get_field3 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield4Tag * 8 + 0) @ Varint.serialize (x)) (get_field4 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield5Tag * 8 + 0) @ Varint.serialize (ZigZag.encode x)) (get_field5 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield6Tag * 8 + 0) @ Varint.serialize (ZigZag.encode x)) (get_field6 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield7Tag * 8 + 0) @ Varint.serialize (Boolean.encode x)) (get_field7 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield8Tag * 8 + 0) @ Varint.serialize (MainMessage2_NestedEnum.toInt x)) (get_field8 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield9Tag * 8 + 5) @ Fixed32.serialize (x)) (get_field9 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield10Tag * 8 + 1) @ Fixed64.serialize (x)) (get_field10 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield11Tag * 8 + 5) @ Fixed32.serialize (ZigZag.encode x)) (get_field11 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield12Tag * 8 + 1) @ Fixed64.serialize (ZigZag.decode x)) (get_field12 p)),
			List.concat (List.map (fn x => Varint.serialize (kfield13Tag * 8 + 2) @ StringHandler.serialize (x)) (get_field13 p))
		]
	fun deserializeUnsafeHelp ([]) (p) = p
	|	deserializeUnsafeHelp (xs) (p) =
		let val (tag_wire, xs2) = Varint.deserialize (xs)
			val (tag, wire) = (tag_wire div 8, tag_wire mod 8)
		in
			case (tag, wire) of 
				(1, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field1 (TwoComplement32.decode value) p) end
			|	(2, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field2 (TwoComplement64.decode value) p) end
			|	(3, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field3 (value) p) end
			|	(4, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field4 (value) p) end
			|	(5, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field5 (ZigZag.decode value) p) end
			|	(6, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field6 (ZigZag.decode value) p) end
			|	(7, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field7 (Boolean.decode value) p) end
			|	(8, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field8 (MainMessage2_NestedEnum.fromInt value) p) end
			|	(9, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field9 (value) p) end
			|	(10, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field10 (value) p) end
			|	(11, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field11 (ZigZag.decode value) p) end
			|	(12, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field12 (ZigZag.decode value) p) end
			|	(13, 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeUnsafeHelp (xs3) (add_field13 (value) p) end
			|	(_, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 2) => let val (l, xs3) = Varint.deserialize(xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (p) end
			|	(_, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, _) => raise DeserializationError("Unknow wire type")
		end
	fun deserializeUnsafe (xs) = deserializeUnsafeHelp (xs) (new)

	fun serialize (proto) =
		if isValid proto then serializeUnsafe proto
		else raise SerializationError("Proto is missing required fields")
	fun deserialize (xs) = 
		let val proto = deserializeUnsafe xs 
		in
			if isValid proto then proto
			else raise DeserializationError("Proto is missing fields")
		end
end;

signature MAINMESSAGE2 =
sig
	type t
	val new : t
	val descriptor : Proto.descriptorType
	
	val kNestedOneOfTags : int list
	val kfield1Tag : int
	val kfield2Tag : int
	val kfield3Tag : int
	val kfield4Tag : int
	val kfield5Tag : int
	
	datatype typeNestedOneOf = NOT_SET | kfield1 | kfield2 | kfield3
	val case_NestedOneOf : t -> typeNestedOneOf
	val clear_NestedOneOf : t -> t
	
	val has_field1 : t -> bool
	val get_field1 : t -> int
	val set_field1 : int -> t -> t
	val clear_field1 : t -> t
	val lens_field1 : (t, int) Lens

	val has_field2 : t -> bool
	val get_field2 : t -> MainMessage2_NestedEnum.t
	val set_field2 : MainMessage2_NestedEnum.t -> t -> t
	val clear_field2 : t -> t
	val lens_field2 : (t, MainMessage2_NestedEnum.t) Lens
	
	val has_field3 : t -> bool
	val get_field3 : t -> MainMessage2_NestedMessage.t
	val set_field3 : MainMessage2_NestedMessage.t -> t -> t
	val clear_field3 : t -> t
	val lens_field3 : (t, MainMessage2_NestedMessage.t) Lens
	
	val has_field4 : t -> bool
	val get_field4 : t -> MainMessage2_NestedMessage.t
	val set_field4 : MainMessage2_NestedMessage.t -> t -> t
	val clear_field4 : t -> t
	val lens_field4 : (t, MainMessage2_NestedMessage.t) Lens

	val size_field5 : t -> int
	val get_field5 : t -> MainMessage2_NestedMessage2.t list
	val set_field5 : MainMessage2_NestedMessage2.t list -> t -> t
	val add_field5 : MainMessage2_NestedMessage2.t -> t -> t
	val clear_field5 : t -> t
	val lens_field5 : (t, MainMessage2_NestedMessage2.t list) Lens
	val get_nth_field5 : int -> t -> MainMessage2_NestedMessage2.t
	val set_nth_field5 : int -> MainMessage2_NestedMessage2.t -> t -> t
	val lens_nth_field5 : int -> (t, MainMessage2_NestedMessage2.t) Lens
	
	val isValid : t -> bool
	val serializeUnsafe : t -> Word8.word list
	val deserializeUnsafe : Word8.word list -> t
	val serialize : t -> Word8.word list
	val deserialize : Word8.word list -> t
end;
structure MainMessage2 :> MAINMESSAGE2 =
struct
	datatype datatypeNestedOneOf = FIELD1 of int | FIELD2 of MainMessage2_NestedEnum.t | FIELD3 of MainMessage2_NestedMessage.t
	type t = { NESTEDONEOF : datatypeNestedOneOf option, FIELD4 : MainMessage2_NestedMessage.t option, FIELD5 : MainMessage2_NestedMessage2.t list option }
	
	val new = { NESTEDONEOF = NONE, FIELD4 = NONE, FIELD5 = NONE }
	
	val kNestedOneOfTags = [1, 2, 3]
	val kfield1Tag = 1
	val kfield2Tag = 2
	val kfield3Tag = 3
	val kfield4Tag = 4
	val kfield5Tag = 5
	
	val descriptor = Proto.newDescriptor
	val descriptor = Proto.descriptor_add_oneof kNestedOneOfTags descriptor
	val descriptor = Proto.descriptor_add_int32 kfield1Tag descriptor
	val descriptor = Proto.descriptor_add_uint32 kfield2Tag descriptor
	val descriptor = Proto.descriptor_add_message (kfield3Tag, MainMessage2_NestedMessage.descriptor) descriptor
	val descriptor = Proto.descriptor_add_message (kfield4Tag, MainMessage2_NestedMessage.descriptor) descriptor
	val descriptor = Proto.descriptor_add_rmessage (kfield5Tag, MainMessage2_NestedMessage2.descriptor) descriptor
	
	datatype typeNestedOneOf = NOT_SET | kfield1 | kfield2 | kfield3
	fun case_NestedOneOf (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD1 _) => kfield1
		|	SOME(FIELD2 _) => kfield2
		|	SOME(FIELD3 _) => kfield3
		|	_ => NOT_SET
	fun clear_NestedOneOf (t) = { NESTEDONEOF = NONE, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
		
	fun has_field1 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD1 _) => true
		|	_ => false
	fun get_field1 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD1 value) => value
		|	_ => Defaults.kint32
	fun set_field1 (value) (t) = 
		if Limits.isValidint32 value then { NESTEDONEOF = SOME(FIELD1 value), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
		else raise InvalidSet("Value is not int32")
	fun clear_field1 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD1 value) => { NESTEDONEOF = NONE, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
		|	_ => t
	val lens_field1 = { get = get_field1, set = set_field1 }
	
	fun has_field2 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD2 _) => true
		|	_ => false
	fun get_field2 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD2 value) => value
		|	_ => MainMessage2_NestedEnum.kdefault
	fun set_field2 (value) (t) = { NESTEDONEOF = SOME(FIELD2 value), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
	fun clear_field2 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD2 value) => { NESTEDONEOF = NONE, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
		|	_ => t
	val lens_field2 = { get = get_field2, set = set_field2 }
	
	fun has_field3 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD3 _) => true
		|	_ => false
	fun get_field3 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD3 value) => value
		|	_ => MainMessage2_NestedMessage.new
	fun set_field3 (value) (t) = { NESTEDONEOF = SOME(FIELD3 value), FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
	fun clear_field3 (t) = 
		case #NESTEDONEOF t of
			SOME(FIELD3 value) => { NESTEDONEOF = NONE, FIELD4 = #FIELD4 t, FIELD5 = #FIELD5 t }
		|	_ => t
	val lens_field3 = { get = get_field3, set = set_field3 }

	fun has_field4 (t) = isSome (#FIELD4 t)
	fun get_field4 (t) = 
		case #FIELD4 t of
			SOME(value) => value
		|	_ => MainMessage2_NestedMessage.new
	fun set_field4 (value) (t) = { NESTEDONEOF = #NESTEDONEOF t, FIELD4 = SOME(value), FIELD5 = #FIELD5 t }
	fun clear_field4 (t) = 
		case #FIELD4 t of
			SOME(value) => { NESTEDONEOF = #NESTEDONEOF t, FIELD4 = NONE, FIELD5 = #FIELD5 t }
		|	_ => t
	val lens_field4 = { get = get_field4, set = set_field4 }

	fun size_field5 (t) = 
		case #FIELD5 t of
			SOME(l) => List.length l
		|	_ => 0
	fun get_field5 (t) = 
		case #FIELD5 t of
			SOME(l) => l
		|	_ => []
	fun set_field5 (value) (t) = { NESTEDONEOF = #NESTEDONEOF t, FIELD4 = #FIELD4 t, FIELD5 = SOME(value) }
	fun add_field5 (value) (t) = 
		let val xs = get_field5 t
		in 
			{ NESTEDONEOF = #NESTEDONEOF t, FIELD4 = #FIELD4 t, FIELD5 = SOME(xs @ [value]) }
		end
	fun clear_field5 (t) = { NESTEDONEOF = #NESTEDONEOF t, FIELD4 = #FIELD4 t, FIELD5 = NONE }
	val lens_field5 = { get = get_field5, set = set_field5 }
	fun get_nth_field5 (position) (t) = List.nth (get_field5 t, position)
	fun set_nth_field5 (position) (value) (t) = 
		let val xs = get_field5 t
		in
			{ NESTEDONEOF = #NESTEDONEOF t, FIELD4 = #FIELD4 t, FIELD5 = SOME(List.take(xs, position) @ (value :: List.drop(xs, position+1))) }
		end
	fun lens_nth_field5 (position) = { get = get_nth_field5 position, set = set_nth_field5 position }
	
	fun isValid (proto) = 
		if not (has_field3 proto andalso MainMessage2_NestedMessage.isValid (get_field3 proto)) then false else
		if not (has_field4 proto andalso MainMessage2_NestedMessage.isValid (get_field4 proto)) then false else
		if not (List.all MainMessage2_NestedMessage2.isValid (get_field5 proto)) then false else
		true
		
	fun serializeUnsafe (p) =
		List.concat [
			if has_field1 p then Varint.serialize (kfield1Tag * 8 + 0) @ Varint.serialize (TwoComplement32.encode (get_field1 p)) else [],
			if has_field2 p then Varint.serialize (kfield2Tag * 8 + 0) @ Varint.serialize (MainMessage2_NestedEnum.toInt (get_field2 p)) else [],
			if has_field3 p then let val l = MainMessage2_NestedMessage.serializeUnsafe (get_field3 p) in Varint.serialize(kfield3Tag * 8 + 2) @ Varint.serialize (List.length l) @ l end else [],
			if has_field4 p then let val l = MainMessage2_NestedMessage.serializeUnsafe (get_field4 p) in Varint.serialize(kfield4Tag * 8 + 2) @ Varint.serialize (List.length l) @ l end else [],
			List.concat (List.map (fn x => let val l = MainMessage2_NestedMessage2.serializeUnsafe (x) in Varint.serialize(kfield5Tag * 8 + 2) @ Varint.serialize (List.length l) @ l end) (get_field5 p))
		]
		
	fun deserializeUnsafeHelp ([]) (p) = p
	|	deserializeUnsafeHelp (xs) (p) =
		let val (tag_wire, xs2) = Varint.deserialize(xs)
			val (tag, wire) = (tag_wire div 8, tag_wire mod 8)
		in
			case (tag, wire) of
				(1, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field1 (TwoComplement32.decode value) p) end
			|	(2, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_field2 (MainMessage2_NestedEnum.fromInt value) p) end
			|	(3, 2) => let val (l, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (set_field3 (MainMessage2_NestedMessage.deserialize (List.take(xs3, l))) p) end
			|	(4, 2) => let val (l, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (set_field4 (MainMessage2_NestedMessage.deserialize (List.take(xs3, l))) p) end
			|	(5, 2) => let val (l, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (add_field5 (MainMessage2_NestedMessage2.deserialize (List.take(xs3, l))) p) end
			|	(_, 0) => let val (value, xs3) = Varint.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 1) => let val (value, xs3) = Fixed64.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, 2) => let val (l, xs3) = Varint.deserialize(xs2) in deserializeUnsafeHelp (List.drop(xs3, l)) (p) end
			|	(_, 5) => let val (value, xs3) = Fixed32.deserialize (xs2) in deserializeUnsafeHelp (xs3) (p) end
			|	(_, _) => raise DeserializationError("Unknow wire type")
		end
	fun deserializeUnsafe (xs) = deserializeUnsafeHelp (xs) (new)

	fun serialize (proto) =
		if isValid proto then serializeUnsafe proto
		else raise SerializationError("Proto is missing required fields")
	fun deserialize (xs) = 
		let val proto = deserializeUnsafe xs 
		in
			if isValid proto then proto
			else raise DeserializationError("Proto is missing fields")
		end
end;

(*
use "../Examples/example6_speed.sml";
*)