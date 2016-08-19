{**
 * templates/editor/submissionsInReview.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in review.
 *}
<div id="submissions">
<table width="100%" class="listing listing--wide">
	<thead>
		<th>{sort_search key="common.id" sort="id"}</th>
		<th class="nowrap"><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_search key="submissions.submitted" sort="submitDate"} --></th>
		<th>{sort_search key="submissions.sec" sort="section"}</th>
		<th>{sort_search key="article.authors" sort="authors"}</th>
		<th>{sort_search key="article.title" sort="title"}</th>
		<th>
			{translate key="submission.peerReview"}
			<table class="listing nested">
				<tr >
					<td>{translate key="submission.ask"}</td>
					<td>{translate key="submission.due"}</td>
					<td>{translate key="submission.done"}</td>
				</tr>
			</table>
		</td>
		<td width="5%">{translate key="submissions.ruling"}</td>
		<td width="5%">{translate key="article.sectionEditor"}</td>
	</thead>
	<tbody>
	{iterate from=submissions item=submission}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<tr {if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
		<td data-title='{translate key="common.id"}'>{$submission->getId()}</td>
		<td data-title='{translate key="submission.date.mmdd"}'>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="article.title"}'><a href="{url op="submissionReview" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></td>
		<td data-title='{translate key="submission.peerReview"}'>
			<table class="listing nested">
			{foreach from=$submission->getReviewAssignments() item=reviewAssignments}
				{foreach from=$reviewAssignments item=assignment name=assignmentList}
					{if not $assignment->getCancelled() and not $assignment->getDeclined()}
					<tr>
						<td data-title='{translate key="submission.ask"}'>{if $assignment->getDateNotified()}{$assignment->getDateNotified()|date_format:$dateFormatTrunc}{else} <i class="fa fa-times"></i> {/if}</td>
						<td data-title='{translate key="submission.due"}'>{if $assignment->getDateCompleted() || !$assignment->getDateConfirmed()} <i class="fa fa-times"></i> {else}{$assignment->getWeeksDue()|default:"&mdash;"}{/if}</td>
						<td data-title='{translate key="submission.done"}'>{if $assignment->getDateCompleted()}{$assignment->getDateCompleted()|date_format:$dateFormatTrunc}{else} <i class="fa fa-times"></i> {/if}</td>
					</tr>
					{/if}
				{foreachelse}
				<tr >
					<td data-title='{translate key="submission.ask"}'> <i class="fa fa-times"></i> </td>
					<td data-title='{translate key="submission.due"}'> <i class="fa fa-times"></i> </td>
					<td data-title='{translate key="submission.done"}'> <i class="fa fa-times"></i> </td>
				</tr>
				{/foreach}
			{foreachelse}
				<tr >
					<td data-title='{translate key="submission.ask"}'> <i class="fa fa-times"></i> </td>
					<td data-title='{translate key="submission.due"}'> <i class="fa fa-times"></i> </td>
					<td data-title='{translate key="submission.done"}'> <i class="fa fa-times"></i> </td>
				</tr>
			{/foreach}
			</table>
		</td>
		<td data-title='{translate key="submissions.ruling"}'>
			{foreach from=$submission->getDecisions() item=decisions}
				{foreach from=$decisions item=decision name=decisionList}
					{if $smarty.foreach.decisionList.last}
							{$decision.dateDecided|date_format:$dateFormatTrunc}				
					{/if}
				{foreachelse}
					&mdash;
				{/foreach}
			{foreachelse}
				&mdash;
			{/foreach}
		</td>
		<td data-title='{translate key="article.sectionEditor"}'>
			{assign var="editAssignments" value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorInitials()|escape} {/foreach}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="8" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="5">{page_info iterator=$submissions}</td>
		<td colspan="3">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

