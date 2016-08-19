{**
 * templates/editor/submissionsArchives.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show listing of submission archives.
 *
 *}
<div id="submissions">
<table class="listing listing--wide">
	<thead>
		<th>{sort_search key="common.id" sort="id"}</th>
		<th><span class="disabled"></span>{sort_search key="submissions.submitted" sort="submitDate"}</th>
		<th>{sort_search key="submissions.sec" sort="section"}</th>
		<th>{sort_search key="article.authors" sort="authors"}</th>
		<th>{sort_search key="article.title" sort="title"}</th>
		<th>{sort_search key="common.status" sort="status"}</th>
	</thead>
	
	{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}

	<tr {if $submission->getFastTracked()} class="fastTracked"{/if}>
		<td data-title='{translate key="common.id"}'>{$articleId|escape}</td>
		<td data-title='{translate key="submissions.submitted"}'>{$submission->getDateSubmitted()|date_format:$dateFormatShort}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="article.title"}'><a href="{url op="submissionEditing" path=$articleId}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td data-title='{translate key="common.status"}'>
			{assign var="status" value=$submission->getStatus()}
			{if $status == STATUS_ARCHIVED}
				{translate key="submissions.archived"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
			{elseif $status == STATUS_PUBLISHED}
				{print_issue_id articleId="$articleId"}	
			{elseif $status == STATUS_DECLINED}
				{translate key="submissions.declined"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
			{/if}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="4">{page_info iterator=$submissions}</td>
		<td colspan="2">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>

