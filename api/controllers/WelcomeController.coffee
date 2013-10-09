###
================================================================================
  @module       :: Controller
  @name         :: Welcome
  @description  :: Process requests and responses for welcome routes.
================================================================================
###

# REQUIRED MODULES HERE


WelcomeController =
  ###
    View functions
  ###

  index: (req, res) ->
   # res.view({ message: req.flash('message') })
   res.view()


module.exports = WelcomeController
