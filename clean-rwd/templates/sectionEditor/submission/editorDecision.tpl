{**
 * templates/sectionEditor/submission/editorDecision.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the editor decision table.
 *
 *}
<section id="editorDecision">
<h3>{translate key="submission.editorDecision"}</h3>

<div class="form-row">
	<p class="label">{translate key="editor.article.selectDecision"}</p>
	<form method="post" action="{url op="recordDecision"}">
		<input type="hidden" name="articleId" value="{$submission->getId()}" />
		<select name="decision" size="1" class="selectMenu"{if not $allowRecommendation} disabled="disabled"{/if}>
			{html_options_translate options=$editorDecisionOptions selected=$lastDecision}
		</select>
		<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.recordDecision"}" {if not $allowRecommendation}disabled="disabled"{/if} class="button" />
		{if not $allowRecommendation}&nbsp;&nbsp;{translate key="editor.article.cannotRecord"}{/if}
	</form>
</div>

<div class="form-row">
	<p class="label">{translate key="editor.article.decision"}</p>
	<ul>
		{foreach from=$submission->getDecisions($round) item=editorDecision key=decisionKey}
				{if $decisionKey neq 0} | {/if}
				{assign var="decision" value=$editorDecision.decision}
				<li>{translate key=$editorDecisionOptions.$decision}
				{if $editorDecision.dateDecided != 0}{$editorDecision.dateDecided|date_format:$dateFormatShort}{/if}</li>
			{foreachelse}
				<li>{translate key="common.none"}</li>
			{/foreach}
	</ul>
</div>


<div class="form-row">
	<p class="label">{translate key="submission.notifyAuthor"}</p>
	{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}

	{if $decision == SUBMISSION_EDITOR_DECISION_DECLINE}
		{* The last decision was a decline; notify the user that sending this message will archive the submission. *}
		{translate|escape:"quotes"|assign:"confirmString" key="editor.submissionReview.emailWillArchive"}
		{icon name="mail" url=$notifyAuthorUrl onclick="return confirm('$confirmString')"}
	{else}
		{icon name="mail" url=$notifyAuthorUrl}
	{/if}

	{translate key="submission.editorAuthorRecord"}
	{if $submission->getMostRecentEditorDecisionComment()}
		{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
		<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatShort}
	{else}
		<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
	{/if}
</div>

<div class="form-row">
	

<form method="post" action="{url op="editorReview"}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$submission->getId()}" />
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}

{assign var="authorRevisionExists" value=false}
{foreach from=$authorFiles item=authorFile}
	{assign var="authorRevisionExists" value=true}
{/foreach}

{assign var="editorRevisionExists" value=false}
{foreach from=$editorFiles item=editorFile}
	{assign var="editorRevisionExists" value=true}
{/foreach}
{if $reviewFile}
	{assign var="reviewVersionExists" value=1}
{/if}


	{if $reviewFile}
		<div class="form-row">
			<div class="label">{translate key="submission.reviewVersion"}</div>
			<div class="form-group">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
					<input type="radio" name="editorDecisionFile" value="{$reviewFile->getFileId()},{$reviewFile->getRevision()}" />
				{/if}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$reviewFile->getDateModified()|date_format:$dateFormatShort}
				{if $copyeditFile && $copyeditFile->getSourceFileId() == $reviewFile->getFileId()}
					&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
				{/if}
			</div>
		</div>

	{/if}

	{assign var="firstItem" value=true}
	{foreach from=$authorFiles item=authorFile key=key}
		<div class="form-row">
			{if $firstItem}
				{assign var="firstItem" value=false}
				<p class="label">{translate key="submission.authorVersion"}</p> 
			{/if}
			<div class="form-group">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}<input type="radio" name="editorDecisionFile" value="{$authorFile->getFileId()},{$authorFile->getRevision()}" /> {/if}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$authorFile->getDateModified()|date_format:$dateFormatShort}
				{if $copyeditFile && ($copyeditFile->getSourceFileId() == $authorFile->getFileId() && $copyeditFile->getSourceRevision() == $authorFile->getRevision())}
					&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
				{/if}
			</div>
		</div>
	{foreachelse}
		<div class="form-row">
			<p class="label">{translate key="submission.authorVersion"}</p>
			<div class="form-group">{translate key="common.none"}</div>
		</div>
	{/foreach}
	{assign var="firstItem" value=true}
	{foreach from=$editorFiles item=editorFile key=key}
		<div class="form-row">
			{if $firstItem}
				{assign var="firstItem" value=false}
				<p class="label">{translate key="submission.editorVersion"}</p>
			{/if}
			<div class="form-group">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}<input type="radio" name="editorDecisionFile" value="{$editorFile->getFileId()},{$editorFile->getRevision()}" /> {/if}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$editorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				{if $copyeditFile && ($copyeditFile->getSourceFileId() == $editorFile->getFileId() && $copyeditFile->getSourceRevision() == $editorFile->getRevision())}
					{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				{/if}
				<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="action">{translate key="common.delete"}</a>
			</div>
		</div>
	{foreachelse}
		<div class="form-row">
			<p class="label">{translate key="submission.editorVersion"}</p>
			<div class="form-group">{translate key="common.none"}</div>
		</div>
	{/foreach}
	<div class="form-row">
		<div class="form-group">
			<input type="file" name="upload" class="uploadField" />
			<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
		</div>
	</div>

<div class="buttons">

{if $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
	{translate key="editor.article.resubmitFileForPeerReview"}
	<input type="submit" name="resubmit" {if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists)}disabled="disabled" {/if}value="{translate key="form.resubmit"}" class="button" />
{elseif $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT}
	{if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists) or !$submission->getMostRecentEditorDecisionComment()}{assign var=copyeditingUnavailable value=1}{else}{assign var=copyeditingUnavailable value=0}{/if}
	<input type="submit" {if $copyeditingUnavailable}disabled="disabled" {/if}name="setCopyeditFile" value="{translate key="editor.submissionReview.sendToCopyediting"}" class="button" />
	{if $copyeditingUnavailable}
		<p class="instruct">{translate key="editor.submissionReview.cannotSendToCopyediting"}</p>
			{/if}
{/if}

</div>

</form>

</div>

</section>

