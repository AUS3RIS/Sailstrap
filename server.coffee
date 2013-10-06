###
================================================================================
  @module       :: Platform
  @name         :: Server
  @description  :: File used to start server with applications.
================================================================================
###


forever = require 'forever'

launch = (name) ->
  console.log 'launch: ' + name
  forever.start ['coffee', name + '.coffee'], {} # log options

launch 'application'
