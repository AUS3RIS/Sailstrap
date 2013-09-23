window.GUI =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}
	initialize: ->
		console.log "Gui init."

$(document).ready ->
	#view = new MainView()
	$('.ui.dropdown').dropdown()