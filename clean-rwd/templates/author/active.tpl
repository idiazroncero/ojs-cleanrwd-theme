{**
 * templates/author/active.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the details of active submissions.
 *
 *}
<section class="section" id="submissions">
<table class="listing listing--wide" width="100%">
	<thead>
		<th >{sort_heading key="common.id" sort="id" sortOrder="ASC"}</th>
		<th ><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_heading key="submissions.submit" sort="submitDate"} --></th>
		<th >{sort_heading key="submissions.sec" sort="section"}</th>
		<th >{sort_heading key="article.authors" sort="authors"}</th>
		<th >{sort_heading key="article.title" sort="title"}</th>
		<th >{sort_heading key="common.status" sort="status"}</th>
	</thead>

{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="progress" value=$submission->getSubmissionProgress()}

	<tr >
		<td data-title='{translate key="common.id"}'>{$articleId|escape}</td>
		<td data-title='{translate key="submission.date.mmdd"}'>{if $submission->getDateSubmitted()}{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		{if $progress == 0}
			<td data-title='{translate key="article.title"}'><a href="{url op="submission" path=$articleId}" class="action">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td data-title='{translate key="common.status"}'>
				{assign var="status" value=$submission->getSubmissionStatus()}
				{if $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
				{elseif $status==STATUS_QUEUED_REVIEW}
					<a href="{url op="submissionReview" path=$articleId}" class="action">
						{assign var=decision value=$submission->getMostRecentDecision()}
						{if $decision == $smarty.const.SUBMISSION_EDITOR_DECISION_PENDING_REVISIONS}{translate key="author.submissions.queuedReviewRevisions"}
						{elseif $submission->getCurrentRound() > 1}{translate key="author.submissions.queuedReviewSubsequent" round=$submission->getCurrentRound()}
						{else}{translate key="submissions.queuedReview"}
						{/if}
					</a>
				{elseif $status==STATUS_QUEUED_EDITING}
					{assign var="proofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')}
					<a href="{url op="submissionEditing" path=$articleId}" class="action">
						{if $proofSignoff->getDateNotified() && !$proofSignoff->getDateCompleted()}{translate key="author.submissions.queuedEditingCopyedit"}
						{elseif $proofSignoff->getDateNotified() && !$proofSignoff->getDateCompleted()}{translate key="author.submissions.queuedEditingProofread"}
						{else}{translate key="submissions.queuedEditing"}
						{/if}
					</a>
				{/if}

				{** Payment related actions *}
				{if $status==STATUS_QUEUED_UNASSIGNED || $status==STATUS_QUEUED_REVIEW}
					{if $submissionEnabled && !$completedPaymentDAO->hasPaidSubmission($submission->getJournalId(), $submission->getId())}
						
						<a href="{url op="paySubmissionFee" path="$articleId"}" class="action">{translate key="payment.submission.paySubmission"}</a>					
					{elseif $fastTrackEnabled}
						
						{if $submission->getFastTracked()}
							{translate key="payment.fastTrack.inFastTrack"}
						{else}
							<a href="{url op="payFastTrackFee" path="$articleId"}" class="action">{translate key="payment.fastTrack.payFastTrack"}</a>
						{/if}
					{/if}
				{elseif $status==STATUS_QUEUED_EDITING}
					{if $publicationEnabled}
						
						{if $completedPaymentDAO->hasPaidPublication($submission->getJournalId(), $submission->getId())}
							{translate key="payment.publication.publicationPaid}
						{else}
							<a href="{url op="payPublicationFee" path="$articleId"}" class="action">{translate key="payment.publication.payPublication"}</a>
						{/if}
				{/if}		
		{/if}
			</td>
		{else}
			<td data-title='{translate key="article.title"}'><a href="{url op="submit" path=$progress articleId=$articleId}" class="action">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td data-title='{translate key="common.status"}'>{translate key="submissions.incomplete"}<a href="{url op="deleteSubmission" path=$articleId}" class="action" onclick="return confirm('{translate|escape:"jsparam" key="author.submissions.confirmDelete"}')">{translate key="common.delete"}</a></td>
		{/if}

	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		{page_info iterator=$submissions}
		{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}
	</tr>
{/if}
</table>
</section>

