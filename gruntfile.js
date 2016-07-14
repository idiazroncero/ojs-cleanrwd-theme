module.exports = function(grunt) {
	grunt.initConfig({
		compass : {
			options: {
				config: 'config.rb',
				require: 'susy'
			},
			prod : {
				options : {
					config: 'config.rb',
					environment: 'production',
					outputStyle: 'compressed',
					trace: false,
				}
			},
			source : {
				options : {
					config: 'config.rb',
					environment: 'development',
					outputStyle: 'nested',
					cssDir : 'css/source/',
					trace: false,
				}
			},
			dev : {
				options : {
					config: 'config.rb',
					environment: 'development',
					outputStyle: 'nested',
					trace: true,
				}
			}
		},

		postcss : {
			options : {
				map : {
					inline: false, // save all sourcemaps as separate files...
          			annotation: 'css/maps' // ...to the specified directory
				},
				processors: [
                    require('autoprefixer')({
                        browsers: ['> 0.1%']
                    })
                ]
			},
			prod: {
				src: 'css/*.css'
			},
			dev : {
				src: 'css/*.css'
			}
		},

	    csscomb: {
	    	comb: {
	            files: {
	            	'css/source/styles.css' : ['css/source/styles.css']
	            }
        	}
	    },

		watch : {
			dev: {
				files: ['**/*.js', '**/*.scss', '**/*.css'],
				tasks: ['dev']
			},
			prod: {
				files: ['**/*.js', '**/*.scss', '**/*.css'],
				tasks: ['prod']
			},
			compass: {
				files: ['**/*.scss'],
				tasks: ['compass:dev']
			}
		}
	}); // Init Config

	grunt.loadNpmTasks('grunt-contrib-compass');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-postcss');
	grunt.loadNpmTasks('grunt-csscomb');

	// Carga los plugins
	grunt.registerTask('default', ['compass:prod', 'csscomb:comb', 'postcss:prod']);
	grunt.registerTask('compass-watch', ['watch:compass']);
	grunt.registerTask('dev', ['compass:dev', 'postcss:dev']);

}; // Función wrapper