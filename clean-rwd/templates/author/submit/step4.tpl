{**
 * templates/author/submit/step4.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 4 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step4"}
{include file="author/submit/submitHeader.tpl"}

<script type="text/javascript">
{literal}
<!--
function confirmForgottenUpload() {
	var fieldValue = document.getElementById('submitForm').uploadSuppFile.value;
	if (fieldValue) {
		return confirm("{/literal}{translate key="author.submit.forgottenSubmitSuppFile"}{literal}");
	}
	return true;
}
// -->
{/literal}
</script>

<form id="submitForm" method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<p>{translate key="author.submit.supplementaryFilesInstructions"}</p>

<table class="listing">
	<thead>
		<th>{translate key="common.id"}</th>
		<th>{translate key="common.title"}</th>
		<th>{translate key="common.originalFileName"}</th>
		<th class="nowrap">{translate key="common.dateUploaded"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	{foreach from=$suppFiles item=file}
	<tr >
		<td data-title='{translate key="common.id"}' >{$file->getSuppFileId()}</td>
		<td data-title='{translate key="common.title"}' >{$file->getSuppFileTitle()|escape}</td>
		<td data-title='{translate key="common.originalFileName"}' >{$file->getOriginalFileName()|escape}</td>
		<td data-title='{translate key="common.dateUploaded"}' >{$file->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="common.action"}' ><a href="{url op="submitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSubmitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
	{foreachelse}
	<tr >
		<td colspan="6" class="nodata">{translate key="author.submit.noSupplementaryFiles"}</td>
	</tr>
	{/foreach}
</table>


<div class="form-row">
	
	<div class="form-group">
		{fieldLabel name="uploadSuppFile" key="author.submit.uploadSuppFile"}
		<input type="file" name="uploadSuppFile" id="uploadSuppFile"  class="uploadField" />
		<input name="submitUploadSuppFile" type="submit" class="button" value="{translate key="common.upload"}" />
	</div>
	<div class="form-group">
		{if $currentJournal->getSetting('showEnsuringLink')}<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}</div>

</div>


<div class="buttons">
	<input type="submit" onclick="return confirmForgottenUpload()" value="{translate key="common.saveAndContinue"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" />
</div>

</form>

{include file="common/footer.tpl"}

