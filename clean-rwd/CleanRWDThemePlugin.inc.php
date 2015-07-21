<?php

/**
 * @file plugins/themes/CleanRWD/CleanRWDThemePlugin.inc.php
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class CleanRWDThemePlugin
 * @ingroup plugins_themes_CleanRWD
 *
 * @brief "CleanRWD" theme plugin
 */

import('classes.plugins.ThemePlugin');

class CleanRWDThemePlugin extends ThemePlugin {
	/**
	 * Get the name of this plugin. The name must be unique within
	 * its category.
	 * @return String name of plugin
	 */
	function getName() {
		return 'CleanRWDThemePlugin';
	}

	function getDisplayName() {
		return 'CleanRWD Theme';
	}

	function getDescription() {
		return 'Clean, responsive, modern-looking';
	}

	function getStylesheetFilename() {
		return 'clean-rwd.css';
	}

	function getLocaleFilename($locale) {
		return null; // No locale data
	}
}

?>
