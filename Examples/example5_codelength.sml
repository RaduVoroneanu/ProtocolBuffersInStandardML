structure MainMessage_NestedEnum =
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

structure MainMessage_NestedMessage =
struct
	type t = Proto.protoType
	
	val new : t = Proto.newProto
		
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
	val descriptor = Proto.descriptor_add_int32 kfield1Tag descriptor
	val descriptor = Proto.descriptor_add_int64 kfield2Tag descriptor
	val descriptor = Proto.descriptor_add_uint32 kfield3Tag descriptor
	val descriptor = Proto.descriptor_add_uint64 kfield4Tag descriptor
	val descriptor = Proto.descriptor_add_sint32 kfield5Tag descriptor
	val descriptor = Proto.descriptor_add_sint64 kfield6Tag descriptor
	val descriptor = Proto.descriptor_add_bool kfield7Tag descriptor
	val descriptor = Proto.descriptor_add_uint32 kfield8Tag descriptor
	val descriptor = Proto.descriptor_add_fixed32 kfield9Tag descriptor
	val descriptor = Proto.descriptor_add_fixed64 kfield10Tag descriptor
	val descriptor = Proto.descriptor_add_sfixed32 kfield11Tag descriptor
	val descriptor = Proto.descriptor_add_sfixed64 kfield12Tag descriptor
	val descriptor = Proto.descriptor_add_string kfield13Tag descriptor

	fun has_field1 (proto : t) : bool = Proto.proto_has_int32 kfield1Tag proto
	fun get_field1 (proto : t) : int = Proto.proto_get_int32 kfield1Tag 1 proto
	fun set_field1 (value : int) (proto : t) : t = Proto.proto_set_int32 kfield1Tag value proto
	fun clear_field1 (proto : t) : t = Proto.proto_clear_int32 kfield1Tag proto
	val lens_field1 : (t, int) Lens = { get = get_field1, set = set_field1 }

	fun has_field2 (proto : t) : bool = Proto.proto_has_int64 kfield2Tag proto
	fun get_field2 (proto : t) : int = Proto.proto_get_int64 kfield2Tag Defaults.kint64 proto
	fun set_field2 (value : int) (proto : t) : t = Proto.proto_set_int64 kfield2Tag value proto
	fun clear_field2 (proto : t) : t = Proto.proto_clear_int64 kfield2Tag proto
	val lens_field2 : (t, int) Lens = { get = get_field2, set = set_field2 }

	fun has_field3 (proto : t) : bool = Proto.proto_has_uint32 kfield3Tag proto
	fun get_field3 (proto : t) : int = Proto.proto_get_uint32 kfield3Tag Defaults.kuint32 proto
	fun set_field3 (value : int) (proto : t) : t = Proto.proto_set_uint32 kfield3Tag value proto
	fun clear_field3 (proto : t) : t = Proto.proto_clear_uint32 kfield3Tag proto
	val lens_field3 : (t, int) Lens = { get = get_field3, set = set_field3 }

	fun has_field4 (proto : t) : bool = Proto.proto_has_uint64 kfield4Tag proto
	fun get_field4 (proto : t) : int = Proto.proto_get_uint64 kfield4Tag Defaults.kuint64 proto
	fun set_field4 (value : int) (proto : t) : t = Proto.proto_set_uint64 kfield4Tag value proto
	fun clear_field4 (proto : t) : t = Proto.proto_clear_uint64 kfield4Tag proto
	val lens_field4 : (t, int) Lens = { get = get_field4, set = set_field4 }

	fun has_field5 (proto : t) : bool = Proto.proto_has_sint32 kfield5Tag proto
	fun get_field5 (proto : t) : int = Proto.proto_get_sint32 kfield5Tag Defaults.ksint32 proto
	fun set_field5 (value : int) (proto : t) : t = Proto.proto_set_sint32 kfield5Tag value proto
	fun clear_field5 (proto : t) : t = Proto.proto_clear_sint32 kfield5Tag proto
	val lens_field5 : (t, int) Lens = { get = get_field5, set = set_field5 }

	fun has_field6 (proto : t) : bool = Proto.proto_has_sint64 kfield6Tag proto
	fun get_field6 (proto : t) : int = Proto.proto_get_sint64 kfield6Tag Defaults.ksint64 proto
	fun set_field6 (value : int) (proto : t) : t = Proto.proto_set_sint64 kfield6Tag value proto
	fun clear_field6 (proto : t) : t = Proto.proto_clear_sint64 kfield6Tag proto
	val lens_field6 : (t, int) Lens = { get = get_field6, set = set_field6 }

	fun has_field7 (proto : t) : bool = Proto.proto_has_bool kfield7Tag proto
	fun get_field7 (proto : t) : bool = Proto.proto_get_bool kfield7Tag true proto
	fun set_field7 (value : bool) (proto : t) : t = Proto.proto_set_bool kfield7Tag value proto
	fun clear_field7 (proto : t) : t = Proto.proto_clear_bool kfield7Tag proto
	val lens_field7 : (t, bool) Lens = { get = get_field7, set = set_field7 }

	fun has_field8 (proto : t) : bool = Proto.proto_has_uint32 kfield8Tag proto
	fun get_field8 (proto : t) : MainMessage_NestedEnum.t = MainMessage_NestedEnum.fromInt (Proto.proto_get_uint32 kfield8Tag (MainMessage_NestedEnum.toInt MainMessage_NestedEnum.kCASE2) proto)
	fun set_field8 (value : MainMessage_NestedEnum.t) (proto : t) : t = Proto.proto_set_uint32 kfield8Tag (MainMessage_NestedEnum.toInt value) proto
	fun clear_field8 (proto : t) : t = Proto.proto_clear_uint32 kfield8Tag proto
	val lens_field8 : (t, MainMessage_NestedEnum.t) Lens = { get = get_field8, set = set_field8 }

	fun has_field9 (proto : t) : bool = Proto.proto_has_fixed32 kfield9Tag proto
	fun get_field9 (proto : t) : int = Proto.proto_get_fixed32 kfield9Tag Defaults.kfixed32 proto
	fun set_field9 (value : int) (proto : t) : t = Proto.proto_set_fixed32 kfield9Tag value proto
	fun clear_field9 (proto : t) : t = Proto.proto_clear_fixed32 kfield9Tag proto
	val lens_field9 : (t, int) Lens = { get = get_field9, set = set_field9 }

	fun has_field10 (proto : t) : bool = Proto.proto_has_fixed64 kfield10Tag proto
	fun get_field10 (proto : t) : int = Proto.proto_get_fixed64 kfield10Tag Defaults.kfixed64 proto
	fun set_field10 (value : int) (proto : t) : t = Proto.proto_set_fixed64 kfield10Tag value proto
	fun clear_field10 (proto : t) : t = Proto.proto_clear_fixed64 kfield10Tag proto
	val lens_field10 : (t, int) Lens = { get = get_field10, set = set_field10 }
	
	fun has_field11 (proto : t) : bool = Proto.proto_has_sfixed32 kfield11Tag proto
	fun get_field11 (proto : t) : int = Proto.proto_get_sfixed32 kfield11Tag Defaults.ksfixed32 proto
	fun set_field11 (value : int) (proto : t) : t = Proto.proto_set_sfixed32 kfield11Tag value proto
	fun clear_field11 (proto : t) : t = Proto.proto_clear_sfixed32 kfield11Tag proto
	val lens_field11 : (t, int) Lens = { get = get_field11, set = set_field11 }

	fun has_field12 (proto : t) : bool = Proto.proto_has_sfixed64 kfield12Tag proto
	fun get_field12 (proto : t) : int = Proto.proto_get_sfixed64 kfield12Tag Defaults.ksfixed64 proto
	fun set_field12 (value : int) (proto : t) : t = Proto.proto_set_sfixed64 kfield12Tag value proto
	fun clear_field12 (proto : t) : t = Proto.proto_clear_sfixed64 kfield12Tag proto
	val lens_field12 : (t, int) Lens = { get = get_field12, set = set_field12 }
	
	fun has_field13 (proto : t) : bool = Proto.proto_has_string kfield13Tag proto
	fun get_field13 (proto : t) : string = Proto.proto_get_string kfield13Tag Defaults.kstring proto
	fun set_field13 (value : string) (proto : t) : t = Proto.proto_set_string kfield13Tag value proto
	fun clear_field13 (proto : t) : t = Proto.proto_clear_string kfield13Tag proto
	val lens_field13 : (t, string) Lens = { get = get_field13, set = set_field13 }

	fun isValid (proto : t) : bool = 
		if not (has_field2 proto) then false else
		if not (has_field4 proto) then false else
		if not (has_field6 proto) then false else
		if not (has_field10 proto) then false else
		if not (has_field12 proto) then false else
		true
		
	fun serializeUnsafe (proto : t) : Word8.word list = Proto.serialize proto
	fun deserializeUnsafe (value : Word8.word list) : t = Proto.deserialize descriptor value
	
	fun serialize (proto : t) : Word8.word list = 
		if (isValid proto) then serializeUnsafe proto
		else raise SerializationError("Proto does not contain all required fields")
	
	fun deserialize (value : Word8.word list) : t = 
		let val proto = deserializeUnsafe value
		in
			if (isValid proto) then proto
			else raise DeserializationError("Proto does not contain all required fields")
		end
