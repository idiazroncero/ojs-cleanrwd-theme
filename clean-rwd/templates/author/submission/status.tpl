{**
 * templates/author/submission/status.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission status table.
 *
 *}
<section class="section" id="status">
<h3>{translate key="common.status"}</h3>

	<dl>
		<dt>{assign var="status" value=$submission->getSubmissionStatus()}
		{translate key="common.status"}</dt>
		<dd>
			{if $status == STATUS_ARCHIVED}{translate key="submissions.archived"}
			{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
			{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
			{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
			{elseif $status==STATUS_PUBLISHED}{translate key="submissions.published"}&nbsp;&nbsp;&nbsp;&nbsp;{$issue->getIssueIdentification()|escape}
			{elseif $status==STATUS_DECLINED}{translate key="submissions.declined"}
			{/if}
		</dd>
		<dt>{translate key="submission.initiated"}</dt>
		<dd>{$submission->getDateStatusModified()|date_format:$dateFormatShort}</dd>
		<dt>{translate key="submission.lastModified"}</dt>
		<dd>{$submission->getLastModified()|date_format:$dateFormatShort}</dd>

</section>

