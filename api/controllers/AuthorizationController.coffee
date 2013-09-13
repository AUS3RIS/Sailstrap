###
	# Module
	@name         :: Authorization
	@module       :: Controller
	@description  :: Contains request logic for authorization process.

	# Author
	@author       :: Austris Landmanis
	@licence      :: http://aus3ys.mit-license.org/
	@year         :: 2013

	# Contributors
	...
###

passport = require 'passport'


AuthorizationController =
	###
		View actions
	###

	login: (request, response) ->
		response.view()

	logout: (request, response) ->
		request.logout()
		response.redirect '/'

	###
		Logic actions
	###

	process: (request, response) ->
		passport.authenticate('local', (error, user, information) ->
			request.logIn(user, (error) ->
				if error
					response.redirect '/login'
				else
					response.redirect '/'
			)
		) request, response


module.exports = AuthorizationController
