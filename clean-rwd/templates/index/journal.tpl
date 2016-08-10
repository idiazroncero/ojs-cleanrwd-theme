{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}

{if $homepageImage}

<div id="homepage-image">
	<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}


{if $journalDescription}
	<div id="journal-description">{$journalDescription}</div>
{/if}

{call_hook name="Templates::Index::journal"}


{if $additionalHomeContent}

<div id="additionalHomeContent">{$additionalHomeContent}</div>
{/if}

{if $enableAnnouncementsHomepage}
	{* Display announcements *}
	<section id="announcements-home" class="section">
		<h3>{translate key="announcement.announcementsHome"}</h3>
		{include file="announcement/list.tpl"}
		<div class="announcements__more">
			<a class="button button--small"href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a>
		</div>
	</section>
{/if}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	{* Display the table of contents or cover page of the current issue. *}
	<section class="section current-issue">
		<h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>
		{include file="issue/view.tpl"}
	</section>

{/if}

{include file="common/footer.tpl"}

