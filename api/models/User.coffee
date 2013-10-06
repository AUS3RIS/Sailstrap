###
================================================================================
  @module       :: Model
  @name         :: User
  @description  :: Provides user object with data model to work with.
================================================================================
###


bcrypt = require 'bcrypt'


UserModel =
  ###
    Data attributes
  ###
  
  attributes:
    username:
      type: 'string'
      required: true
      unique: true
  
    password:
      type: 'string'
      required: true
  
    toJSON: ->
      object = @toObject()
      delete object.password
      object

  ###
    Callback actions
  ### 
  
  beforeCreate: (user, callback) ->
    bcrypt.genSalt 10, (error, salt) ->
      bcrypt.hash user.password, salt, (error, hash) ->
        if error
          callback error
        else
          user.password = hash
          callback null, user


module.exports = UserModel
