{**
 * templates/author/submit/step5.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 5 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step5"}
{include file="author/submit/submitHeader.tpl"}

<p>{translate key="author.submit.confirmationDescription" journalTitle=$journal->getLocalizedTitle()}</p>

<form method="post" action="{url op="saveSubmit" path=$submitStep}">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<h3>{translate key="author.submit.filesSummary"}</h3>
<table class="listing listing--wide">
<thead>
	<th>{translate key="common.id"}</th>
	<th>{translate key="common.originalFileName"}</th>
	<th>{translate key="common.type"}</th>
	<th>{translate key="common.fileSize"}</th>
	<th>{translate key="common.dateUploaded"}</th>
</thead>
{foreach from=$files item=file}
<tbody>
<tr >
	<td data-title='{translate key="common.id"}'>{$file->getFileId()}</td>
	<td data-title='{translate key="common.originalFileName"}'><a class="file" href="{url op="download" path=$articleId|to_array:$file->getFileId()}">{$file->getOriginalFileName()|escape}</a></td>
	<td data-title='{translate key="common.type"}'>{if ($file->getFileStage() == ARTICLE_FILE_SUPP)}{translate key="article.suppFile"}{else}{translate key="author.submit.submissionFile"}{/if}</td>
	<td data-title='{translate key="common.fileSize"}'>{$file->getNiceFileSize()}</td>
	<td data-title='{translate key="common.dateUploaded"}'>{$file->getDateUploaded()|date_format:$dateFormatTrunc}</td>
</tr>
{foreachelse}
<tr >
<td colspan="5" class="nodata">{translate key="author.submit.noFiles"}</td>
</tr>
{/foreach}
</tbody>
</table>


{if $authorFees}
	{include file="author/submit/authorFees.tpl" showPayLinks=1}
	{if $manualPayment}
		<h3>{translate key="payment.alreadyPaid"}</h3>
		<table class="data" width="100%">
			<tr >
			<td width="5%" align="left"><input type="checkbox" name="paymentSent" value="1" {if $paymentSent}checked="checked"{/if} /></td>
			<td width="95%">{translate key="payment.paymentSent"}</td>
			</tr>
			<tr>
			<td />
			<td>{translate key="payment.alreadyPaidMessage"}</td>
			<tr>
		</table>
	{/if}
	{if $currentJournal->getLocalizedSetting('waiverPolicy') != ''}
		<h3>{translate key="author.submit.requestWaiver"}</h3>
		<table class="data" width="100%">
			<tr >
				<td width="5%" align="left"><input type="checkbox" name="qualifyForWaiver" value="1" {if $qualifyForWaiver}checked="checked"{/if}/></td>
				<td width="95%">{translate key="author.submit.qualifyForWaiver"}</td>
			</tr>
			<tr>
				<td />
				<td>
					<label for="commentsToEditor">{translate key="author.submit.addReasonsForWaiver"}</label>
					<textarea name="commentsToEditor" id="commentsToEditor" rows="3" cols="40" class="textArea">{$commentsToEditor|escape}</textarea>
				</td>
			</tr>
		</table> 
	{/if}

{/if}

{call_hook name="Templates::Author::Submit::Step5::AdditionalItems"}

<div class="buttons">
	<input type="submit" value="{translate key="author.submit.finishSubmission"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" />
</div>

</form>

{include file="common/footer.tpl"}

