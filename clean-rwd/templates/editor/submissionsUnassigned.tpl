{**
 * templates/editor/submissionsUnassigned.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show listing of unassigned submissions.
 *}
<div id="submissions">
<table class="listing listing--wide">
	<thead>
		<th>{sort_search key="common.id" sort="id"}</th>
		<th><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_search key="submissions.submit" sort="submitDate"} --></th>
		<th>{sort_search key="submissions.sec" sort="section"}</th>
		<th>{sort_search key="article.authors" sort="authors"}</th>
		<th>{sort_search key="article.title" sort="title"}</th>
	</thead>
	
	<tbody>
	{iterate from=submissions item=submission}
	<tr  {if $submission->getFastTracked()} class="fastTracked"{/if}>
		<td data-title='{translate key="common.id"}'>{$submission->getId()}</td>
		<td data-title='{translate key="submission.date.mmdd"}'>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="article.title"}'><a href="{url op="submission" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="5" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="4" align="left">{page_info iterator=$submissions}</td>
		<td>{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

