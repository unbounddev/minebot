global css body c:warm2 bg:warm8 ff:Arial inset:0 d:vcc m:0 p:0

tag App
	botIp = window.localStorage.getItem("botIp") || "http://localhost:3001"
	<self [d:flex fld:column w:100vw h:100vh]>
		<input [d:block] bind=botIp>
		<iframe [fl:auto bd:none] src=botIp>

imba.mount <App>
