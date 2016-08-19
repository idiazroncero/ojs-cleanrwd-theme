{**
 * templates/reviewer/completed.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show reviewer's submission archive.
 *
 *}
<section id="submissions">
<table class="listing listing--wide">
	<thead>
		<th>{sort_heading key="common.id" sort="id"}</th>
		<th><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_heading key="common.assigned" sort="assignDate"} --></th>
		<th>{sort_heading key="submissions.sec" sort="section"}</th>
		<th>{sort_heading key="article.title" sort="title"}</th>
		<th>{sort_heading key="submission.review" sort="review"}</th>
		<th>{sort_heading key="submission.editorDecision" sort="decision"}</th>
	</thead>
	<tbody>
{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="reviewId" value=$submission->getReviewId()}

	<tr >
		<td data-title='{translate key="common.id"}'>{$articleId|escape}</td>
		<td data-title='{translate key="submission.date.mmdd"}'>{$submission->getDateNotified()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.title"}'>{if !$submission->getDeclined()}<a href="{url op="submission" path=$reviewId}">{/if}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{if !$submission->getDeclined()}</a>{/if}</td>
		<td data-title='{translate key="submission.review"}'>
			{if $submission->getDeclined()}
				{translate key="sectionEditor.regrets"}
			{else}
				{assign var=recommendation value=$submission->getRecommendation()}
				{if $recommendation === '' || $recommendation === null}
					&mdash;
				{else}
					{translate key=$reviewerRecommendationOptions.$recommendation}
				{/if}
			{/if}
		</td>
		<td data-title='{translate key="submission.editorDecision"}'>
			{if $submission->getCancelled() || $submission->getDeclined()}
				&mdash;
			{else}
			{* Display the most recent editor decision *}
			{assign var=round value=$submission->getRound()}
			{assign var=decisions value=$submission->getDecisions($round)}
			{foreach from=$decisions item=decision name=lastDecisionFinder}
				{if $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_ACCEPT}
					{translate key="editor.article.decision.accept"}
				{elseif $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_PENDING_REVISIONS}
					{translate key="editor.article.decision.pendingRevisions"}
				{elseif $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
					{translate key="editor.article.decision.resubmit"}
				{elseif $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_DECLINE}
					{translate key="editor.article.decision.decline"}
				{/if}
			{foreachelse}
				&mdash;
			{/foreach}
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
		<td colspan="3">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</section>

