class MainView extends Backbone.View
  
  template: JST["gui/templates/template"]
  test: "test"
  
  initialize: ->
    $("body p").html @template({ test: @test })