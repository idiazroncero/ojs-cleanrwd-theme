# IN DEVELOPMENT - NOT READY FOR PRODUCTION
## Open Journal System Clean, Responsive Theme

[Open Journal System][ojs] is the leading scientific journal manager. 

It is awesome.

However, Open Journal System's 2.x look and feel is __very__ outdated. If you use the themes shipped with the platform, you'll get a very old-fashioned website.

Scientific journals *can* and *should* be attractive.

This theme aims to give OJS a clean, minimalistic, responsive and modern-looking air by using nowadays' standards lacking in the original themes:

- Use of @font-face.
- Responsive, mobile-first web design.
- Vertycal rhythm

You can use this theme as it is or customize it.

In order to tailor the theme to your needs, you will have to be familiar at least with CSS.

However, this theme will be specifically prepared to easily customizable by using SCSS variables. Just access _init.scss, read the documentation, change the variables to meet your needs and compile your CSS using your weapon of choice.

## Limitations

Sadly, an OJS 2.x theme plugin *only affects CSS*. This means that some outdated techniques - like the excessive use of `table`s - can't be changed, only "outstyled" via CSS.

[ojs]: https://pkp.sfu.ca/ojs/

## Install

TODO

## Customization and file structure

Use the files in SASS folder to modify the theme and re-compile clean-rwd.css.

### init

#### _fonts.scss

Modify the `@import` statement to use your preferred fonts from Google Fonts.
Remember you'll have to modify the font variables as well.

#### _normalize.scss

This file is not intended to be modified.

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



