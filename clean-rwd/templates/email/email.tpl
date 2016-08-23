{**
 * templates/email/email.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Generic email template form
 *
 *}
{strip}
{assign var="pageTitle" value="email.compose"}
{assign var="pageCrumbTitle" value="email.email"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function deleteAttachment(fileId) {
	var emailForm = document.getElementById('emailForm');
	emailForm.deleteAttachment.value = fileId;
	emailForm.submit();
}
// -->
{/literal}
</script>

<form method="post" id="emailForm" action="{$formActionUrl}"{if $attachmentsEnabled} enctype="multipart/form-data"{/if}>
<input type="hidden" name="continued" value="1"/>
{if $hiddenFormParams}
	{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
		<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
	{/foreach}
{/if}

{if $attachmentsEnabled}
	<input type="hidden" name="deleteAttachment" value="" />
	{foreach from=$persistAttachments item=temporaryFile}
		{if is_object($temporaryFile)}<input type="hidden" name="persistAttachments[]" value="{$temporaryFile->getId()}" />{/if}
	{/foreach}
{/if}

{include file="common/formErrors.tpl"}

{foreach from=$errorMessages item=message}
	{if !$notFirstMessage}
		{assign var=notFirstMessage value=1}
		<h4>{translate key="form.errorsOccurred"}</h4>
		<ul class="plain">
	{/if}
	{if $message.type == MAIL_ERROR_INVALID_EMAIL}
		{translate|assign:"message" key="email.invalid" email=$message.address}
		<li>{$message|escape}</li>
	{/if}
{/foreach}

{if $notFirstMessage}
	</ul>
	<br/>
{/if}

<div class="form-row">
	{fieldLabel name="to" key="email.to"}
		{foreach from=$to item=toAddress}
			<input type="text" name="to[]" id="to" value="{if $toAddress.name != ''}{$toAddress.name|escape} &lt;{$toAddress.email|escape}&gt;{else}{$toAddress.email|escape}{/if}" {if !$addressFieldsEnabled}disabled="disabled" {/if}size="40" maxlength="120" class="textField" /><br/>
		{foreachelse}
			<input type="text" name="to[]" id="to" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/foreach}

		{if $blankTo}
			<input type="text" name="to[]" id="to" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/if}
</div>

<div class="form-row">
	{fieldLabel name="cc" key="email.cc"}
		{foreach from=$cc item=ccAddress}
			<input type="text" name="cc[]" id="cc" value="{if $ccAddress.name != ''}{$ccAddress.name|escape} &lt;{$ccAddress.email|escape}&gt;{else}{$ccAddress.email|escape}{/if}" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/><br/>
		{foreachelse}
			<input type="text" name="cc[]" id="cc" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/foreach}

		{if $blankCc}
			<input type="text" name="cc[]" id="cc" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/if}
</div>


<div class="form-row">
	{fieldLabel name="bcc" key="email.bcc"}
		{foreach from=$bcc item=bccAddress}
			<input type="text" name="bcc[]" id="bcc" value="{if $bccAddress.name != ''}{$bccAddress.name|escape} &lt;{$bccAddress.email|escape}&gt;{else}{$bccAddress.email|escape}{/if}" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/><br/>
		{foreachelse}
			<input type="text" name="bcc[]" id="bcc" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/foreach}

		{if $blankBcc}
			<input type="text" name="bcc[]" id="bcc" size="40" maxlength="120" class="textField" {if !$addressFieldsEnabled}disabled="disabled" {/if}/>
		{/if}
</div>

{if $addressFieldsEnabled}

{if $senderEmail}
	<div class="form-row">
		<input type="checkbox" name="bccSender" id="bccSender" value="1"{if $bccSender} checked{/if} />
		<label class="label--inline" for="bccSender">{translate key="email.bccSender" address=$senderEmail|escape}</label>
	</div>
{/if}

<div class="buttons">
		<input type="submit" name="blankTo" class="button" value="{translate key="email.addToRecipient"}"/>
		<input type="submit" name="blankCc" class="button" value="{translate key="email.addCcRecipient"}"/>
		<input type="submit" name="blankBcc" class="button" value="{translate key="email.addBccRecipient"}"/>
</div>
{/if}{* $addressFieldsEnabled *}

{if $attachmentsEnabled}


<div class="form-row">
	<p class="label">{translate key="email.attachments"}</p>
		{assign var=attachmentNum value=1}
		{foreach from=$persistAttachments item=temporaryFile}
			{if is_object($temporaryFile)}
				{$attachmentNum|escape}.&nbsp;{$temporaryFile->getOriginalFileName()|escape}&nbsp;
				({$temporaryFile->getNiceFileSize()})&nbsp;
				<a href="javascript:deleteAttachment({$temporaryFile->getId()})" class="action">{translate key="common.delete"}</a>
				{assign var=attachmentNum value=$attachmentNum+1}
			{/if}
		{/foreach}

		{if $attachmentNum != 1}<br/>{/if}

		<input type="file" name="newAttachment" class="pkp_form_uploadField" /> <input name="addAttachment" type="submit" class="button" value="{translate key="common.upload"}" />
</div>

{/if}
<div class="form-row">
	{fieldLabel name="subject" key="email.subject"}
	<input type="text" id="subject" name="subject" value="{$subject|escape}" size="60" maxlength="120" class="textField" />
</div>

<div class="form-row">
	{fieldLabel name="body" key="email.body"}
	<textarea name="body" cols="60" rows="15" class="textArea">{$body|escape}</textarea>
</div>

<div class="buttons">
	<input name="send" type="submit" value="{translate key="email.send"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button" onclick="history.go(-1)" />
	{if !$disableSkipButton}
	<input name="send[skip]" type="submit" value="{translate key="email.skip"}" class="button button--cancel" />{/if}
</div>

</form>

{include file="common/footer.tpl"}
