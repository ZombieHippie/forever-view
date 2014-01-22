sys = require 'sys'
exec = require('child_process').exec
class Executor
	constructor:(@cfg)->
	execute:(command,callback)=>
		if(@cfg.tests and 'exec' in @cfg.tests)
			console.log "FOUND 'exec' in config.tests; skipping actual execution."
			callback(null, "TEST EXEC: "+command, null)
		else
			exec command, callback
module.exports = (cfg)->
	new Executor(cfg)