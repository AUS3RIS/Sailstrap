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
    Process functions
  ###

  index: (req, res) ->
    passport.authenticate('local', (err, user, info) ->
      req.logIn(user, (err) ->
        if err
          req.flash('message', info.message)
          res.redirect '/authorization/login'
        else
          req.flash('message', info.message)
          res.redirect '/'
      )
    ) req, res

  ###
    View functions
  ###

  login: (req, res) ->
    res.view({ message: req.flash('message') })

  logout: (req, res) ->
    req.logout()
    res.redirect '/'


module.exports = AuthorizationController
