require 'colors'
exports.config = null
sys = require 'sys'
exec = require('child_process').exec
fs = require 'fs'
exports.process = (title,options) ->
	cfg = exports.config
	startDate = new Date()
	console.log startDate.toString()
		.replace(/(\d\d:\d\d:\d\d).*/, "$1").replace(/^\w+\s/,'').grey,
		title.bold.cyan
	# Construct MakeMKV command
	c =	"""
		"#{cfg.makemkvcon}"
		--robot
		--directio=true
		--debug
		--decrypt
		--noscan
		--minlength=#{cfg.minlength}
		mkv
		disc:#{cfg.driveindex}
		all
		"#{cfg.mkvoutput}/#{title}"
	""".replace /\n/g, ' '
	
	try
		fs.statSync "#{cfg.mkvoutput}/#{title}"
	catch err
		fs.mkdirSync "#{cfg.mkvoutput}/#{title}"
		console.log "mkdir:"+"#{cfg.mkvoutput}/#{title}".green


	console.log '\n New Process Started With the command:'.grey
	console.log '\n'+c.bold.cyan+'\n'
	exec c, (err, stdout, stderr)->
		if err
			console.error err
		console.log stdout