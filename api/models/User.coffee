###
	# Module
	@name         :: User
	@module       :: Model
	@description  :: Defines data model for user.

	# Author
	@author       :: Austris Landmanis
	@licence      :: http://aus3ys.mit-license.org/
	@year         :: 2013

	# Contributors
	...
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
					console.log error
					callback error
				else
					user.password = hash
					callback null, user


module.exports = UserModel
