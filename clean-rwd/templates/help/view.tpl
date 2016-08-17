{**
 * templates/help/view.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display a help topic.
 *
 *}
{strip}
{translate|assign:applicationHelpTranslated key="help.ojsHelp"}

{**
 * view.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display a help topic.
 *
 *}
{strip}
{include file="help/header.tpl"}
{/strip}

	
	<h2>{$topic->getTitle()}</h2>

	
	<div id="helpTopic">{include file="help/topic.tpl"}</div>


{include file="help/footer.tpl"}




{/strip}
