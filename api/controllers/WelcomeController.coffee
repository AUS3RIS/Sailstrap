###
	# Module
	@name         :: Welcome
	@module       :: Controller
	@description  :: Contains request logic for welcome page.

	# Author
	@author       :: Austris Landmanis
	@licence      :: http://aus3ys.mit-license.org/
	@year         :: 2013

	# Contributors
	...
###

# REQUIRED MODULES HERE


WelcomeController =
	###
		View actions
	###

	index: (request, response) ->
		response.view()


module.exports = WelcomeController
