structure Person =
struct
	type t = Proto.protoType

	val new : t = Proto.newProto

	val knameTag = 1
	val kemailTag = 2

	val descriptor = Proto.newDescriptor
	val descriptor = Proto.descriptor_add_string knameTag descriptor
	val descriptor = Proto.descriptor_add_string kemailTag descriptor

	fun has_name (proto : t) : bool = Proto.proto_has_string knameTag proto
	fun get_name (proto : t) : string = Proto.proto_get_string knameTag Defaults.kstring proto
	fun set_name (value : string) (proto : t) : t = Proto.proto_set_string knameTag value proto
	fun clear_name (proto : t) : t = Proto.proto_clear_string knameTag proto
	val lens_name : (t, string) Lens = { get = get_name, set = set_name }

	fun has_email (proto : t) : bool = Proto.proto_has_string kemailTag proto
	fun get_email (proto : t) : string = Proto.proto_get_string kemailTag Defaults.kstring proto
	fun set_email (value : string) (proto : t) : t = Proto.proto_set_string kemailTag value proto
	fun clear_email (proto : t) : t = Proto.proto_clear_string kemailTag proto
	val lens_email : (t, string) Lens = { get = get_email, set = set_email }

	fun isValid (proto : t) =

		true

	fun serializeUnsafe (proto : t) : Word8.word list = Proto.serialize proto
	fun deserializeUnsafe (value : Word8.word list) : t = Proto.deserialize descriptor value

	fun serialize (proto : t) =
		if isValid proto then serializeUnsafe proto
		else raise SerializationError("Proto is missing required fields")
	fun deserialize (xs : Word8.word list) =
		let val proto = deserializeUnsafe xs 
		in
			if isValid proto then proto
			else raise DeserializationError("Proto is missing fields")
		end
end;

