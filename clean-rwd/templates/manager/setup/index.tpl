{**
 * templates/manager/setup/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal setup index/intro.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.setup.journalSetup"}
{include file="common/header.tpl"}
{/strip}

<h3>{translate key="manager.setup.stepsToJournalSite"}</h3>

<ol class="journal-setup__steps">
	<li>
		<a href="{url op="setup" path="1"}">{translate key="manager.setup.details"}</a>
		<p class="instruct">{translate key="manager.setup.details.description"}</p>
	</li>
	<li>
		<a href="{url op="setup" path="2"}">{translate key="manager.setup.policies"}</a>
		<p class="instruct">{translate key="manager.setup.policies.description"}</p>
	</li>
	<li>
		<a href="{url op="setup" path="3"}">{translate key="manager.setup.submissions"}</a>
		<p class="instruct">{translate key="manager.setup.submissions.description"}</p>
	</li>
	<li>
		<a href="{url op="setup" path="4"}">{translate key="manager.setup.management"}</a>
		<p class="instruct">{translate key="manager.setup.management.description"}</p>
	</li>
	<li>
		<a href="{url op="setup" path="5"}">{translate key="manager.setup.look"}</a>
		<p class="instruct">{translate key="manager.setup.look.description"}</p>
	</li>
</ol>

{include file="common/footer.tpl"}