end;

structure MainMessage_NestedMessage2 =
struct	
	type t = Proto.protoType
	
	val new : t = Proto.newProto
	
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
	
	fun size_field1 (proto : t) : int = Proto.proto_repeated_size_int32 kfield1Tag proto
	fun get_field1 (proto : t) : int list = Proto.proto_repeated_get_int32 kfield1Tag proto
	fun set_field1 (value : int list) (proto : t) : t = Proto.proto_repeated_set_int32 kfield1Tag value proto
	fun add_field1 (value : int) (proto : t) : t = Proto.proto_repeated_add_int32 kfield1Tag value proto
	fun clear_field1 (proto : t) : t = Proto.proto_repeated_clear_int32 kfield1Tag proto
	val lens_field1 : (t, int list) Lens = { get = get_field1, set = set_field1}
	fun get_nth_field1 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_int32 kfield1Tag position proto
	fun set_nth_field1 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_int32 kfield1Tag position value proto
	fun lens_nth_field1 (position : int) : (t, int) Lens = { get = get_nth_field1 position, set = set_nth_field1 position}
	
	fun size_field2 (proto : t) : int = Proto.proto_repeated_size_int64 kfield2Tag proto
	fun get_field2 (proto : t) : int list = Proto.proto_repeated_get_int64 kfield2Tag proto
	fun set_field2 (value : int list) (proto : t) : t = Proto.proto_repeated_set_int64 kfield2Tag value proto
	fun add_field2 (value : int) (proto : t) : t = Proto.proto_repeated_add_int64 kfield2Tag value proto
	fun clear_field2 (proto : t) : t = Proto.proto_repeated_clear_int64 kfield2Tag proto
	val lens_field2 : (t, int list) Lens = { get = get_field2, set = set_field2}
	fun get_nth_field2 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_int64 kfield2Tag position proto
	fun set_nth_field2 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_int64 kfield2Tag position value proto
	fun lens_nth_field2 (position : int) : (t, int) Lens = { get = get_nth_field2 position, set = set_nth_field2 position}
		
	fun size_field3 (proto : t) : int = Proto.proto_repeated_size_uint32 kfield3Tag proto
	fun get_field3 (proto : t) : int list = Proto.proto_repeated_get_uint32 kfield3Tag proto
	fun set_field3 (value : int list) (proto : t) : t = Proto.proto_repeated_set_uint32 kfield3Tag value proto
	fun add_field3 (value : int) (proto : t) : t = Proto.proto_repeated_add_uint32 kfield3Tag value proto
	fun clear_field3 (proto : t) : t = Proto.proto_repeated_clear_uint32 kfield3Tag proto
	val lens_field3 : (t, int list) Lens = { get = get_field3, set = set_field3}
	fun get_nth_field3 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_uint32 kfield3Tag position proto
	fun set_nth_field3 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_uint32 kfield3Tag position value proto
	fun lens_nth_field3 (position : int) : (t, int) Lens = { get = get_nth_field3 position, set = set_nth_field3 position}
		
	fun size_field4 (proto : t) : int = Proto.proto_repeated_size_uint64 kfield4Tag proto
	fun get_field4 (proto : t) : int list = Proto.proto_repeated_get_uint64 kfield4Tag proto
	fun set_field4 (value : int list) (proto : t) : t = Proto.proto_repeated_set_uint64 kfield4Tag value proto
	fun add_field4 (value : int) (proto : t) : t = Proto.proto_repeated_add_uint64 kfield4Tag value proto
	fun clear_field4 (proto : t) : t = Proto.proto_repeated_clear_uint64 kfield4Tag proto
	val lens_field4 : (t, int list) Lens = { get = get_field4, set = set_field4}
	fun get_nth_field4 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_uint64 kfield4Tag position proto
	fun set_nth_field4 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_uint64 kfield4Tag position value proto
	fun lens_nth_field4 (position : int) : (t, int) Lens = { get = get_nth_field4 position, set = set_nth_field4 position}
		
	fun size_field5 (proto : t) : int = Proto.proto_repeated_size_sint32 kfield5Tag proto
	fun get_field5 (proto : t) : int list = Proto.proto_repeated_get_sint32 kfield5Tag proto
	fun set_field5 (value : int list) (proto : t) : t = Proto.proto_repeated_set_sint32 kfield5Tag value proto
	fun add_field5 (value : int) (proto : t) : t = Proto.proto_repeated_add_sint32 kfield5Tag value proto
	fun clear_field5 (proto : t) : t = Proto.proto_repeated_clear_sint32 kfield5Tag proto
	val lens_field5 : (t, int list) Lens = { get = get_field5, set = set_field5}
	fun get_nth_field5 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_sint32 kfield5Tag position proto
	fun set_nth_field5 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_sint32 kfield5Tag position value proto
	fun lens_nth_field5 (position : int) : (t, int) Lens = { get = get_nth_field5 position, set = set_nth_field5 position}
		
	fun size_field6 (proto : t) : int = Proto.proto_repeated_size_sint64 kfield6Tag proto
	fun get_field6 (proto : t) : int list = Proto.proto_repeated_get_sint64 kfield6Tag proto
	fun set_field6 (value : int list) (proto : t) : t = Proto.proto_repeated_set_sint64 kfield6Tag value proto
	fun add_field6 (value : int) (proto : t) : t = Proto.proto_repeated_add_sint64 kfield6Tag value proto
	fun clear_field6 (proto : t) : t = Proto.proto_repeated_clear_sint64 kfield6Tag proto
	val lens_field6 : (t, int list) Lens = { get = get_field6, set = set_field6}
	fun get_nth_field6 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_sint64 kfield6Tag position proto
	fun set_nth_field6 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_sint64 kfield6Tag position value proto
	fun lens_nth_field6 (position : int) : (t, int) Lens = { get = get_nth_field6 position, set = set_nth_field6 position}
		
	fun size_field7 (proto : t) : int = Proto.proto_repeated_size_bool kfield7Tag proto
	fun get_field7 (proto : t) : bool list = Proto.proto_repeated_get_bool kfield7Tag proto
	fun set_field7 (value : bool list) (proto : t) : t = Proto.proto_repeated_set_bool kfield7Tag value proto
	fun add_field7 (value : bool) (proto : t) : t = Proto.proto_repeated_add_bool kfield7Tag value proto
	fun clear_field7 (proto : t) : t = Proto.proto_repeated_clear_bool kfield7Tag proto
	val lens_field7 : (t, bool list) Lens = { get = get_field7, set = set_field7}
	fun get_nth_field7 (position : int) (proto : t) : bool = Proto.proto_repeated_getnth_bool kfield7Tag position proto
	fun set_nth_field7 (position : int) (value : bool) (proto : t) : t = Proto.proto_repeated_setnth_bool kfield7Tag position value proto
	fun lens_nth_field7 (position : int) : (t, bool) Lens = { get = get_nth_field7 position, set = set_nth_field7 position}
		
	fun size_field8 (proto : t) : int = Proto.proto_repeated_size_uint32 kfield8Tag proto
	fun get_field8 (proto : t) : MainMessage_NestedEnum.t list = List.map (fn x => MainMessage_NestedEnum.fromInt x) (Proto.proto_repeated_get_uint32 kfield8Tag proto)
	fun set_field8 (value : MainMessage_NestedEnum.t list) (proto : t) : t = Proto.proto_repeated_set_uint32 kfield8Tag (List.map (fn x => MainMessage_NestedEnum.toInt x) value) proto
	fun add_field8 (value : MainMessage_NestedEnum.t) (proto : t) : t = Proto.proto_repeated_add_uint32 kfield8Tag (MainMessage_NestedEnum.toInt value) proto
	fun clear_field8 (proto : t) : t = Proto.proto_repeated_clear_uint32 kfield8Tag proto
	val lens_field8 : (t, MainMessage_NestedEnum.t list) Lens = { get = get_field8, set = set_field8}
	fun get_nth_field8 (position : int) (proto : t) : MainMessage_NestedEnum.t = MainMessage_NestedEnum.fromInt (Proto.proto_repeated_getnth_uint32 kfield8Tag position proto)
	fun set_nth_field8 (position : int) (value : MainMessage_NestedEnum.t) (proto : t) : t = Proto.proto_repeated_setnth_uint32 kfield8Tag position (MainMessage_NestedEnum.toInt value) proto
	fun lens_nth_field8 (position : int) : (t, MainMessage_NestedEnum.t) Lens = { get = get_nth_field8 position, set = set_nth_field8 position}
		
	fun size_field9 (proto : t) : int = Proto.proto_repeated_size_fixed32 kfield9Tag proto
	fun get_field9 (proto : t) : int list = Proto.proto_repeated_get_fixed32 kfield9Tag proto
	fun set_field9 (value : int list) (proto : t) : t = Proto.proto_repeated_set_fixed32 kfield9Tag value proto
	fun add_field9 (value : int) (proto : t) : t = Proto.proto_repeated_add_fixed32 kfield9Tag value proto
	fun clear_field9 (proto : t) : t = Proto.proto_repeated_clear_fixed32 kfield9Tag proto
	val lens_field9 : (t, int list) Lens = { get = get_field9, set = set_field9}
	fun get_nth_field9 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_fixed32 kfield9Tag position proto
	fun set_nth_field9 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_fixed32 kfield9Tag position value proto
	fun lens_nth_field9 (position : int) : (t, int) Lens = { get = get_nth_field9 position, set = set_nth_field9 position}
		
	fun size_field10 (proto : t) : int = Proto.proto_repeated_size_fixed64 kfield10Tag proto
	fun get_field10 (proto : t) : int list = Proto.proto_repeated_get_fixed64 kfield10Tag proto
	fun set_field10 (value : int list) (proto : t) : t = Proto.proto_repeated_set_fixed64 kfield10Tag value proto
	fun add_field10 (value : int) (proto : t) : t = Proto.proto_repeated_add_fixed64 kfield10Tag value proto
	fun clear_field10 (proto : t) : t = Proto.proto_repeated_clear_fixed64 kfield10Tag proto
	val lens_field10 : (t, int list) Lens = { get = get_field10, set = set_field10}
	fun get_nth_field10 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_fixed64 kfield10Tag position proto
	fun set_nth_field10 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_fixed64 kfield10Tag position value proto
	fun lens_nth_field10 (position : int) : (t, int) Lens = { get = get_nth_field10 position, set = set_nth_field10 position}
		
	fun size_field11 (proto : t) : int = Proto.proto_repeated_size_sfixed32 kfield11Tag proto
	fun get_field11 (proto : t) : int list = Proto.proto_repeated_get_sfixed32 kfield11Tag proto
	fun set_field11 (value : int list) (proto : t) : t = Proto.proto_repeated_set_sfixed32 kfield11Tag value proto
	fun add_field11 (value : int) (proto : t) : t = Proto.proto_repeated_add_sfixed32 kfield11Tag value proto
	fun clear_field11 (proto : t) : t = Proto.proto_repeated_clear_sfixed32 kfield11Tag proto
	val lens_field11 : (t, int list) Lens = { get = get_field11, set = set_field11}
	fun get_nth_field11 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_sfixed32 kfield11Tag position proto
	fun set_nth_field11 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_sfixed32 kfield11Tag position value proto
	fun lens_nth_field11 (position : int) : (t, int) Lens = { get = get_nth_field11 position, set = set_nth_field11 position}
		
	fun size_field12 (proto : t) : int = Proto.proto_repeated_size_sfixed64 kfield12Tag proto
	fun get_field12 (proto : t) : int list = Proto.proto_repeated_get_sfixed64 kfield12Tag proto
	fun set_field12 (value : int list) (proto : t) : t = Proto.proto_repeated_set_sfixed64 kfield12Tag value proto
	fun add_field12 (value : int) (proto : t) : t = Proto.proto_repeated_add_sfixed64 kfield12Tag value proto
	fun clear_field12 (proto : t) : t = Proto.proto_repeated_clear_sfixed64 kfield12Tag proto
	val lens_field12 : (t, int list) Lens = { get = get_field12, set = set_field12}
	fun get_nth_field12 (position : int) (proto : t) : int = Proto.proto_repeated_getnth_sfixed64 kfield12Tag position proto
	fun set_nth_field12 (position : int) (value : int) (proto : t) : t = Proto.proto_repeated_setnth_sfixed64 kfield12Tag position value proto
	fun lens_nth_field12 (position : int) : (t, int) Lens = { get = get_nth_field12 position, set = set_nth_field12 position}
		
	fun size_field13 (proto : t) : int = Proto.proto_repeated_size_string kfield13Tag proto
	fun get_field13 (proto : t) : string list = Proto.proto_repeated_get_string kfield13Tag proto
	fun set_field13 (value : string list) (proto : t) : t = Proto.proto_repeated_set_string kfield13Tag value proto
	fun add_field13 (value : string) (proto : t) : t = Proto.proto_repeated_add_string kfield13Tag value proto
	fun clear_field13 (proto : t) : t = Proto.proto_repeated_clear_string kfield13Tag proto
	val lens_field13 : (t, string list) Lens = { get = get_field13, set = set_field13}
	fun get_nth_field13 (position : int) (proto : t) : string = Proto.proto_repeated_getnth_string kfield13Tag position proto
	fun set_nth_field13 (position : int) (value : string) (proto : t) : t = Proto.proto_repeated_setnth_string kfield13Tag position value proto
	fun lens_nth_field13 (position : int) : (t, string) Lens = { get = get_nth_field13 position, set = set_nth_field13 position}
	
	
	fun isValid (proto : t) =
		true
		
	fun serializeUnsafe (proto : t) : Word8.word list = Proto.serialize proto
	fun deserializeUnsafe (value : Word8.word list) : t = Proto.deserialize descriptor value
	
	fun serialize (proto : t) : Word8.word list = 
		if (isValid proto) then serializeUnsafe proto
		else raise SerializationError("Proto does not contain all required fields")
	
	fun deserialize (value : Word8.word list) : t = 
		let val proto = deserializeUnsafe value
		in
			if (isValid proto) then proto
			else raise DeserializationError("Proto does not contain all required fields")
		end
