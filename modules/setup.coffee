fs = require 'fs'
CS = require 'coffee-script'
module.exports = ->
	config = getCSON './config.cson'
	if config is null
		return null
	movielist = getCSON config.movielist
	if movielist is null
		return null
	return {config, movielist}
getCSON = (file)->
	try
		read = fs.readFileSync file
		read = CS.compile read.toString(), bare: on
		eval read.replace /\(\{/g, '(read={'
		return read
	catch err
		console.log err
		return null
		
		