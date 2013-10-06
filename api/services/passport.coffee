###
================================================================================
  @module       :: Service
  @name         :: Passport
  @description  :: Implementation for passport service to use in application.
================================================================================
###

bcrypt = require("bcrypt")
passport = require("passport")
LocalStrategy = require("passport-local").Strategy


###
  Helper functions
###

helperFindById = (id, next) ->
  User.findOne(id).done (error, user) ->
    if error
      next null, null
    else
      next null, user

helperFindByUsername = (username, next) ->
  User.findOne(username: username).done (error, user) ->
    if error
      next null, null
    else
      next null, user

###
  Serialize functions
###

passport.serializeUser (user, next) ->
  next null, user.id

passport.deserializeUser (id, next) ->
  helperFindById id, (error, user) ->
    next error, user

###
  Strategy functions
###

passport.use new LocalStrategy((username, password, next) ->
  process.nextTick ->
    helperFindByUsername username, (error, user) ->
      return next(null, error) if error
      unless user
        return next(null, false, message: "Unknown user " + username)
      bcrypt.compare password, user.password, (error, res) ->
        unless res
          return next(null, false, message: "Invalid Password")
        returnUser =
          username: user.username
          createdAt: user.createdAt
          id: user.id
        next(null, returnUser, message: "Logged In Successfully")
)