end;

structure MainMessage =
struct
	type t = Proto.protoType
	
	val new = Proto.newProto

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
	val descriptor = Proto.descriptor_add_message (kfield3Tag, MainMessage_NestedMessage.descriptor) descriptor
	val descriptor = Proto.descriptor_add_message (kfield4Tag, MainMessage_NestedMessage.descriptor) descriptor
	val descriptor = Proto.descriptor_add_rmessage (kfield5Tag, MainMessage_NestedMessage2.descriptor) descriptor
	
	datatype typeNestedOneOf = NOT_SET | kfield1 | kfield2 | kfield3
	fun case_NestedOneOf (proto : t) = 
		case Proto.proto_oneof_case kNestedOneOfTags proto of
			SOME(1) => kfield1
		|	SOME(2) => kfield2 
		| 	SOME(3) => kfield3
		|	_ => NOT_SET
	fun clear_NestedOneOf (proto : t) : t = Proto.proto_oneof_clear kNestedOneOfTags proto
	
	fun has_field1 (proto : t) : bool = Proto.proto_has_int32 kfield1Tag proto
	fun get_field1 (proto : t) : int = Proto.proto_get_int32 kfield1Tag Defaults.kint32 proto
	fun set_field1 (value : int) (proto : t) : t = Proto.proto_set_int32 kfield1Tag value (clear_NestedOneOf proto)
	fun clear_field1 (proto : t) : t = Proto.proto_clear_int32 kfield1Tag proto
	val lens_field1 : (t, int) Lens = { get = get_field1, set = set_field1 }
	
	fun has_field2 (proto : t) : bool = Proto.proto_has_uint32 kfield2Tag proto
	fun get_field2 (proto : t) : MainMessage_NestedEnum.t = MainMessage_NestedEnum.fromInt (Proto.proto_get_uint32 kfield2Tag (MainMessage_NestedEnum.toInt MainMessage_NestedEnum.default) proto)
	fun set_field2 (value : MainMessage_NestedEnum.t) (proto : t) : t = Proto.proto_set_uint32 kfield2Tag (MainMessage_NestedEnum.toInt value) (clear_NestedOneOf proto)
	fun clear_field2 (proto : t) : t = Proto.proto_clear_uint32 kfield2Tag proto
	val lens_field2 : (t, MainMessage_NestedEnum.t) Lens = { get = get_field2, set = set_field2 }
	
	fun has_field3 (proto : t) : bool = Proto.proto_has_message kfield3Tag proto
	fun get_field3 (proto : t) : MainMessage_NestedMessage.t = Proto.proto_get_message kfield3Tag MainMessage_NestedMessage.new proto
	fun set_field3 (value : MainMessage_NestedMessage.t) (proto : t) : t = Proto.proto_set_message kfield3Tag value (clear_NestedOneOf proto)
	fun clear_field3 (proto : t) : t = Proto.proto_clear_message kfield3Tag proto
	val lens_field3 : (t, MainMessage_NestedMessage.t) Lens = { get = get_field3, set = set_field3 }
	
	fun has_field4 (proto : t) : bool = Proto.proto_has_message kfield4Tag proto
	fun get_field4 (proto : t) : MainMessage_NestedMessage.t = Proto.proto_get_message kfield4Tag MainMessage_NestedMessage.new proto
	fun set_field4 (value : MainMessage_NestedMessage.t) (proto : t) : t = Proto.proto_set_message kfield4Tag value proto
	fun clear_field4 (proto : t) : t = Proto.proto_clear_message kfield4Tag proto
	val lens_field4 : (t, MainMessage_NestedMessage.t) Lens = { get = get_field4, set = set_field4 }

	fun size_field5 (proto : t) : int = Proto.proto_repeated_size_message kfield5Tag proto
	fun get_field5 (proto : t) : MainMessage_NestedMessage2.t list = Proto.proto_repeated_get_message kfield5Tag proto
	fun set_field5 (value : MainMessage_NestedMessage2.t list) (proto : t) : t = Proto.proto_repeated_set_message kfield5Tag value proto
	fun add_field5 (value : MainMessage_NestedMessage2.t) (proto : t) : t = Proto.proto_repeated_add_message kfield5Tag value proto
	fun clear_field5 (proto : t) : t = Proto.proto_repeated_clear_message kfield5Tag proto
	val lens_field5 : (t, MainMessage_NestedMessage2.t list) Lens = { get = get_field5, set = set_field5}
	fun get_nth_field5 (position : int) (proto : t) : MainMessage_NestedMessage2.t = Proto.proto_repeated_getnth_message kfield5Tag position proto
	fun set_nth_field5 (position : int) (value : MainMessage_NestedMessage2.t) (proto : t) : t = Proto.proto_repeated_setnth_message kfield5Tag position value proto
	fun lens_nth_field5 (position : int) : (t, MainMessage_NestedMessage2.t) Lens = { get = get_nth_field5 position, set = set_nth_field5 position}
	

	fun isValid (proto : t) =
		if not (has_field3 proto andalso MainMessage_NestedMessage.isValid (get_field3 proto)) then false else
		if not (has_field4 proto andalso MainMessage_NestedMessage.isValid (get_field4 proto)) then false else
		if not (List.all MainMessage_NestedMessage2.isValid (get_field5 proto)) then false else
		true
		
	fun serializeUnsafe (proto : t) : Word8.word list = Proto.serialize proto
	fun deserializeUnsafe (value : Word8.word list) : t = Proto.deserialize descriptor value
	
	fun serialize (proto : t) : Word8.word list = 
		if (isValid proto) then serializeUnsafe proto
		else raise SerializationError("Proto does not contain all required fields")
	
	fun deserialize (value : Word8.word list) : t = 
		let val proto = deserializeUnsafe value
		in
			if (isValid proto) then proto
			else raise DeserializationError("Proto does not contain all required fields")
		end
end;
