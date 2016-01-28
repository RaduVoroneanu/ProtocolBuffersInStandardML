signature CHANNEL_CLIENT =
sig
	type channel
	val connect : string * int -> channel
	val close : channel -> unit
	
	val send : channel -> string * (Word8.word list) -> unit
	val recv : channel -> unit -> string * (Word8.word list)
end;

signature CHANNEL_SERVER =
sig
	type listener
	type channel
	
	val start : int -> listener
	val accept : listener -> channel
	val stop : listener -> unit
	
	val close : channel -> unit
	val send : channel -> string * (Word8.word list) -> unit
	val recv : channel -> unit -> string * (Word8.word list)
end;