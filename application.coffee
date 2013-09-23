# Start sails and pass it command line arguments
sails = require("sails")
sails.lift require("optimist").argv
