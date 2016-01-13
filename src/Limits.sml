signature LIMITS =
sig
	val isValidint32 : int -> bool
	val isValidint64 : int -> bool
	val isValiduint32 : int -> bool
	val isValiduint64 : int -> bool
	val isValidsint32 : int -> bool
	val isValidsint64 : int -> bool
	val isValidfixed32 : int -> bool
	val isValidfixed64 : int -> bool
	val isValidsfixed32 : int -> bool
	val isValidsfixed64 : int -> bool
end;

structure Limits :> LIMITS =
struct
	val kPow32 = 4294967296
	val kPow64 = 18446744073709551616
	
	fun isValidint32 (x) = (2 * x >= ~kPow32) andalso (2 * x < kPow32)
	fun	isValidint64 (x) = (2 * x >= ~kPow64) andalso (2 * x < kPow64)
	fun	isValiduint32 (x) = (x >= 0) andalso (x < kPow32)
	fun	isValiduint64 (x) = (x >= 0) andalso (x < kPow64)
	fun	isValidsint32 (x) = (2 * x >= ~kPow32) andalso (2 * x < kPow32)
	fun	isValidsint64 (x) = (2 * x >= ~kPow64) andalso (2 * x < kPow64)
	fun	isValidfixed32 (x) = (x >= 0) andalso (x < kPow32)
	fun	isValidfixed64 (x) = (x >= 0) andalso (x < kPow64)
	fun	isValidsfixed32 (x) = (2 * x >= ~kPow32) andalso (2 * x < kPow32)
	fun	isValidsfixed64 (x) = (2 * x >= ~kPow64) andalso (2 * x < kPow64)
end;