require 'colors'
fs = require 'fs'
class Processor
	constructor:(@cfg)->
		@notif = require('./notifier')(@cfg)
		@executor = require('./executor')(@cfg)
	process: (title,options) =>
		startDate = new Date()
		console.log startDate.toString()
			.replace(/(\d\d:\d\d:\d\d).*/, "$1").replace(/^\w+\s/,'').grey,
			title.bold.cyan
		# Construct MakeMKV command
		c =	"""
			"#{@cfg.makemkvcon}"
			--robot
			--directio=true
			--debug
			--decrypt
			--noscan
			--minlength=#{@cfg.minlength}
			mkv
			disc:#{@cfg.driveindex}
			all
			"#{@cfg.mkvoutput}/#{title}"
		""".replace /\n/g, ' '
		
		if @cfg.tests and 'mkdir' in @cfg.tests
			console.log "FOUND 'mkdir' in config.tests; skipping folder check and make."
		else
			try
				fs.statSync "#{@cfg.mkvoutput}/#{title}"
			catch err
				fs.mkdirSync "#{@cfg.mkvoutput}/#{title}"
				console.log "mkdir:"+"#{@cfg.mkvoutput}/#{title}".green

		console.log '\n New Process Started With the command:'.grey
		console.log '\n'+c.bold.cyan+'\n'
		require('./executor')(@cfg).execute c, (err, stdout, stderr)=>
			if err
				@notif.error title, stderr.toString()
			else
				@notif.complete title, stdout.toString()
module.exports = (cfg)->
	new Processor(cfg)