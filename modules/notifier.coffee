class Notifier
	constructor: (@cfg)->
		@nodemailer = require 'nodemailer'
	mail: (subject, html)=>
		# create reusable transport method (opens pool of SMTP connections)
		console.log {
			auth:
				user: @cfg.fromemail
				pass: @cfg.frompassword
		}
		smtpTransport = @nodemailer.createTransport "SMTP", {
			service: "Gmail"
			auth:
				user: @cfg.fromemail
				pass: @cfg.frompassword
		}

		# setup e-mail data with unicode symbols
		mailOptions = {
			from: "forever-view <#{@cfg.fromemail}>", # sender address
			to: @cfg.toemail, # list of receivers
			subject, # Subject line
			html # html body
		}
		# send mail with defined transport object
		smtpTransport.sendMail mailOptions, (error, response)->
			if(error)
				console.log(error)
			else
				console.log("Message sent: " + response.message)

			# if you don't want to use this transport object anymore, uncomment following line
			smtpTransport.close() # shut down the connection pool, no more messages
	complete: (title, output)=>
		@mail "Successful Rip: #{title}", "<h1 style='color:green'>Your movie: #{title} is finished ripping</h1><br><h2>log</h2><br><pre>#{output}</pre>"
	error: (title, output)=>
		@mail "FAILED Rip: #{title}", "<h1 style='color:red'>Your movie: #{title} has failed ripping</h1><br><h2>log</h2><br><pre>#{output}</pre>"
module.exports = (cfg)->
	new Notifier(cfg)