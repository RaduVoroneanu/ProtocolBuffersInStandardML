type ('a,'b) Lens = {get: 'a -> 'b, set: 'b -> 'a -> 'a}

fun get (lens : ('a, 'b) Lens) (data : 'a) = (#get lens) data
fun set (lens : ('a, 'b) Lens) (value : 'b) (data : 'a) = (#set lens) value (data)

infix +>
fun (l : ('a, 'b) Lens) +> (r : ('b, 'c) Lens) : ('a, 'c) Lens = 
	{ 
		get = fn x => (#get r) ((#get l) x),
		set = fn x => (fn y => (#set l) ((#set r) x ((#get l) y)) y)
	}

fun readNextVarint (v:Word8Vector.vector, p) =
	let val currentWord = Word8Vector.sub (v, p)
		val ((value, pos), currentInt) = 
			if (Word8.toInt currentWord) >= 128
			then (readNextVarint (v, p + 1), (Word8.toInt currentWord) - 128)
			else ((0, p + 1), Word8.toInt currentWord)
	in
		(currentInt + (value * 128), pos)
	end;

fun readStringList (v, left, right) = 
	if (left >= right) then []
	else (String.str (Char.chr (Word8.toInt (Word8Vector.sub (v, left))))) :: readStringList (v, left + 1, right)

fun readNextString (v:Word8Vector.vector, left, right) = 
	String.concat (readStringList (v, left, right));
	
signature PERSON_PHONETYPE = sig
	type t
	val MOBILE: t;
	val HOME : t;
	val WORK : t;
	
	val deserialize : Word8Vector.vector * int -> t * int
end;

exception DeserializationError;

structure Person_PhoneType :> PERSON_PHONETYPE = struct
	datatype t = MOBILE | HOME | WORK
	
	val MOBILE = MOBILE
	val HOME = HOME
	val WORK = WORK
	
	fun deserialize (v, p) = 
		let val (value, pos) = readNextVarint (v, p)
		in
			case value of
				0 => (MOBILE, pos)
			|   1 => (HOME, pos)
			|   2 => (WORK, pos)
			|	_ => raise DeserializationError
		end
end;

signature PERSON_PHONENUMBER = sig
	type t

	val new: t
	
	val has_number : t -> bool
	val get_number : t -> string
	val set_number : string -> t -> t
	val lens_number : (t, string) Lens
	
	val has_type : t -> bool
	val get_type : t -> Person_PhoneType.t
	val set_type : Person_PhoneType.t -> t -> t
	val lens_type : (t, Person_PhoneType.t) Lens
	
	val deserialize : Word8Vector.vector * int * int -> t
end

structure Person_PhoneNumber :> PERSON_PHONENUMBER = struct
	type t = 
	{ 
		NUMBER : string option,
		TYPE : Person_PhoneType.t option
	}
	
	val new = { NUMBER = NONE, TYPE = NONE}
	
	fun has_number (x : t) = Option.isSome (#NUMBER x)
	fun get_number (x : t) = Option.valOf (#NUMBER x)
	fun set_number (value : string) (x : t) = 
		{ NUMBER = SOME(value), TYPE = (#TYPE x)}
	val lens_number = { get = get_number, set = set_number}
	
	fun has_type (x : t) = Option.isSome (#TYPE x)
	fun get_type (x : t) = Option.valOf (#TYPE x)
	fun set_type (value : Person_PhoneType.t) (x : t) =
		{ NUMBER = (#NUMBER x), TYPE = SOME(value)}
	val lens_type = { get = get_type, set = set_type}
	
	fun deserializeHelp (v, left, right) = 
		if (left >= right) then new 
		else
		let val (value, p) = readNextVarint (v, left)
			val (fieldNumber, wireType) = (value div 8, value mod 8)
		in
			case (fieldNumber, wireType) of
				(1, 2) => 
					let val (value, pos) = readNextVarint (v, p) 
					in
						set_number (readNextString (v, pos, pos+value)) (deserializeHelp (v, pos+value, right))
					end
			|	(2, 0) => 
					let val (value, pos) = Person_PhoneType.deserialize (v, p)
					in	
						set_type (value) (deserializeHelp (v, pos, right))
					end
			|	(_,_) => raise DeserializationError
		end
	
	fun deserialize (v, left, right) = 
		deserializeHelp (v, left, right);
end	

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
	
	val deserialize : Word8Vector.vector * int * int -> t
end;

structure Person :> PERSON = struct
	type t = 
	{
		NAME : string option,
		ID : int option,
		EMAIL : string option,
		PHONE : Person_PhoneNumber.t list
	}
	
	val new = { NAME = NONE, ID = NONE, EMAIL = NONE, PHONE = []}
	
	fun has_name (x : t) = Option.isSome (#NAME x)
	fun get_name (x : t) = Option.valOf (#NAME x)
	fun set_name (value : string) (x : t) = 
		{ NAME = SOME (value), ID = (#ID x), EMAIL = (#EMAIL x), PHONE = (#PHONE) x}
	val lens_name = { get = get_name, set = set_name}
	
	fun has_id (x : t) = Option.isSome (#ID x)
	fun get_id (x : t) = Option.valOf (#ID x)
	fun set_id (value : int) (x : t) =
		{ NAME = (#NAME x), ID = SOME (value), EMAIL = (#EMAIL x), PHONE = (#PHONE x)}
	val lens_id = { get = get_id, set = set_id}
	
	fun has_email (x : t) = Option.isSome (#EMAIL x)
	fun get_email (x : t) = Option.valOf (#EMAIL x)
	fun set_email (value : string) (x : t) = 
		{ NAME = (#NAME x), ID = (#ID x), EMAIL = SOME(value), PHONE = (#PHONE x)}
	val lens_email = { get = get_email, set = set_email}
	
	fun size_phone (x : t) = List.length (#PHONE x)
	fun get_phone (x : t) = #PHONE x;
	fun set_phone value (x : t) =
		{NAME = (#NAME x), ID = (#ID x), EMAIL = (#EMAIL x), PHONE = value}
	fun get_nth_phone (pos : int) (x : t) = List.nth (#PHONE x, pos)
	fun set_nth_phone (pos : int) value (x : t) =
		{NAME = (#NAME x), ID = (#ID x), EMAIL = (#EMAIL x), 
		PHONE = (List.take (#PHONE x, pos)) @ (value :: (List.drop (#PHONE x, pos + 1)))}
	val lens_phone = {get=get_phone, set=set_phone}
	fun lens_nth_phone (n : int) = {get = (get_nth_phone n), set = (set_nth_phone n)}
	
	fun deserializeHelp (v, left, right) =
		if (left >= right) then new
		else
		let val (value, p) = readNextVarint (v, left)
			val (fieldNumber, wireType) = (value div 8, value mod 8)
		in
			case (fieldNumber, wireType) of
				(1, 2) => 
					let val (value, pos) = readNextVarint (v, p) 
					in
						set_name (readNextString (v, pos, pos+value)) (deserializeHelp (v, pos+value, right))
					end
			|	(2, 0) =>
					let val (value, pos) = readNextVarint (v, p)
					in	
						set_id (value) (deserializeHelp (v, pos, right))
					end
			|	(3, 2) =>
					let val (value, pos) = readNextVarint (v, p) 
					in
						set_email (readNextString (v, pos, pos+value)) (deserializeHelp (v, pos+value, right))
					end
			|	(4, 2) =>
					let val (value, pos) = readNextVarint (v, p)
						val recursive = deserializeHelp (v, pos+value, right)
					in
						set_phone ((Person_PhoneNumber.deserialize (v, pos, pos+value))::(get_phone recursive)) recursive
					end
			|	(_, _) => raise DeserializationError
		end;
	
	fun deserialize (v, left, right) = deserializeHelp (v, left, right);
end;

val phonenum = Word8Vector.fromList [Word8.fromInt 16, Word8.fromInt 178, Word8.fromInt 175, Word8.fromInt 157, Word8.fromInt 20, Word8.fromInt 26, Word8.fromInt 7, Word8.fromInt 116, Word8.fromInt 101, Word8.fromInt 115, Word8.fromInt 116, Word8.fromInt 105, Word8.fromInt 110, Word8.fromInt 103, Word8.fromInt 10, Word8.fromInt 7, Word8.fromInt 116, Word8.fromInt 101, Word8.fromInt 115, Word8.fromInt 116, Word8.fromInt 105, Word8.fromInt 110, Word8.fromInt 103, Word8.fromInt 34, Word8.fromInt 11, Word8.fromInt 16, Word8.fromInt 0, Word8.fromInt 10, Word8.fromInt 7, Word8.fromInt 116, Word8.fromInt 101, Word8.fromInt 115, Word8.fromInt 116, Word8.fromInt 105, Word8.fromInt 110, Word8.fromInt 103, Word8.fromInt 34, Word8.fromInt 11, Word8.fromInt 16, Word8.fromInt 0, Word8.fromInt 10, Word8.fromInt 7, Word8.fromInt 116, Word8.fromInt 101, Word8.fromInt 115, Word8.fromInt 116, Word8.fromInt 105, Word8.fromInt 110, Word8.fromInt 104];

Person.deserialize (phonenum, 0, Word8Vector.length phonenum);