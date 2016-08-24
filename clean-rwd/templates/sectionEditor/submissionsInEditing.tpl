{**
 * templates/sectionEditor/submissionsInEditing.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show section editor's submissions in editing.
 *
 *}
<div id="submissions">
<table class="listing listing--wide">
	<thead>
		<th>{sort_search key="common.id" sort="id"}</th>
		<th class="nowrap"><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_heading key="submissions.submit" sort="submitDate"} --></th>
		<th>{sort_search key="submissions.sec" sort="section"}</th>
		<th>{sort_search key="article.authors" sort="authors"}</th>
		<th>{sort_search key="article.title" sort="title"}</th>
		<th>{sort_search key="submission.copyedit" sort="subCopyedit"}</th>
		<th>{sort_search key="submission.layout" sort="subLayout"}</th>
		<th>{sort_search key="submissions.proof" sort="subProof"}</th>
		<th>{translate key="article.sectionEditor"}</th>
	</thead>
	
	<tbody>
	{iterate from=submissions item=submission}
	{assign var="layoutSignoff" value=$submission->getSignoff('SIGNOFF_LAYOUT')}
	{assign var="layoutEditorProofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
	{assign var="copyeditorFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<tr {if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
		<td data-title='{translate key="common.id"}'>{$submission->getId()}</td>
		<td data-title='{translate key="submission.date.mmdd"}'>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="article.title"}'><a href="{url op="submissionEditing" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></td>
		<td data-title='{translate key="submission.copyedit"}'>{if $copyeditorFinalSignoff->getDateCompleted()}{$copyeditorFinalSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else} <i class="fa fa-times"></i> {/if}</td>
		<td data-title='{translate key="submission.layout"}'>{if $layoutSignoff->getDateCompleted()}{$layoutSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else} <i class="fa fa-times"></i> {/if}</td>
		<td data-title='{translate key="submissions.proof"}'>{if $layoutEditorProofSignoff->getDateCompleted()}{$layoutEditorProofSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else} <i class="fa fa-times"></i> {/if}</td>
		<td data-title='{translate key="article.sectionEditor"}'>
			{assign var="editAssignments" value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorInitials()|escape} {/foreach}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="9" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="5">{page_info iterator=$submissions}</td>
		<td colspan="4">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

