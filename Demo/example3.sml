type ('a,'b) Lens = {get: 'a -> 'b, set: 'b -> 'a -> 'a}

fun get (lens : ('a, 'b) Lens) (data : 'a) = (#get lens) data
fun set (lens : ('a, 'b) Lens) (value : 'b) (data : 'a) = (#set lens) value (data)

infix +>
fun (l : ('a, 'b) Lens) +> (r : ('b, 'c) Lens) : ('a, 'c) Lens =
	{
		get = fn x => (#get r) ((#get l) x),
		set = fn x => (fn y => (#set l) ((#set r) x ((#get l) y)) y)
	}


signature PERSON_B_C = sig
	type t
	val new : t
	val has_d : t -> bool
	val get_d : t -> string
	val set_d : string -> t -> t
	val lens_d : (t, string) Lens
end;
structure Person_B_C :> PERSON_B_C = struct
	type t = {D : string option}
	val new = {D=NONE}
	fun has_d (x : t) = Option.isSome (#D x)
	fun get_d (x : t) = Option.valOf (#D x)
	fun set_d (value : string) (x : t) = {D=SOME(value)}
	val lens_d = { get = get_d, set = set_d}
end;

signature PERSON_B = sig
	type t
	val new : t
end;
structure Person_B :> PERSON_B = struct
	type t = { }
	val new = { }
end;
signature PERSON_PHONETYPE = sig
	type t
	val Mobile : t
	val Home : t
	val Work : t
end;
structure Person_PhoneType :> PERSON_PHONETYPE = struct
	datatype t = MOBILE| HOME| WORK
	val Mobile = MOBILE
	val Home = HOME
	val Work = WORK
end;

signature PERSON_PHONENUMBER = sig
	type t
	val new : t
	val has_number : t -> bool
	val get_number : t -> string
	val set_number : string -> t -> t
	val lens_number : (t, string) Lens
	val has_type : t -> bool
	val get_type : t -> Person_PhoneType.t
	val set_type : Person_PhoneType.t -> t -> t
	val lens_type : (t, Person_PhoneType.t) Lens
	val has_something : t -> bool
	val get_something : t -> Person_B_C.t
	val set_something : Person_B_C.t -> t -> t
	val lens_something : (t, Person_B_C.t) Lens
end;
structure Person_PhoneNumber :> PERSON_PHONENUMBER = struct
	type t = {NUMBER : string option, TYPE : Person_PhoneType.t option, SOMETHING : Person_B_C.t option}
	val new = {NUMBER=NONE, TYPE=NONE, SOMETHING=NONE}
	fun has_number (x : t) = Option.isSome (#NUMBER x)
	fun get_number (x : t) = Option.valOf (#NUMBER x)
	fun set_number (value : string) (x : t) = {NUMBER=SOME(value), TYPE=(#TYPE x), SOMETHING=(#SOMETHING x)}
	val lens_number = { get = get_number, set = set_number}
	fun has_type (x : t) = Option.isSome (#TYPE x)
	fun get_type (x : t) = Option.valOf (#TYPE x)
	fun set_type (value : Person_PhoneType.t) (x : t) = {NUMBER=(#NUMBER x), TYPE=SOME(value), SOMETHING=(#SOMETHING x)}
	val lens_type = { get = get_type, set = set_type}
	fun has_something (x : t) = Option.isSome (#SOMETHING x)
	fun get_something (x : t) = Option.valOf (#SOMETHING x)
	fun set_something (value : Person_B_C.t) (x : t) = {NUMBER=(#NUMBER x), TYPE=(#TYPE x), SOMETHING=SOME(value)}
	val lens_something = { get = get_something, set = set_something}
end;

signature PERSON = sig
	type t
	val new : t
	val has_name : t -> bool
	val get_name : t -> string
	val set_name : string -> t -> t
	val lens_name : (t, string) Lens
	val has_id : t -> bool
	val get_id : t -> int
	val set_id : int -> t -> t
	val lens_id : (t, int) Lens
	val has_email : t -> bool
	val get_email : t -> string
	val set_email : string -> t -> t
	val lens_email : (t, string) Lens
	val size_phone : t -> int
	val get_phone : t -> Person_PhoneNumber.t list
	val set_phone : Person_PhoneNumber.t list -> t -> t
	val get_nth_phone : int -> t -> Person_PhoneNumber.t
	val set_nth_phone : int -> Person_PhoneNumber.t -> t -> t
	val lens_phone : (t, Person_PhoneNumber.t list) Lens
	val lens_nth_phone : int -> (t, Person_PhoneNumber.t) Lens
end;
structure Person :> PERSON = struct
	type t = {NAME : string option, ID : int option, EMAIL : string option, PHONE : Person_PhoneNumber.t list}
	val new = {NAME=NONE, ID=NONE, EMAIL=NONE, PHONE=[]}
	fun has_name (x : t) = Option.isSome (#NAME x)
	fun get_name (x : t) = Option.valOf (#NAME x)
	fun set_name (value : string) (x : t) = {NAME=SOME(value), ID=(#ID x), EMAIL=(#EMAIL x), PHONE=(#PHONE x)}
	val lens_name = { get = get_name, set = set_name}
	fun has_id (x : t) = Option.isSome (#ID x)
	fun get_id (x : t) = Option.valOf (#ID x)
	fun set_id (value : int) (x : t) = {NAME=(#NAME x), ID=SOME(value), EMAIL=(#EMAIL x), PHONE=(#PHONE x)}
	val lens_id = { get = get_id, set = set_id}
	fun has_email (x : t) = Option.isSome (#EMAIL x)
	fun get_email (x : t) = Option.valOf (#EMAIL x)
	fun set_email (value : string) (x : t) = {NAME=(#NAME x), ID=(#ID x), EMAIL=SOME(value), PHONE=(#PHONE x)}
	val lens_email = { get = get_email, set = set_email}
	fun size_phone (x : t) = List.length (#PHONE x)
	fun get_phone (x : t) = (#PHONE x)
	fun set_phone value (x : t) = {NAME=(#NAME x), ID=(#ID x), EMAIL=(#EMAIL x), PHONE=value}
	fun get_nth_phone (pos : int) (x : t) = List.nth (#PHONE x, pos)
	fun set_nth_phone (pos : int) value (x : t) = {NAME=(#NAME x), ID=(#ID x), EMAIL=(#EMAIL x), PHONE=(List.take (# PHONE x, pos)) @ (value :: (List.drop (#PHONE x, pos + 1))) }
	val lens_phone = {get=get_phone, set=set_phone}
	fun lens_nth_phone (n : int) = {get = (get_nth_phone n), set = (set_nth_phone n)}
end;
