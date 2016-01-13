signature BOOLEAN =
sig
	val encode : bool -> int
	val decode : int -> bool
end;

structure Boolean =
struct
	fun encode (x) = if x then 1 else 0
	fun decode (x) = x > 0
end;
