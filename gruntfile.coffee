###
Gruntfile
TO-DO:
Prepare tasks for production
###
module.exports = (grunt) ->
	depsPath = grunt.option("gdsrc") or "node_modules/sails/node_modules"
	grunt.loadTasks depsPath + "/grunt-sails-linker/tasks"

	# grunt.loadTasks(depsPath + '/grunt-contrib-concat/tasks');
	# grunt.loadTasks(depsPath + '/grunt-contrib-uglify/tasks');
	# grunt.loadTasks(depsPath + '/grunt-contrib-cssmin/tasks');
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-stylus"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-jade-handlebars"

	###
	###

	# STYLES 
	styleFiles = ["gui/styles/libraries/bootstrap.css", "gui/styles/*.css"]

	# STYLES END 

	# SCRIPTS 
	libraryFiles = ["gui/libraries/socket.js", "gui/libraries/sails.js", "gui/libraries/jquery.js", "gui/libraries/handlebars.js", "gui/libraries/underscore.js", "gui/libraries/backbone.js", "gui/libraries/bootstrap.js", "gui/libraries/*.js"]
	templateFiles = ["gui/templates/*.js"]
	modelFiles = ["gui/models/*.js"]
	collectionFiles = ["gui/collections/*.js"]
	viewFiles = ["gui/views/*.js"]
	routerFiles = ["gui/routers/*.js"]
	initializeFiles = ["gui/*.js"]

	# SCRIPTS END 
	styleFiles = styleFiles.map((path) ->
		".tmp/public/" + path
	)
	libraryFiles = libraryFiles.map((path) ->
		".tmp/public/" + path
	)
	templateFiles = templateFiles.map((path) ->
		".tmp/public/" + path
	)
	modelFiles = modelFiles.map((path) ->
		".tmp/public/" + path
	)
	collectionFiles = collectionFiles.map((path) ->
		".tmp/public/" + path
	)
	viewFiles = viewFiles.map((path) ->
		".tmp/public/" + path
	)
	routerFiles = routerFiles.map((path) ->
		".tmp/public/" + path
	)
	initializeFiles = initializeFiles.map((path) ->
		".tmp/public/" + path
	)

	###
	###
	grunt.initConfig
		pkg: grunt.file.readJSON("package.json")
		clean:
			dev: [".tmp/public/**"]

		copy:
			dev:
				files: [
					expand: true
					cwd: "gui"
					src: ["**/*.!(coffee|styl|jade)"]
					dest: ".tmp/public/gui"
				]

		jade_handlebars:
			compile:
				options:
					namespace: "JST"

				files: [
					expand: true
					cwd: "gui/templates"
					src: ["*.jade"]
					dest: ".tmp/public/gui/templates"
					ext: ".js"
				]

		coffee:
			dev:
				options:
					bare: true

				files: [
					expand: true
					cwd: "gui/"
					src: ["**/*.coffee"]
					dest: ".tmp/public/gui/"
					ext: ".js"
				]

		stylus:
			dev:
				files: [
					expand: true
					cwd: "gui/styles/"
					src: ["*.styl"]
					dest: ".tmp/public/gui/styles/"
					ext: ".css"
				]

		"sails-linker":
			styles:
				options:
					startTag: "// STYLES "
					endTag: "// STYLES END "
					fileTmpl: "link(rel=\"stylesheet\", href=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": styleFiles

			libraries:
				options:
					startTag: "// LIBRARIES "
					endTag: "// LIBRARIES END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": libraryFiles

			templates:
				options:
					startTag: "// TEMPLATES "
					endTag: "// TEMPLATES END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": templateFiles

			models:
				options:
					startTag: "// MODELS "
					endTag: "// MODELS END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": modelFiles

			collections:
				options:
					startTag: "// COLLECTIONS "
					endTag: "// COLLECTIONS END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": collectionFiles

			views:
				options:
					startTag: "// VIEWS "
					endTag: "// VIEWS END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": viewFiles

			routers:
				options:
					startTag: "// ROUTERS "
					endTag: "// ROUTERS END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": routerFiles

			initialize:
				options:
					startTag: "// INITIALIZE "
					endTag: "// INITIALIZE END "
					fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
					appRoot: ".tmp/public"

				files:
					"views/**/*.jade": initializeFiles

		watch:
			api:
				files: ["api/**/*"]

			assets:
				files: ["gui/**/*"]
				tasks: ["compileAssets", "linkAssets"]

	grunt.registerTask "default", ["compileAssets", "linkAssets", "watch"]
	grunt.registerTask "compileAssets", ["clean:dev", "copy:dev", "jade_handlebars:compile", "coffee:dev", "stylus:dev"]
	grunt.registerTask "linkAssets", ["sails-linker:styles", "sails-linker:libraries", "sails-linker:templates", "sails-linker:models", "sails-linker:collections", "sails-linker:views", "sails-linker:routers", "sails-linker:initialize"]