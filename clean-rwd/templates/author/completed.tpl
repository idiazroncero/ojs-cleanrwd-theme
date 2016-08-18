{**
 * templates/author/completed.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the details of completed submissions.
 *
 *}
<section class="section" id="submissions">
<table class="listing listing--wide" >
	<thead>
		<th>{sort_heading key="common.id" sort="id"}</th>
		<th class="nowrap"><span class="disabled">{translate key="submission.date.mmdd"}</span></th>
		<th>{sort_heading key="submissions.sec" sort="section"}</th>
		<th>{sort_heading key="article.authors" sort="authors"}</th>
		<th>{sort_heading key="article.title" sort="title"}</th>
		{if $statViews}<th>{sort_heading key="submission.views" sort="views"}</th>{/if}
		<th>{sort_heading key="common.status" sort="status"}</th>
	</thead>
	
	<tbody>
{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	<tr >
		<td data-title='{translate key="common.id"}'>{$articleId|escape}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.title"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="common.id"}'><a href="{url op="submission" path=$articleId}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		{assign var="status" value=$submission->getSubmissionStatus()}
		{if $statViews}
			<td data-title='{translate key="submission.views"}'>
				{if $status==STATUS_PUBLISHED}
					{assign var=viewCount value=0}
					{foreach from=$submission->getGalleys() item=galley}
						{assign var=thisCount value=$galley->getViews()}
						{assign var=viewCount value=$viewCount+$thisCount}
					{/foreach}
					{$viewCount|escape}
				{else}
					&mdash;
				{/if}
			</td>
		{/if}
		<td data-title='{translate key="common.status"}'>
			{if $status==STATUS_ARCHIVED}{translate key="submissions.archived"}
			{elseif $status==STATUS_PUBLISHED}{print_issue_id articleId="$articleId"}
			{elseif $status==STATUS_DECLINED}{translate key="submissions.declined"}
			{/if}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="{if $statViews}7{else}6{/if}" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="{if $statViews}5{else}4{/if}">{page_info iterator=$submissions}</td>
		<td colspan="2">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</section>

