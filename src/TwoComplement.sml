signature TWO_COMPLEMENT_SIZE =
sig
	val size : int
end;

structure TC32 = struct val size = 32 end;
structure TC64 = struct val size = 64 end;

functor TWO_COMPLEMENT (t : TWO_COMPLEMENT_SIZE) =
struct
	
	val size = t.size
	
	fun power acc (_, 0) = acc
	|	power acc (x, n) = power (acc * x) (x, n-1) 
	
	val base = power 1 (2, size)
	
	fun encode (x) = 
		if (2 * x < ~base) orelse (2 * x >= base) then raise SerializationError("Incorrect two complement structure used when encoding")
		else 
			if x > 0 then x
			else base + x
	
	fun decode (x) = 
		if (x < 0) orelse (x >= base) then raise SerializationError("Incorrect two complement structure used when decoding")
		else
			if 2 * x < base then x
			else x - base
end;

structure TwoComplement32 = TWO_COMPLEMENT(TC32);

structure TwoComplement64 = TWO_COMPLEMENT(TC64);
