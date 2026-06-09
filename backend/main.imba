global.E = do console.error(...$0); process.exit(1)

import 'imba/colors'
import { program } from 'commander'
import { version } from './package.json'
import mineflayer from 'mineflayer'
import { mineflayer as mineflayerViewer } from 'prismarine-viewer'
import express from 'express'
import { createServer } from 'node:http'
import { Server } from 'socket.io'
import cors from 'cors'

const app = express!
app.use(cors(
	origin: "*"
))
const server = createServer(app)
const io = new Server(server, {
	cors: {
		origin: "*"
	}
})


program
	.name("binary-name")
	.description("CLI tool made with imba")
	.argument('<name>', 'bot name')
	.option('--mcp, --mc-port <port>', 'mc server port')
	.option('--bp, --bot-port <port>', 'bot port')
	.option('-p, --port <port>', 'server port')
	.option('--ip <ip>', 'server ip')
	.version(version)
	.showHelpAfterError!

# def main
# program.parse!
# let opts = program.opts!
# let args = program.args
# let s = args[0]
# console.log s[opts.color] or s

# main!

program.parse!
let opts = program.opts!
let args = program.args
let botName = args[0]
let botPort = opts.botPort or 3001


const bot = mineflayer.createBot
	host: opts.ip or 'localhost' # minecraft server ip
	username: botName # username to join as if auth is `offline`, else a unique identifier for this account. Switch if you want to change accounts
	auth: 'offline' # for offline mode servers, you can set this to 'offline'
	port: opts.mcPort or 25565   # set if you need a port that isn't 25565
	# version: false,           # only set if you need a specific version or snapshot (ie: "1.8.9" or "1.16.5"), otherwise it's set automatically
	# password: '12345678'      # set if you want to use password-based auth (may be unreliable). If specified, the `username` must be an email

bot.on('chat', do(username, message)
	if username === bot.username
		return
	bot.chat(message)
)


bot.once('spawn', do
	console.log("{botName} spawned!")
	mineflayerViewer(bot, { 
		port: botPort
		# firstPerson: true
	}) # port is the minecraft server port, if first person is false, you get a bird's-eye view
)

// Log errors and kick reasons:
bot.on('kicked', console.log)
bot.on('error', console.log)

io.on('connection', do(socket)
	console.log("a user connected: {socket.id}")
	socket.emit("message", "http://localhost:{botPort}")
	socket.on('disconnect', do(reason)
		console.log("user disconnected")
	)
)

server.listen(opts.port || 3000)