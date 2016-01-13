signature FIXED =
sig
	val serialize : int -> Word8.word list
	val deserialize : Word8.word list -> int * (Word8.word list)
end

structure Fixed32 :> FIXED =
struct
	fun serialize (x) =
		Word8.fromInt (x mod 256) :: Word8.fromInt (x div 256 mod 256) :: Word8.fromInt (x div 65536 mod 256) ::
			Word8.fromInt(x div 16777216 mod 256) :: []
			
	fun deserialize (x1::x2::x3::x4::l) = 
		( Word8.toInt (x1) + 256 * Word8.toInt (x2) + 65536 * Word8.toInt (x3) + 16777216 * Word8.toInt (x4) , l)
	|	deserialize (_) = raise DeserializationError("Fixed32: could not find enough bytes to serialize")
end

structure Fixed64 :> FIXED =
struct
	fun serialize (x) = 
		(Fixed32.serialize (x mod 4294967296)) @ (Fixed32.serialize (x div 4294967296))
	fun deserialize (x) =
		let val (bottom, l) = Fixed32.deserialize x
			val (top, l2) = Fixed32.deserialize l
		in
			(bottom + 4294967296 * top, l2)
			handle DeserializationError _ => raise DeserializationError("Fixed64: could not find enough bytes to serialize")
		end
end