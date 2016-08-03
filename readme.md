# Clean and Responsive Theme for Open Journal Systems
__IN DEVELOPMENT - NOT READY FOR PRODUCTION__
## Development is sponsored by [http://openjournalsystems.cl/][ojscl]
*v0.1.0*

![preview](https://s31.postimg.org/pvy9hmwff/ojs0_1_0.png)

### What is this

[Open Journal System][ojs] is the leading scientific journal manager. It is awesome.

However, Open Journal System's stable version (2.x) has a __very__ outdated look and feel. If you stick to the themes shipped with the platform, you'll get a rather old-fashioned website.

Scientific journals *can* and *should* be attractive.

This theme aims to give OJS a clean, minimalistic, responsive and modern-looking skin by using modern standards lacking in the original themes:

- Custom fonts using @font-face.
- Responsive, mobile-first web design.
- Vertical rhythm.
- SASS and Grunt-based workflow.

You can use this theme as it is, but you might find it dull. This is because it is intended to serve __both__ as a minimalistic theme AND a starter kit to be extended and customised.


### Caveats

By design, OJS 2.x theme plugins are expected to affect __only the CSS layer__. This means *we are not supposed to change HTML structure*.

In order to fully modernize OJS 2.x, however, we are required to touch the underlying HTML structure for at least some of the following reasons:

- Include the viewport `<meta>` tag.
- Modify inline CSS and hard-coded, unresponsive tables.

As [Mason Theme][mason] or [Modern Theme][modern] did before, this means replicating the whole template structure __inside__ the theme plugin folder and then forcing the system to load files from that path instead of the original. 

__Please note this strategy comes with some potencial troubles__. Unlike systems like Drupal or Wordpress, OJS is __not__ expecting core `tpl.php` files to be overridden from inside the theme plugin folder. 

This means this tecnhique __opens the door to potential crashes and/or the dreaded [WSOD][wsod] (White Screen Of Death)__ if the data and logic included on the theme's templates do not mirror the core files.

In order to avoid this __please always double-check the current compatibility of the theme__ and do not update your OJS install to a newer version until a matching release of OJS Clean RWD Theme has been installed.


### Install

- Download or clone the last release
- Place the clean-rwd folder inside your OJS installation. The path is /plugins/themes
- Go to /index/admin/settings and enable the theme

### Config and develop

The `SASS` folder includes all the files that compile to `/clean-rwd/clean-rwd.css`.

The following files, placed under `/sass/init` hold the theme configuration.

#### _fonts.scss

Modify the `@import` statement to use your preferred fonts from Google Fonts. We can't support `<link>` tags since we decided not to modify the templates. 
Remember you'll have to include a new font variable as well on `/sass/init/_init.scss`.

#### _init.scss

This is where almost all configuration takes place. 

Use the SCSS variables to customize your theme. Every variable is documented and explained.

If you need to @import any SCSS gems such as Susy, etc... do it here.

### Build

A rather basic grunt workflow is included:
- `grunt default` is the same as `grunt prod`. It preprocesses the SASS files via Compass and then postprocess the result with Autoprefixer and puts the result into `/clean-rwd/clean-rwd.css` minified.
- `grunt dev` does the same thing but it outputs the css nested and mapped to the original SCSS files.
- `grunt csslint` lints the CSS file
- `grunt watch:prod` and `grunt watch:dev` watch every .scss file and do either the dev or prod tasks.

### Build (alternative)

If you don't have access to grunt or a CLI - or you don't feel comfortable - you can manually compile the CSS.

1. Go to [SassMeister](http://www.sassmeister.com).
2. ¡IMPORTANT! On the 'Options' menu, activate "Autoprefixer".
3. Copy the content of `/concat/sass-source.scss` in the left side.
4. Make your modifications on the file (variables, etc...)
5. Wait for sassmeister to compile your CSS file.
6. Substitute `/themes/plugins/clean-rwd/clean-rwd.css` with the result

### Dependencies

If you need to do your own build of the project, you'll need to have locally installed Compass and Breakpoint.
Type `gem install breakpoint` and `gem install compass` in your terminal to get them.

## TODO

- Include a .gemfile.
- Separate OJS resets and opinionated styles (i.e. menu hover effects).



[ojs]: https://pkp.sfu.ca/ojs/
[ojscl]: http://openjournalsystems.cl/
[mason]: https://github.com/masonpublishing/OJS-Theme
[modern]: https://github.com/cu-library/OJS-Modern-Theme
[wsod]: http://www.webopedia.com/TERM/W/white_screen_of_death.html