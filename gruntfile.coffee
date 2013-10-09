###
================================================================================
  @module       :: Platform
  @name         :: Gruntfile
  @description  :: File used to define tasks for Grunt.
================================================================================
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

  # STYLES 
  styleFiles = [
    "ui/styles/libraries/*.css",
    "ui/styles/elements/*.css",
    "ui/styles/collections/*.css",
    "ui/styles/views/*.css",
    "ui/styles/modules/*.css",
    "ui/styles/*.css"
  ]
  # STYLES END 

  # SCRIPTS 
  libraryFiles = [
    "ui/scripts/libraries/socket.js",
    "ui/scripts/libraries/sails.js",
    "ui/scripts/libraries/jquery.js",
    "ui/scripts/libraries/bootstrap.js",
    "ui/scripts/libraries/handlebars.js",
    "ui/scripts/libraries/underscore.js",
    "ui/scripts/libraries/backbone.js",
    "ui/scripts/libraries/*.js",
  ]
  moduleFiles = ["ui/scripts/modules/*.js"]
  templateFiles = ["ui/scripts/templates/*.js"]
  modelFiles = ["ui/scripts/models/*.js"]
  collectionFiles = ["ui/scripts/collections/*.js"]
  viewFiles = ["ui/scripts/views/*.js"]
  routerFiles = ["ui/scripts/routers/*.js"]
  initializerFiles = ["ui/scripts/*.js"]
  # SCRIPTS END 
  
  styleFiles = styleFiles.map((path) -> ".tmp/public/" + path)
  libraryFiles = libraryFiles.map((path) -> ".tmp/public/" + path)
  moduleFiles = moduleFiles.map((path) -> ".tmp/public/" + path)
  templateFiles = templateFiles.map((path) -> ".tmp/public/" + path)
  modelFiles = modelFiles.map((path) -> ".tmp/public/" + path)
  collectionFiles = collectionFiles.map((path) -> ".tmp/public/" + path)
  viewFiles = viewFiles.map((path) -> ".tmp/public/" + path)
  routerFiles = routerFiles.map((path) -> ".tmp/public/" + path)
  initializerFiles = initializerFiles.map((path) -> ".tmp/public/" + path)

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    clean:
      dev: [".tmp/public/**"]

    copy:
      dev:
        files: [
          expand: true
          cwd: "ui"
          src: ["**/*.!(coffee|styl|jade)"]
          dest: ".tmp/public/ui"
        ]

    jade_handlebars:
      compile:
        options:
          namespace: "JST"
        files: [
          expand: true
          cwd: "ui/scripts/templates/"
          src: ["*.jade"]
          dest: ".tmp/public/ui/scripts/templates/"
          ext: ".js"
        ]

    coffee:
      dev:
        options:
          bare: true
        files: [
          expand: true
          cwd: "ui/"
          src: ["**/*.coffee"]
          dest: ".tmp/public/ui/"
          ext: ".js"
        ]

    stylus:
      dev:
        files: [
          expand: true
          cwd: "ui/styles/"
          src: ["*.styl"]
          dest: ".tmp/public/ui/styles/"
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
          "api/views/**/*.jade": styleFiles

      libraries:
        options:
          startTag: "// LIBRARIES "
          endTag: "// LIBRARIES END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": libraryFiles

      modules:
        options:
          startTag: "// MODULES "
          endTag: "// MODULES END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": moduleFiles

      templates:
        options:
          startTag: "// TEMPLATES "
          endTag: "// TEMPLATES END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": templateFiles

      models:
        options:
          startTag: "// MODELS "
          endTag: "// MODELS END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": modelFiles

      collections:
        options:
          startTag: "// COLLECTIONS "
          endTag: "// COLLECTIONS END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": collectionFiles

      views:
        options:
          startTag: "// VIEWS "
          endTag: "// VIEWS END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": viewFiles

      routers:
        options:
          startTag: "// ROUTERS "
          endTag: "// ROUTERS END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": routerFiles

      initializers:
        options:
          startTag: "// INITIALIZERS "
          endTag: "// INITIALIZERS END "
          fileTmpl: "script(type=\"text/javascript\", src=\"%s\")"
          appRoot: ".tmp/public"
        files:
          "api/views/**/*.jade": initializerFiles

    watch:
      api:
        files: ["api/**/*"]
      assets:
        files: ["ui/**/*", "ui/**/**/*", "ui/**/**/**/*"]
        tasks: ["compileAssets", "linkAssets"]

  grunt.registerTask "default", ["compileAssets", "linkAssets", "watch"]
  grunt.registerTask "compileAssets", ["clean:dev", "copy:dev", "jade_handlebars:compile", "coffee:dev", "stylus:dev"]
  grunt.registerTask "linkAssets", ["sails-linker:styles", "sails-linker:libraries", "sails-linker:modules", "sails-linker:templates", "sails-linker:models", "sails-linker:collections", "sails-linker:views", "sails-linker:routers", "sails-linker:initializers"]