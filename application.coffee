###
================================================================================
  @module       :: Platform
  @name         :: Application
  @description  :: File used to initialize application.
================================================================================
###

sails = require 'sails'
optimist = require('optimist').argv


sails.lift optimist
