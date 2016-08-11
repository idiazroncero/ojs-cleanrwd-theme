{**
 * templates/issue/archive.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue Archive.
 *
 *}
{strip}
{assign var="pageTitle" value="archive.archives"}
{include file="common/header.tpl"}
{/strip}

<div id="issues">
{iterate from=issues item=issue}
	{if $issue->getYear() != $lastYear}
		{if !$notFirstYear}
			{assign var=notFirstYear value=1}
		{else}
			</div>
		{/if}
		<div class="issues-year">
		<h3>{$issue->getYear()|escape}</h3>
		{assign var=lastYear value=$issue->getYear()}
	{/if}

	<div class="issues-item" id="issue-{$issue->getId()}">
	{if $issue->getFileName($locale)}
		{assign var="coverLocale" value="$locale"}
	{else}
		{assign var="coverLocale" value="$primaryLocale"}
	{/if}
	{if $issue->getFileName($coverLocale) && $issue->getShowCoverPage($coverLocale) && !$issue->getHideCoverPageArchives($coverLocale)}
		<div class="issues-item__img">
			<a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">
				<img src="{$coverPagePath|escape}{$issue->getFileName($coverLocale)|escape}"{if $issue->getCoverPageAltText($coverLocale) != ''} alt="{$issue->getCoverPageAltText($coverLocale)|escape}"{else} alt="{translate key="issue.coverPage.altText"}"{/if}/>
			</a>
		</div>
		<div class="issues-item__text">
		<h4>
			<a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a>
		</h4>
		<p class="issues-item__desc">
			{$issue->getLocalizedCoverPageDescription()|strip_unsafe_html|nl2br}
		</p>
		</div>
	{else}
		<h4>
			<a href="{url op="view" path=$issue->getBestIssueId($currentJournal)}">{$issue->getIssueIdentification()|escape}</a>
		</h4>
		<p class="issueDescription">{$issue->getLocalizedDescription()|strip_unsafe_html|nl2br}</p>
	{/if}
	</div>

{/iterate}
{if $notFirstYear}</div>{/if}

{if !$issues->wasEmpty()}
	<div class="listing-pager">
	{page_info iterator=$issues}
	{page_links anchor="issues" name="issues" iterator=$issues}

	</div>
{else}
	{translate key="current.noCurrentIssueDesc"}
{/if}
</div>
{include file="common/footer.tpl"}

