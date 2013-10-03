###
	# Module
	@name         :: Authenticated
	@module       :: Policy
	@description  :: Defines logic used to identify authenticated users.

	# Author
	@author       :: Austris Landmanis
	@licence      :: http://aus3ys.mit-license.org/
	@year         :: 2013
###


AuthenticatedPolicy = (request, response, next) ->
	if request.isAuthenticated()
		next()
	else
		response.send 403,
			message: "You're not authenticated."


module.exports = AuthenticatedPolicy
