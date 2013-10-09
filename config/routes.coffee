###
================================================================================
  @module       :: Config
  @name         :: Routes
  @description  :: Defines application routes through out application.
================================================================================
###


RoutesConfig =
  ###
    Welcome controller
  ###

  'get /':
    controller: 'welcome'
    action: 'index'

  ###
    Authorization controller
  ###

  'post /authorization':
    controller: 'authorization'
    action: 'index'

  'get /authorization/login':
    controller: 'authorization'
    action: 'login'

  'get /authorization/logout':
    controller: 'authorization'
    action: 'logout'


module.exports.routes = RoutesConfig
