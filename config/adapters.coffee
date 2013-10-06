###
================================================================================
  @module       :: Config
  @name         :: Adapters
  @description  :: Defines application data store adapters.
================================================================================
###


module.exports.adapters =
	default: "mysql"
	
	memory:
		module: "sails-memory"
	
	disk:
		module: "sails-disk"
	
	mysql:
		module: "sails-mysql"
		host: "localhost"
		user: "root"
		password: "root"
		database: "flickreel"