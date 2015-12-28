structure Lenses = struct
	datatype ('a,'b) lens = Lens of ('a -> 'b) * ('b -> 'a -> 'a)
	fun get (Lens (x, _)) = x
	fun set (Lens (_, x)) = x
	fun lens x = Lens x
	fun +> (a, b) = Lens(
		fn x => get b (get a x),
		fn x => (fn y => set a (set b x (get a y)) y) )
end:
sig
	type ('a,'b) lens
	val get : ('a,'b) lens -> ('a -> 'b)
	val set : ('a,'b) lens -> ('b -> 'a -> 'a)
	val lens : ('a -> 'b) * ('b -> 'a -> 'a) -> ('a, 'b) lens
	val +> : ('a,'b) lens * ('b, 'c) lens -> ('a, 'c) lens
end;

val op> = Lenses.+>;

val get_first = fn (x, _) => x;
val get_second = fn (_, x) => x;
val set_first = fn x => (fn (_, y) => (x, y));
val set_second = fn x => (fn (y, _) => (y, x));

val l11: (int*(int* int), int) Lenses.lens = Lenses.lens(get_first, set_first);
val l12: (int*(int* int), int*int) Lenses.lens = Lenses.lens(get_second, set_second);
val l21: (int*int, int) Lenses.lens = Lenses.lens(get_first, set_first);
val l22: (int*int, int) Lenses.lens = Lenses.lens(get_second, set_second);

val l1 = l11;
val l2 = l12 > l21;
val l3 = l12 > l22;




datatype 'a maybe = None | Value of 'a;

datatype PhoneType = MOBILE | HOME | WORK;

structure PhoneNumber = struct
	datatype PHONE_NUMBER = PhoneNumber of (string maybe * PhoneType maybe)
	
	val empty = PhoneNumber(None, None)

	fun getter_phone (PhoneNumber(x, _)) = x

	fun setter_phone x (PhoneNumber(_, y)) = PhoneNumber(x, y)

	val lphone = Lenses.lens (getter_phone, setter_phone)
end :
sig
	type PHONE_NUMBER
	val empty: PHONE_NUMBER
	val getter_phone: PHONE_NUMBER -> string maybe
	val setter_phone: string maybe-> PHONE_NUMBER -> PHONE_NUMBER
	val lphone: (PHONE_NUMBER, string maybe) Lenses.lens
end;