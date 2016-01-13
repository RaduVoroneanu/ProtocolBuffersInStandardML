signature TWO_COMPLEMENT_SIZE =
sig
	val size : int
end;

structure TC32 = struct val size = 32 end;
structure TC64 = struct val size = 64 end;

signature TWO_COMPLEMENT =
sig
	val base : int
	val encode : int -> int
	val decode : int -> int
end;

functor TWO_COMPLEMENT (t : TWO_COMPLEMENT_SIZE) :> TWO_COMPLEMENT =
struct
	
	val size = t.size
	
	fun power acc (_, 0) = acc
	|	power acc (x, n) = power (acc * x) (x, n-1) 
	
	val base = power 1 (2, size)
	
	fun encode (x) = 
		if x > 0 then x
		else base + x
	
	fun decode (x) = 
		if 2 * x < base then x
		else x - base
end

structure TwoComplement32 = TWO_COMPLEMENT(TC32);

structure TwoComplement64 = TWO_COMPLEMENT(TC64);
