{**
 * lib/pkp/templates/announcement/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcements.
 *
 *}
{strip}
{assign var="pageTitle" value="announcement.announcements"}
{assign var="pageId" value="announcement.announcements"}
{include file="common/header.tpl"}
{/strip}

<section id="announcement-list">

{if $announcementsIntroduction != null}
	{$announcementsIntroduction|nl2br}
{/if}
{iterate from=announcements item=announcement}
	<article class="announcement">
	{if $announcement->getTypeId()}
		<h4 class="announcement__title">{$announcement->getAnnouncementTypeName()|escape}: {$announcement->getLocalizedTitle()|escape}</h4>
	{else}
		<h4 class="announcement__title">{$announcement->getLocalizedTitle()|escape}</h4>
	{/if}

		<div class="announcement__description">{$announcement->getLocalizedDescriptionShort()|nl2br}</div>

		<div class="announcement__details">{translate key="announcement.posted"}: {$announcement->getDatePosted()}
		{if $announcement->getLocalizedDescription() != null}
			<span class="announcement__more">
				<a class="action" href="{url op="view" path=$announcement->getId()}">{translate key="announcement.viewLink"}</a></span>
		{/if}
		</div>
	</article>
{/iterate}
{if $announcements->wasEmpty()}
	<p>{translate key="announcement.noneExist"}</p>
{else}
	<div class="listing-pager">
		{page_info iterator=$announcements}
		{page_links anchor="announcements" name="announcements" iterator=$announcements}
	</div>
{/if}

</section>

{include file="common/footer.tpl"}
