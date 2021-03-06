<?php

/**
 * @file plugins/themes/CleanRWD/CleanRWDThemePlugin.inc.php
 *
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

	function activate(&$templateMgr) {
		$templateMgr->template_dir[0] = Core::getBaseDir() 
										. DIRECTORY_SEPARATOR 
										. 'plugins' 
										. DIRECTORY_SEPARATOR 
										. 'themes' 
										. DIRECTORY_SEPARATOR 
										. 'clean-rwd' 
										. DIRECTORY_SEPARATOR 
										. 'templates';   
											      
		$templateMgr->compile_id = 'mpgTheme';
	}
}

?>
