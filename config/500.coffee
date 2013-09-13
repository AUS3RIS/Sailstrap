###
Default error handler

If an error is thrown, Sails will respond using this default error handler

For more information on error handling in Sails/Express, check out:
http://expressjs.com/guide.html#error-handling
###
module.exports[500] = serverErrorOccurred = (errors, req, res, expressErrorHandler) ->
	statusCode = 500

	# Ensure that `errors` is a list
	displayedErrors = (if (typeof errors isnt "object" or not errors.length) then [errors] else errors)

	# Build data for response
	response = status: statusCode

	# Ensure that each error is formatted correctly
	inspect = require("util").inspect
	for i of displayedErrors

		# Make error easier to read, and normalize its type
		displayedErrors[i] = new Error(inspect(displayedErrors[i]))  unless displayedErrors[i] instanceof Error
		displayedErrors[i] =
			message: displayedErrors[i].message
			stack: displayedErrors[i].stack


		# Log error to log adapter
		sails.log.error displayedErrors[i].stack

	# In production, don't display any identifying information about the error(s)
	response.errors = displayedErrors  if sails.config.environment is "development"

	# If the user-agent wants a JSON response,
	# respond with a JSON-readable version of errors
	return res.json(response, response.status)  if req.wantsJSON

	# Otherwise, if it can be rendered, the `views/500.*` page is rendered
	# If an error occurs rendering the 500 view ITSELF,
	# use the built-in Express error handler to render the errors
	view = "500"
	res.render view, response, (err) ->
		return expressErrorHandler(errors)  if err
		res.render view, response
