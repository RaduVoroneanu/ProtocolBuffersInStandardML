signature REQUEST =
sig
	type t
	val new : t
	val descriptor : Proto.descriptorType

	val knameTag : int

	val has_name : t -> bool
	val get_name : t -> string
	val set_name : string -> t -> t
	val clear_name : t -> t
	val lens_name : (t, string) Lens

	val isValid : t -> bool
	val serializeUnsafe : t -> Word8.word list
	val deserializeUnsafe : Word8.word list -> t
	val serialize : t -> Word8.word list
	val deserialize : Word8.word list -> t
end;
structure Request :> REQUEST =
struct
	type t = { NAME : string option }

	val new = { NAME = NONE }

	val knameTag = 1

	val descriptor = Proto.newDescriptor
	val descriptor = Proto.descriptor_add_string knameTag descriptor

	fun has_name (t) = isSome (#NAME t)
	fun get_name (t) = 
		case #NAME t of
			SOME(value) => value
		|	_ => Defaults.kstring
	fun set_name (value) (t) = 
		{ NAME = SOME(value) }
	fun clear_name (t) = { NAME = NONE }
	val lens_name = { get = get_name, set = set_name }

	fun isValid (proto) =
		if not (has_name proto) then false else
		true

	fun serializeUnsafe (p) =
		List.concat [
			if has_name p then Varint.serialize (knameTag * 8 + 2) @ StringHandler.serialize (get_name p) else []
		]
	fun deserializeUnsafeHelp ([]) (p) = p
	|	deserializeUnsafeHelp (xs) (p) =
		let val (tag_wire, xs2) = Varint.deserialize(xs)
			val (tag, wire) = (tag_wire div 8, tag_wire mod 8)
		in
			case (tag, wire) of
				(1, 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_name (value) p) end
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

signature RESPONSE =
sig
	type t
	val new : t
	val descriptor : Proto.descriptorType

	val ktextTag : int

	val has_text : t -> bool
	val get_text : t -> string
	val set_text : string -> t -> t
	val clear_text : t -> t
	val lens_text : (t, string) Lens

	val isValid : t -> bool
	val serializeUnsafe : t -> Word8.word list
	val deserializeUnsafe : Word8.word list -> t
	val serialize : t -> Word8.word list
	val deserialize : Word8.word list -> t
end;
structure Response :> RESPONSE =
struct
	type t = { TEXT : string option }

	val new = { TEXT = NONE }

	val ktextTag = 1

	val descriptor = Proto.newDescriptor
	val descriptor = Proto.descriptor_add_string ktextTag descriptor

	fun has_text (t) = isSome (#TEXT t)
	fun get_text (t) = 
		case #TEXT t of
			SOME(value) => value
		|	_ => Defaults.kstring
	fun set_text (value) (t) = 
		{ TEXT = SOME(value) }
	fun clear_text (t) = { TEXT = NONE }
	val lens_text = { get = get_text, set = set_text }

	fun isValid (proto) =
		if not (has_text proto) then false else
		true

	fun serializeUnsafe (p) =
		List.concat [
			if has_text p then Varint.serialize (ktextTag * 8 + 2) @ StringHandler.serialize (get_text p) else []
		]
	fun deserializeUnsafeHelp ([]) (p) = p
	|	deserializeUnsafeHelp (xs) (p) =
		let val (tag_wire, xs2) = Varint.deserialize(xs)
			val (tag, wire) = (tag_wire div 8, tag_wire mod 8)
		in
			case (tag, wire) of
				(1, 2) => let val (value, xs3) = StringHandler.deserialize (xs2) in deserializeUnsafeHelp (xs3) (set_text (value) p) end
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

val ip = "10.249.90.215";
val port = 12222;

signature TALK_CLIENT = 
sig
	type stub
	val createStub : (string * int) -> stub
	val Greet : stub -> Request.t -> Response.t
end;

functor TalkClientFunctor (channel : CHANNEL_CLIENT) :> TALK_CLIENT = 
struct
	type stub = string * int
	
	fun createStub (v) = v
	
	fun Greet ((ip, port)) (req) = 
		let val c = channel.connect (ip, port)
			val ser = Request.serialize req
			val _ = channel.send c ("Greet", ser)
			val ("Greet", res) = channel.recv c ()
			val _ = channel.close c
		in
			Response.deserialize res
		end
end;

signature TALK_IMPL =
sig
	val Greet : Request.t -> Response.t
end;

signature TALK_SERVER =
sig
	val start : int -> unit 
end;

functor TalkServerFunctor (Arg: sig
								structure channel : CHANNEL_SERVER 
								structure impl : TALK_IMPL
							end) :> TALK_SERVER =
struct
	
	structure channel = Arg.channel
	structure impl = Arg.impl
	
	fun start (port) =
		let val listener = channel.start(port)
			fun accept () = 
				let val conn = channel.accept listener
					val (name, ser) = channel.recv conn ()
				in
					channel.send conn (name, solve(name, ser));
					channel.close conn;
					accept()
				end
			and solve (name, ser) = 
					case name of 
						"Greet" => Response.serialize (impl.Greet (Request.deserialize ser))
		in
			accept ()
		end
end;

structure TalkImpl :> TALK_IMPL =
struct
	fun Greet (req) =  Response.set_text ("Hello " ^ (Request.get_name req) ^ " very glad to meet you") Response.new
	fun Bye (req) = Response.set_text ("ByeBye " ^ (Request.get_name req) ) Response.new
end;

structure TalkClient = TalkClientFunctor(ChannelClient);
structure TalkServer = TalkServerFunctor(struct
											structure channel = ChannelServer
											structure impl = TalkImpl
										end);