###
================================================================================
  @module       :: Controller
  @name         :: Authorization
  @description  :: Process requests and responses for authorization routes.
================================================================================
###

passport = require 'passport'


AuthorizationController =
  ###
    View functions
  ###

  login: (req, res) ->
    res.view({ message: req.flash('message') })

  logout: (req, res) ->
    req.logout()
    res.redirect '/'

  ###
    Process functions
  ###

  process: (req, res) ->
    passport.authenticate('local', (error, user, information) ->
      req.logIn(user, (error) ->
        if error
          req.flash('message', information.message)
          res.redirect '/login'
        else
          req.flash('message', information.message)
          res.redirect '/'
      )
    ) req, res


module.exports = AuthorizationController
