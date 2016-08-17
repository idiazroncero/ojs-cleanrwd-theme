{**
 * lib/pkp/templates/announcement/list.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcements without site header or footer.
 *
 *}

{if !$announcements->wasEmpty()}
<div class="announcements">
{counter start=1 skip=1 assign="count"}
{iterate from=announcements item=announcement}
	<article class="announcement">
	{if !$numAnnouncementsHomepage || $count <= $numAnnouncementsHomepage}
		{if $announcement->getTypeId()}
			<h4 class="announcement__title">{$announcement->getAnnouncementTypeName()|escape}: {$announcement->getLocalizedTitle()|escape}</h4>
		{else}
			<h4 class="announcement__title">{$announcement->getLocalizedTitle()|escape}</h4>
		{/if}
		<div class="announcement__description">
			{$announcement->getLocalizedDescriptionShort()|nl2br}
			{if $announcement->getLocalizedDescription() != null}
			{/if}
		</div>
		<div class="announcement__details">
			{translate key="announcement.posted"}: {$announcement->getDatePosted()}
			<span class="announcement__more">
				<a class="action" href="{url page="announcement" op="view" path=$announcement->getId()}">{translate key="announcement.viewLink"}</a>
			</span>
		</div>
	{/if}
	{counter}
	</article>
{/iterate}

</div>

{/if}
