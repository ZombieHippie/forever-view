require 'colors'
exports.config = null
sys = require 'sys'
exec = require('child_process').exec


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
		--minlength=#{cfg.minlength}
		mkv disc:#{cfg.driveletter}
		"#{title}"
		"#{cfg.mkvoutput}\\#{title}"
	""".replace /\n/g, ' '
	console.log '\n New Process Started With the command:'.grey
	console.log c.blue.bold
	exec c, (err, stdout, stderr)->
		if err
			console.error err
		console.log stdout