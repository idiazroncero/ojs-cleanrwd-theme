# IN DEVELOPMENT - NOT READY FOR PRODUCTION
## Open Journal System Clean, Responsive Theme
*v0.0.1*

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

TODO

### Customization and file structure

In order to tailor the theme to your needs, you will have to be familiar at least with CSS.

The beta version ships with little configuration options. Next versions will be ready to be easily customizable by using SCSS variables. Just access _init.scss, read the documentation, change the variables to meet your needs and compile your CSS using your weapon of choice.

Use the following files in SASS folder to modify the theme and re-compile clean-rwd.css.

### init

#### _fonts.scss

Modify the `@import` statement to use your preferred fonts from Google Fonts.
Remember you'll have to modify the font variables as well.

#### _normalize.scss

__This file is not intended to be modified.__

#### _init.scss

This is where almost all configuration takes place. 

Use the SCSS variables to customize your theme. Every variable is documented and explained.

If you need to @import any SCSS libraries such as Susy, Zen Grids, etc... do it here.

### pkp

This folder contains an overriden copy of OJS __original__ CSS files.

This files only contain the needed explicit overrides. For example, it overrides background colors for `#header`, sets our `font-size` and `line-height` to heading elements and changes the paddings and margins to use compass' vertical rhythm.

However, it does not *redesign* them. It only normalizes them according to our pre-defined set of rules (namely: a given vertical rhythm that has to be honored, a tipographic aspect ratio and some basic rules of thumb about lines, links and font-weights).

The aim is to make the re-styling of OJS a three-step process: normalisation of generic HTML, normalization and adaptation of OJS's HTML and re-design.

This folder __only__ takes care of the second step.

### modules

Following SMACSS naming convention, this is where theme re-design takes place in the form of 'modules'.

Each module has its own .scss file. Names are self-explanatory.


[ojs]: https://pkp.sfu.ca/ojs/