{**
 * templates/reviewer/active.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show reviewer's active submissions.
 *
 *}
<section id="submissions">
<table class="listing listing--wide">
	<thead>
		<th>{sort_heading key="common.id" sort='id'}</th>
		<th><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_heading key="common.assigned" sort='assignDate'} --></th>
		<th>{sort_heading key="submissions.sec" sort='section'}</th>
		<th>{sort_heading key="article.title" sort='title'}</th>
		<th>{sort_heading key="submission.due" sort='dueDate'}</th>
		<th>{sort_heading key="submissions.reviewRound" sort='round'}</th>
	</thead>
	<tbody>
{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="reviewId" value=$submission->getReviewId()}

	<tr >
		<td data-title='{translate key="common.id"}'>{$articleId|escape}</td>
		<td data-title='{translate key="submission.date.mmdd"}'>{$submission->getDateNotified()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.title"}'><a href="{url op="submission" path=$reviewId}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td data-title='{translate key="submission.due"}' class="nowrap">{$submission->getDateDue()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.reviewRound"}'>{$submission->getRound()}</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="3" align="left">{page_info iterator=$submissions}</td>
		<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</section>

