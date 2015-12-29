signature VARINT = 
sig
	val base : int
	val serialize : int -> Word8.word list
	val deserialize : Word8.word list -> int * (Word8.word list)
end

structure Varint:VARINT = 
struct
	val base = 128
	
	fun serialize (x) = 
		if (x < base) then [Word8.fromInt x]
		else (Word8.fromInt (x mod base + base)) :: (serialize (x div base))
	
	fun deserialize ([]) = raise DeserializationError("Varint: end of list reached, but more bytes are expected")
	|	deserialize (x::xs) = 
			let val v = Word8.toInt(x)
				val (a, b) = 
					if (v >= base) then (deserialize xs)
					else (0, [])
			in
				if (v >= base) then (v - base + base * a, b)
				else (v, xs)
			end
end;
