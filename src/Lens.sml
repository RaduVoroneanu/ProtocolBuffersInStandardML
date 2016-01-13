type ('a,'b) Lens = 
		{
			get: 'a -> 'b, 
			set: 'b -> 'a -> 'a
		}

fun lens_get (lens : ('a, 'b) Lens) = #get lens;
fun lens_set (lens : ('a, 'b) Lens) (value : 'b) = (#set lens) value;

infix +>
fun (l : ('a, 'b) Lens) +> (r : ('b, 'c) Lens) : ('a, 'c) Lens = 
	{
		get = fn x => (#get r) ((#get l) x),
		set = fn x => (fn y => (#set l) ((#set r) x ((#get l) y)) y)
	}