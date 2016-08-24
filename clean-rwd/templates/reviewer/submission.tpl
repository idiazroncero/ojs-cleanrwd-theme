{**
 * templates/reviewer/submission.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the reviewer administration page.
 *
 * FIXME: At "Notify The Editor", fix the date.
 *
 *}
{strip}
{assign var="articleId" value=$submission->getId()}
{assign var="reviewId" value=$reviewAssignment->getId()}
{translate|assign:"pageTitleTranslated" key="submission.page.review" id=$articleId}
{assign var="pageCrumbTitle" value="submission.review"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function confirmSubmissionCheck() {
	if (document.getElementById('recommendation').recommendation.value=='') {
		alert('{/literal}{translate|escape:"javascript" key="reviewer.article.mustSelectDecision"}{literal}');
		return false;
	}
	return confirm('{/literal}{translate|escape:"javascript" key="reviewer.article.confirmDecision"}{literal}');
}
// -->
{/literal}
</script>
<div id="submissionToBeReviewed">
<h3>{translate key="reviewer.article.submissionToBeReviewed"}</h3>
<dl>

	<dt>{translate key="article.title"}</dt>
	<dd>{$submission->getLocalizedTitle()|strip_unsafe_html}</dd>

	<dt>{translate key="article.journalSection"}</dt>
	<dd>{$submission->getSectionTitle()|escape}</dd>

	<dt>{translate key="article.abstract"}</dt>
	<dd>{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br}</dd>

{assign var=editAssignments value=$submission->getEditAssignments()}
{foreach from=$editAssignments item=editAssignment}
	{if !$notFirstEditAssignment}
		{assign var=notFirstEditAssignment value=1}
			<dt>{translate key="reviewer.article.submissionEditor"}</dt>
			<dd>
	{/if}
			{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
			{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$articleId}
			{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
			{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
				{if $editAssignment->getCanEdit()}
					({translate key="submission.editing"})
				{else}
					({translate key="submission.review"})
				{/if}
			{/if}
			
{/foreach}
{if $notFirstEditAssignment}
		</dd>

{/if}
	       <dt>{translate key="submission.metadata"}</dt>
	       <dd>
		       <i class="fa fa-link"></i> <a href="{url op="viewMetadata" path=$reviewId|to_array:$articleId}" target="_new">{translate key="submission.viewMetadata"}</a>
	       </dd>
</dl>

</div>

<div id="reviewSchedule">
<h3>{translate key="reviewer.article.reviewSchedule"}</h3>
<dl>
	<dt>{translate key="reviewer.article.schedule.request"}</dt>
	<dd>{if $submission->getDateNotified()}{$submission->getDateNotified()|date_format:$dateFormatShort}{else}&mdash;{/if}</dd>

	<dt>{translate key="reviewer.article.schedule.response"}</dt>
	<dd>{if $submission->getDateConfirmed()}{$submission->getDateConfirmed()|date_format:$dateFormatShort}{else}&mdash;{/if}</dd>
	
	<dt>{translate key="reviewer.article.schedule.submitted"}</dt>
	<dd>{if $submission->getDateCompleted()}{$submission->getDateCompleted()|date_format:$dateFormatShort}{else}&mdash;{/if}</dd>


	<dt>{translate key="reviewer.article.schedule.due"}</dt>
	<dd>{if $submission->getDateDue()}{$submission->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</dd>

</dl>
</div>


<div id="reviewSteps">
<h3>{translate key="reviewer.article.reviewSteps"}</h3>

{include file="common/formErrors.tpl"}

{assign var="currentStep" value=1}

<ol>
	<li>
		{assign var=editAssignments value=$submission->getEditAssignments}
		{* FIXME: Should be able to assign primary editorial contact *}
		{if $editAssignments[0]}{assign var=firstEditAssignment value=$editAssignments[0]}{/if}
		<p>{translate key="reviewer.article.notifyEditorA"}{if $firstEditAssignment}, {$firstEditAssignment->getEditorFullName()|escape},{/if} {translate key="reviewer.article.notifyEditorB"}</p>

		<div class="form-row">
			<p class="label">{translate key="submission.response"}</p>
			<div class="form-subrow">{if not $confirmedStatus}
					{url|assign:"acceptUrl" op="confirmReview" reviewId=$reviewId}
					{url|assign:"declineUrl" op="confirmReview" reviewId=$reviewId declineReview=1}
				
					{if !$submission->getCancelled()}
						<div class="form-group"><a href="{$acceptUrl}">{translate key="reviewer.article.canDoReview"}</a> {icon name="mail" url=$acceptUrl}</div>
						
						<div class="form-group"><a href="{$declineUrl}">{translate key="reviewer.article.cannotDoReview"}</a> {icon name="mail" url=$declineUrl}</div>
					{else}
						{translate key="reviewer.article.canDoReview"} {icon name="mail" disabled="disabled" url=$acceptUrl}
						&nbsp;&nbsp;&nbsp;&nbsp;
						{translate key="reviewer.article.cannotDoReview"} {icon name="mail" disabled="disabled" url=$declineUrl}
					{/if}
				{else}
					{if not $declined}{translate key="submission.accepted"}{else}{translate key="submission.rejected"}{/if}
				{/if}</div>
		</div>
	{if $journal->getLocalizedSetting('reviewGuidelines') != ''}
	<li>
		<p>{translate key="reviewer.article.consultGuidelines"}</p>
	</li>
	{/if}

	<li>
		<p>{translate key="reviewer.article.downloadSubmission"}</p>
			{if ($confirmedStatus and not $declined) or not $journal->getSetting('restrictReviewerFileAccess')}
			<div class="form-row">
				<div class="form-subrow">
					<div class="form-group">
						<p class="label label--inline">{translate key="submission.submissionManuscript"}</p>
						{if $reviewFile}
								{if $submission->getDateConfirmed() or not $journal->getSetting('restrictReviewerAccessToFile')}
									<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>
								{else}{$reviewFile->getFileName()|escape}{/if}
								&nbsp;&nbsp;{$reviewFile->getDateModified()|date_format:$dateFormatShort}
								{else}
								{translate key="common.none"}
						{/if}
					</div>
				
					<div class="form-group">
						<p class="label label--inline">
							{translate key="article.suppFiles"}
						</p>
						{assign var=sawSuppFile value=0}
						{foreach from=$suppFiles item=suppFile}
							{if $suppFile->getShowReviewers() }
								{assign var=sawSuppFile value=1}
								<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a>
							{/if}
						{/foreach}
				
						{if !$sawSuppFile}
							{translate key="common.none"}
						{/if}
					</div>
				</div>
			</div>

			{else}
			<p class="nodata">{translate key="reviewer.article.restrictedFileAccess"}</p>
			{/if}
	</li>

	{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
		<li>
				{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
				<p>{translate key="reviewer.article.enterCompetingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</p>
				{if not $confirmedStatus or $declined or $submission->getCancelled() or $submission->getRecommendation()}
					{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br}
				{else}
					<form action="{url op="saveCompetingInterests" reviewId=$reviewId}" method="post">
						<textarea {if $cannotChangeCI}disabled="disabled" {/if}name="competingInterests" class="textArea" id="competingInterests" rows="5" cols="40">{$reviewAssignment->getCompetingInterests()|escape}</textarea>
						<input {if $cannotChangeCI}disabled="disabled" {/if}class="button defaultButton" type="submit" value="{translate key="common.save"}" />
					</form>
				{/if}
			</li>
	{/if}{* $currentJournal->getSetting('requireReviewerCompetingInterests') *}


	{if $reviewAssignment->getReviewFormId()}
		<li>
			<p>{translate key="reviewer.article.enterReviewForm"}</p>
				<div class="form-row">{if $confirmedStatus and not $declined}
						<a href="{url op="editReviewFormResponse" path=$reviewId|to_array:$reviewAssignment->getReviewFormId()}" class="icon">
							{translate key="submission.reviewForm"}
							{icon name="comment"}
						</a>
					{else}
						{translate key="submission.reviewForm"}
						{icon name="comment" disabled="disabled"}
					{/if}</div>
		</li>
	{else}{* $reviewAssignment->getReviewFormId() *}
		<li>
			<p>{translate key="reviewer.article.enterReviewA"}</p>
				<div class="form-row">{if $confirmedStatus and not $declined}
						<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$articleId|to_array:$reviewId}');" class="icon">
							{translate key="submission.logType.review"}
							{icon name="comment"}
						</a>
					{else}
						{translate key="submission.logType.review"}
						{icon name="comment" disabled="disabled"}
					{/if}</div>
		</li>
	{/if}{* $reviewAssignment->getReviewFormId() *}

	<li>
		<p>{translate key="reviewer.article.uploadFile"}</p>
		<div class="form-row">
			<div class="form-subrow">
				{foreach from=$submission->getReviewerFileRevisions() item=reviewerFile key=key}
				<div class="form-group">
					{assign var=uploadedFileExists value="1"}
						{if $key eq "0"}
							<p class="label label--heading">{translate key="reviewer.article.uploadedFile"}</p>
						{/if}

						<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>
						{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
						{if ($submission->getRecommendation() === null || $submission->getRecommendation() === '') && (!$submission->getCancelled())}
						<a class="action" href="{url op="deleteReviewerVersion" path=$reviewId|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}">{translate key="common.delete"}</a>
						{/if}
				</div>
				{foreachelse}
				<div class="form-group">
						{translate key="reviewer.article.uploadedFile"}

						{translate key="common.none"}
				</div>
				{/foreach}
			</div>
			<div class="form-group">
				{if $submission->getRecommendation() === null || $submission->getRecommendation() === ''}
					<form method="post" action="{url op="uploadReviewerVersion"}" enctype="multipart/form-data">
						<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
						<input type="file" name="upload" {if not $confirmedStatus or $declined or $submission->getCancelled()}disabled="disabled"{/if} class="uploadField" />
						<input type="submit" name="submit" value="{translate key="common.upload"}" {if not $confirmedStatus or $declined or $submission->getCancelled()}disabled="disabled"{/if} class="button" />
					</form>

					{if $currentJournal->getSetting('showEnsuringLink')}
					<p class="instruct">
						<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>
					</p>
					{/if}
				{/if}
			</div>
		</div>
	</li>

	<li>
		<p>{translate key="reviewer.article.selectRecommendation"}</p>
		<div class="form-row">
			<p class="label">{translate key="submission.recommendation"}</p>

				{if $submission->getRecommendation() !== null && $submission->getRecommendation() !== ''}
					{assign var="recommendation" value=$submission->getRecommendation()}
					<strong>{translate key=$reviewerRecommendationOptions.$recommendation}</strong>&nbsp;&nbsp;
					{$submission->getDateCompleted()|date_format:$dateFormatShort}
				{else}
					<form id="recommendation" method="post" action="{url op="recordRecommendation"}">
					<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
					<select name="recommendation" {if not $confirmedStatus or $declined or $submission->getCancelled() or (!$reviewFormResponseExists and !$reviewAssignment->getMostRecentPeerReviewComment() and !$uploadedFileExists)}disabled="disabled"{/if} class="selectMenu">
						{html_options_translate options=$reviewerRecommendationOptions selected=''}
					</select>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" name="submit" onclick="return confirmSubmissionCheck()" class="button" value="{translate key="reviewer.article.submitReview"}" {if not $confirmedStatus or $declined or $submission->getCancelled() or (!$reviewFormResponseExists and !$reviewAssignment->getMostRecentPeerReviewComment() and !$uploadedFileExists)}disabled="disabled"{/if} />
					</form>
				{/if}
	</li>
</ol>

</div>

{if $journal->getLocalizedSetting('reviewGuidelines') != ''}

<div id="reviewerGuidelines">
<h3>{translate key="reviewer.article.reviewerGuidelines"}</h3>
<p>{$journal->getLocalizedSetting('reviewGuidelines')|nl2br}</p>
</div>
{/if}

{include file="common/footer.tpl"}


