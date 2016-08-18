{**
 * templates/author/submit/step2.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step2"}
{include file="author/submit/submitHeader.tpl"}

<form method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<div id="uploadInstructions">{translate key="author.submit.uploadInstructions"}</div>

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<p class="info-message">{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</p>

<section id="submissionFile">
<h3>{translate key="author.submit.submissionFile"}</h3>

{if $submissionFile}
<div class="form-row">
	<div class="form-subrow">
		<div class="form-group ">
			<p class="label">
			{translate key="common.fileName"}
			<a href="{url op="download" path=$articleId|to_array:$submissionFile->getFileId()}">{$submissionFile->getFileName()|escape}</a>
		</p>
		</div>
		<div class="form-group ">
			<p class="label">{translate key="common.originalFileName"}
			{$submissionFile->getOriginalFileName()|escape}</p></div>
		<div class="form-group ">
			<p class="label">{translate key="common.fileSize"}
			{$submissionFile->getNiceFileSize()}</p></div>
		<div class="form-group ">
			<p class="label">{translate key="common.dateUploaded"}
			{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}</div>
	</div>
</div>
{else}
<p>{translate key="author.submit.noSubmissionFile"}</p>
{/if}

<div id="addSubmissionFile">

<div class="form-row">
		<div class="form-group">
			{if $submissionFile}
				{fieldLabel name="submissionFile" key="author.submit.replaceSubmissionFile"}
			{else}
				{fieldLabel name="submissionFile" key="author.submit.uploadSubmissionFile"}
			{/if}
			<input type="file" class="uploadField" name="submissionFile" id="submissionFile" />
			<input name="uploadSubmissionFile" type="submit" class="button" value="{translate key="common.upload"}" />
		</div>
		{if $currentJournal->getSetting('showEnsuringLink')}
		<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
</div>


</div>
</section>



<div class="buttons">
	<input type="submit"{if !$submissionFile} onclick="return confirm('{translate|escape:"jsparam" key="author.submit.noSubmissionConfirm"}')"{/if} value="{translate key="common.saveAndContinue"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" />
</div>

</form>

{include file="common/footer.tpl"}

