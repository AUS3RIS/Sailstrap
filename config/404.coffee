###
Default 404 (not found) handler

If no matches are found, Sails will respond using this handler:

For more information on 404/notfound handling in Sails/Express, check out:
http://expressjs.com/faq.html#404-handling
###
module.exports[404] = pageNotFound = (req, res, express404Handler) ->
	statusCode = 404
	result = status: statusCode

	# If the user-agent wants a JSON response, send json
	return res.json(result, result.status)  if req.wantsJSON

	# Otherwise, serve the `views/404.*` page
	view = "404"
	res.render view, result, (err) ->
		return express404Handler()  if err
		res.render view
