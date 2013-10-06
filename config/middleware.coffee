###
================================================================================
  @module       :: Config
  @name         :: Middleware
  @description  :: Defines custom middleware for application.
================================================================================
###

flash = require("connect-flash")
passport = require("passport")
LocalStrategy = require("passport-local").Strategy


module.exports =
	appName: "Sailstrap"
	express:
		customMiddleware: (app) ->
			console.log "express middleware for views path"
			app.set "views", process.cwd() + "/api/views"
			console.log "express midleware for passport"
			app.use passport.initialize()
			app.use passport.session()
			app.use flash()