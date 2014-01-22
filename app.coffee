# Build
config = do require './modules/setup'
console.log "\nFOREVER-VIEW\n"
processor = require './modules/processor'
processor.config = config.config
for title, options of config.movielist
	processor.process title, options