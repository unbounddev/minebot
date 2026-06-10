global css body c:warm2 bg:warm8 ff:Arial inset:0 d:vcc m:0 p:0
import {io} from 'socket.io-client'
import type {Socket} from 'socket.io-client'

let socket\Socket;

tag App
	serverIp = window.localStorage.getItem("serverIp") || ""
	state = {}
	def handleServerChange
		serverIp = $ip.value.trim()
		if (socket)
			socket.disconnect()
		socket = io(serverIp)
		window.localStorage.setItem("serverIp", serverIp)

		socket.on("message", do(message)
			console.log(message)
			$frame.src = message.url
			state = message
		)

	def togglePov
		if socket
			socket.emit("pov", do(val)
				state.firstPerson = val
				$frame.src = state.url
				self.render!
			)

	def mount
		handleServerChange!
		window.addEventListener("keydown", do(e)
			console.log(e.code)
			if socket == null then return
			switch e.code
				when "ArrowLeft"
					socket.emit("move", "left", true)
					break
				when "ArrowRight"
					socket.emit("move", "right", true)
					break
				when "ArrowDown"
					socket.emit("move", "back", true)
					break
				when "ArrowUp"
					socket.emit("move", "forward", true)
					break
				when "KeyA"
					socket.emit("move", "left", true)
					break
				when "KeyD"
					socket.emit("move", "right", true)
					break
				when "KeyS"
					socket.emit("move", "back", true)
					break
				when "KeyW"
					socket.emit("move", "forward", true)
					break
				when "Space"
					socket.emit("move", "up", true)
					break
				# TODO: Handle sneak and sprint
				# TODO: Handle input, button, and iframe getting input
		)
		window.addEventListener("keyup", do(e)
			console.log(e.code)
			if socket == null then return
			switch e.code
				when "ArrowLeft"
					socket.emit("move", "left", false)
					break
				when "ArrowRight"
					socket.emit("move", "right", false)
					break
				when "ArrowDown"
					socket.emit("move", "back", false)
					break
				when "ArrowUp"
					socket.emit("move", "forward", false)
					break
				when "KeyA"
					socket.emit("move", "left", false)
					break
				when "KeyD"
					socket.emit("move", "right", false)
					break
				when "KeyS"
					socket.emit("move", "back", false)
					break
				when "KeyW"
					socket.emit("move", "forward", false)
					break
				when "Space"
					socket.emit("move", "up", false)
					break
				# TODO: Handle sneak and sprint
				# TODO: Handle input, button, and iframe getting input
		)

	<self [d:flex fld:column w:100vw h:100vh]>
		<input$ip [d:block] @change=handleServerChange value=serverIp>
		<button @click=togglePov [pos:absolute b:0 r:0]>
			if state.firstPerson
				"Bird"
			else
				"First Person"
		<iframe$frame [fl:auto bd:none]>

imba.mount <App>
