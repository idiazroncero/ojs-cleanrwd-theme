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

		concat : {
			options: {
			  separator: '\n\n\n\n\n\n//====== CONCAT ======//\n\n\n\n\n\n',
			},
			scss: {
			  src: [
						"sass/init/_init.scss",
						"sass/init/_fonts.scss",
						"sass/init/_normalize.scss",
						"sass/init/_ojs-normalize.scss",
						"sass/pkp/_pkp_common.scss",
						"sass/pkp/_common.scss",
						"sass/pkp/_sidebar.scss",
						"sass/pkp/_tinymce.scss",
						"sass/pkp/_compiled.scss",
						"sass/modules/_forms.scss",
						"sass/modules/_breadcrumbs.scss",
						"sass/modules/_menu.scss",
						"sass/modules/_registerform.scss",
						"sass/modules/_config.scss",
						"sass/modules/_sidebar_blocks.scss",
						"sass/modules/_footer.scss",
						"sass/layout/_layout.scss"
			  		],
			  dest: 'concat/sass-source.scss',
			},
		},

		watch : {
			dev: {
				files: ['**/*.scss', '**/*.tpl'],
				tasks: ['dev']
			},
			prod: {
				files: ['**/*.scss'],
				tasks: ['prod']
			}
		},

		copy: {
		  main: {
		    files: [
		      // includes files within path
		      {expand: true, src: ['clean-rwd/**'], dest: '/home/nacho/Sites/paideia/plugins/themes/'}
		    ],
		  },
		}
	}); // Init Config
	
	// Load plugins
	grunt.loadNpmTasks('grunt-contrib-compass');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-csslint');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-postcss');

	// Load tasks
	grunt.registerTask('default', ['compass:prod', 'postcss:process']);
	grunt.registerTask('dev', ['compass:dev', 'postcss:process', 'copy:main']);
	grunt.registerTask('prod', ['compass:prod', 'postcss:process']);
	// And we also have watch:dev and watch:prod to automate both of them
	// and csslint to check the health of our CSS

}; // Grunt's wrapper function