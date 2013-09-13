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

bcrypt = require("bcrypt")
module.exports =
	attributes:
		username:
			type: "string"
			required: true
			unique: true

		password:
			type: "string"
			required: true

		toJSON: ->

			# this gives you an object with the current values
			obj = @toObject()

			# Remove the password object value
			delete obj.password


			# return the new object without password
			obj

	beforeCreate: (user, cb) ->
		bcrypt.genSalt 10, (err, salt) ->
			bcrypt.hash user.password, salt, (err, hash) ->
				if err
					console.log err
					cb err
				else
					user.password = hash
					cb null, user

