structure ZigZag =
struct
	fun encode (x) = 
		if x < 0 then (2 * (~x)) - 1
		else 2 * x

	fun decode (x) = 
		if x mod 2 = 0 then x div 2
		else ~((x + 1) div 2)
end:
sig
	val encode : int -> int
	val decode : int -> int
end;