###
  # Module
  @name         :: Welcome
  @module       :: Controller
  @description  :: Contains request logic for welcome page.

  # Author
  @author       :: Austris Landmanis
  @licence      :: http://aus3ys.mit-license.org/
  @year         :: 2013
###

# REQUIRED MODULES HERE


WelcomeController =
  ###
    View functions
  ###

  index: (req, res) ->
    res.view({ message: req.flash('message') })


module.exports = WelcomeController
