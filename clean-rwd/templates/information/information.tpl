{**
 * templates/information/information.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal information page.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}
<div id="journalInfo">
<p>{$content|nl2br}</p>
</div>
{include file="common/footer.tpl"}

