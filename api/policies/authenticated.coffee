###
================================================================================
  @module       :: Policy
  @name         :: Authenticated
  @description  :: Defines authenticated access within application.
================================================================================
###


AuthenticatedPolicy = (request, response, next) ->
	if request.isAuthenticated()
		next()
	else
		response.send 403,
			message: "You're not authenticated."


module.exports = AuthenticatedPolicy
