structure ChannelServer :> CHANNEL_SERVER =
struct
	type listener = (INetSock.inet, Socket.passive Socket.stream) Socket.sock
	type channel = (INetSock.inet, Socket.active Socket.stream) Socket.sock
	
	fun start (port) =
		let val listener = INetSock.TCP.socket()
			val _ = Socket.bind(listener, INetSock.any port)
			val _ = Socket.listen(listener, 16)
		in
			listener
		end
		
	fun accept (listener) = 
		let val (conn, conn_addr) = Socket.accept listener
		in
			conn
		end;
	fun send (sock) (name, ser) = 
		let val info = StringHandler.serialize (name)
			val data = info @ ser
			val data = Varint.serialize (List.length data) @ data
		in
			ignore(Socket.sendVec (sock, Word8VectorSlice.full(Word8Vector.fromList data)))
		end
	
	fun readLimit (sock, limit) =
		Word8Vector.foldr (op::) [] (Socket.recvVec (sock, limit))
	fun recv (sock) () =
		let val data = readLimit(sock, 64)
			val (l, data) = Varint.deserialize (data)
			val remaining = l - List.length(data)
			val data = data @ (if remaining > 0 then readLimit(sock, remaining) else [])
		in
			StringHandler.deserialize data
		end
		
	fun stop (sock) = Socket.close (sock)
	fun close (sock) = Socket.close (sock)
	
end;

structure ChannelClient :> CHANNEL_CLIENT = 
struct
	type channel = (INetSock.inet, Socket.active Socket.stream) Socket.sock
	
	fun connect (ip, port) =
		let val addr = INetSock.toAddr (valOf(NetHostDB.fromString(ip)), port)
			val sock = INetSock.TCP.socket()
		in
			Socket.connect(sock, addr); sock
		end;
	fun close (sock) = Socket.close (sock)
	
	fun send (sock) (name, ser) = 
		let val info = StringHandler.serialize (name)
			val data = info @ ser
			val data = Varint.serialize (List.length data) @ data
		in
			ignore(Socket.sendVec (sock, Word8VectorSlice.full(Word8Vector.fromList data)))
		end
	
	fun readLimit (sock, limit) =
		Word8Vector.foldr (op::) [] (Socket.recvVec (sock, limit))
	fun recv (sock) () =
		let val data = readLimit(sock, 64)
			val (l, data) = Varint.deserialize (data)
			val remaining = l - List.length(data)
			val data = data @ (if remaining > 0 then readLimit(sock, remaining) else [])
		in
			StringHandler.deserialize data
		end
		
end;