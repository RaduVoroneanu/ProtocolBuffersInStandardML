signature STRING_HANDLER =
sig
	val serialize : string -> Word8.word list
	val deserialize : Word8.word list -> string * (Word8.word list)
end;

structure StringHandler :> STRING_HANDLER =
struct
	fun serialize (s) = 
		let val l = String.explode s
		in
			Varint.serialize (List.length l) @ (List.map (Word8.fromInt o Char.ord) l)
		end
	fun deserialize (xs) =
		let val (l, xs2) = Varint.deserialize xs
		in
			(String.implode (List.map (Char.chr o Word8.toInt) (List.take (xs2, l))), List.drop (xs2, l))
		end
end;