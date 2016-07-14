module.exports = function(grunt) {
	grunt.initConfig({
		compass : {
			options: {
				// Loads compass config from its own file
				config: 'config.rb'
			},
			prod : {
				options : {
					environment: 'production',
					outputStyle: 'compressed',
					trace: false,
					force:true,
				}
			},
			dev : {
				options : {
					environment: 'development',
					outputStyle: 'nested',
					trace: true,
					force:true,
				}
			}
		},

		csslint: {
			options: {
			  csslintrc: '.csslintrc',
			  formatters: [
			    {id: 'compact', dest: 'csslint/csslint.txt'}
			  ]
			},
			custom: {
			  src: ['clean-rwd/clean-rwd.css']
			}
		},

		postcss : {
			options : {
				map : {
					inline: false, // save all sourcemaps as separate files...
          			annotation: 'clean-rwd/maps' // ...to the specified directory
				},
				processors: [
                    require('autoprefixer')({
                        browsers: ['> 0.1%']
                    })
                ],
			},
			process : {
				src: 'clean-rwd/*.css'
			}
		},

		watch : {
			dev: {
				files: ['**/*.scss'],
				tasks: ['dev']
			},
			prod: {
				files: ['**/*.scss'],
				tasks: ['prod']
			}
		}
	}); // Init Config
	
	// Load plugins
	grunt.loadNpmTasks('grunt-contrib-compass');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-csslint');
	grunt.loadNpmTasks('grunt-postcss');

	// Load tasks
	grunt.registerTask('default', ['compass:prod', 'postcss:process']);
	grunt.registerTask('dev', ['compass:dev', 'postcss:process']);
	grunt.registerTask('prod', ['compass:prod', 'postcss:process']);
	// And we also have watch:dev and watch:prod to automate both of them
	// and csslint to check the health of our CSS

}; // Grunt's wrapper function