global css body c:warm2 bg:warm8 ff:Arial inset:0 d:vcc m:0 p:0
import {io} from 'socket.io-client'
import type {Socket} from 'socket.io-client'

let socket\Socket;

tag App
	serverIp = window.localStorage.getItem("serverIp") || ""
	def handleServerChange()
		serverIp = $ip.value.trim()
		if (socket)
			socket.disconnect()
		socket = io(serverIp)
		window.localStorage.setItem("serverIp", serverIp)

		socket.on("message", do(message)
			console.log(message)
			$frame.src = message
		)

	def mount
		handleServerChange!

	<self [d:flex fld:column w:100vw h:100vh]>
		<input$ip [d:block] @change=handleServerChange value=serverIp>
		<iframe$frame [fl:auto bd:none]>

imba.mount <App>
