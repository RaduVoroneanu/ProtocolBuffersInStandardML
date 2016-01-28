fun client ip port = 
	let val addr = INetSock.toAddr (valOf(NetHostDB.fromString(ip)), port)
		val sock = INetSock.TCP.socket()
		
		fun rpc sock = 
			let val _ = Socket.connect(sock, addr)
				val _ = print "connected "
				val msg = Socket.recvVec(sock, 1000)
				val text = Byte.bytesToString msg
			in
				print text;
				Socket.close sock
			end
			handle x => (Socket.close sock; raise x)
	in
		rpc sock
	end