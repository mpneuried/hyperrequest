module.exports = (grunt) ->
	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')
		watch:
			module:
				files: ["_src/**/*.coffee"]
				tasks: [ "coffee:base" ]
			
		coffee:
			base:
				expand: true
				cwd: '_src',
				src: ["**/*.coffee"]
				dest: ''
				ext: '.js'

		clean:
			base:
				src: [ "lib", "test" ]

		includereplace:
			pckg:
				options:
					globals:
						version: "<%=pkg.version%>"

					prefix: "@@"
					suffix: ''

				files:
					"index.js": ["index.js"]

		
		mochacli:
			options:
				require: [ "should" ]
				reporter: "spec"
				bail: process.env.BAIL or false
				timeout: 3000
				slow: 3

			main:
				src: [ "test/main.js" ]
		

	# Load npm modules
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-mocha-cli"
	grunt.loadNpmTasks "grunt-include-replace"
	
	# ALIAS TASKS
	grunt.registerTask "default", "build"
	grunt.registerTask "clear", [ "clean:base" ]
	grunt.registerTask "test", [ "build", "mochacli:main" ]

	# ALIAS SHORTS
	grunt.registerTask "w", "watch"
	grunt.registerTask "b", "build"
	grunt.registerTask "t", "test"

	# build the project
	grunt.registerTask "build", [ "clear", "coffee:base", "includereplace" ]
