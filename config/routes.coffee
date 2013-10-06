###
================================================================================
  @module       :: Config
  @name         :: Routes
  @description  :: Defines application routes through out application.
================================================================================
###


ApplicationRoutes =
  # Welcome routes
  "get /":
    controller: "welcome"
    action: "index"
  
  # Authorization routes
  "get /login":
    controller: "authorization"
    action: "login"
  
  "get /logout":
    controller: "authorization"
    action: "logout"
  
  "post /process":
    controller: "authorization"
    action: "process"


module.exports.routes = ApplicationRoutes
