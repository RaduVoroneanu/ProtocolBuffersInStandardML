fun server port =
	let val listener = INetSock.TCP.socket()
		val _ = Socket.bind(listener, INetSock.any port)
		val _ = Socket.listen(listener, 9)
		handle x => (Socket.close listener; raise x)
		
		fun accept() = 
			let val (conn, conn_addr) = Socket.accept listener
				val (ip, port) = INetSock.fromAddr (conn_addr)
			in
				Socket.sendVec(conn, Word8VectorSlice.full (Byte.stringToBytes "Hello World"));
				Socket.close conn;
				accept()
				handle x => (Socket.close conn; raise x)
			end
	in
		accept();
		Socket.close listener
	end