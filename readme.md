# IN DEVELOPMENT - NOT READY FOR PRODUCTION
## Open Journal System Clean, Responsive Theme
*v0.0.2*

### What is this

[Open Journal System][ojs] is the leading scientific journal manager. 

It is awesome.

However, Open Journal System's 2.x look and feel is __very__ outdated. If you use the themes shipped with the platform, you'll get a rather old-fashioned website.

Scientific journals *can* and *should* be attractive.

This theme aims to give OJS a clean, minimalistic, responsive and modern-looking air by using modern standards lacking in the original themes:

- Custom fonts using @font-face.
- Responsive, mobile-first web design.
- Vertical rhythm-
- SASS and Grunt-based workflow

You can use this theme as it is, but you might find it rather dull. This is because it is intended to serve __both__ as a minimalistic theme AND a starter kit to be extended and customised.

### Why so hackish? (a note for developers)

By design, an OJS 2.x theme plugin *can only affect the styling (CSS) layer*. This means *we can't change HTML structure*. Of course we could, but I want to make this theme as straightforward as possible. For non tech-savvy users, it should be just plug and play.

This is a major drawback and means that most outdated techniques (like the use of `table` for layout or tags like `font`) and some painfully evident HTML errors can't be changed, only overriden via CSS.

This is why developers may be surprised by the abuse of !important declarations and CSS hacks (display:none and so on) to be found inside the CSS files. Please consider them not as bad practices but necessary hacks in order to completely "reset" OJS's default layout and set a consistent and flexible base to work upon.

The right thing should be to completely revamp OJS's markup. Again: this is not the scope of this project, as it aims to create a simple, plug-and-play theme plugin that just works out of the box.

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

### Dependencies

If you need to do your own build of the project, you'll need to have locally installed Compass and Breakpoint.

It is as easy as typing `gem install breakpoint` and `gem install compass` in your terminal.

In future versions, I will include a gemfile to indicate the correct versions. 



[ojs]: https://pkp.sfu.ca/ojs/