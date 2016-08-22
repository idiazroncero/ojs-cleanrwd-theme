{**
 * templates/manager/emails/emailTemplateForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Basic journal settings under site administration.
 *
 *}
{strip}
{if !$isNewTemplate}
	{assign var="pageTitle" value="manager.emails.editEmail"}
{else}
	{assign var="pageTitle" value="manager.emails.createEmail"}
{/if}
{include file="common/header.tpl"}
{/strip}
<section id="emailTemplateForm">
<form method="post" action="{url op="updateEmail"}">
<input type="hidden" name="emailId" value="{$emailId|escape}" />
<input type="hidden" name="journalId" value="{$journalId|escape}" />
{if !$isNewTemplate}
	<input type="hidden" name="emailKey" value="{$emailKey|escape}" />
{/if}

{if $description}
	<p>{$description|escape}</p>
{/if}



{include file="common/formErrors.tpl"}



{if $isNewTemplate}
	<div class="form-row">
		{fieldLabel name="emailKey" key="manager.emails.emailKey"}
		<input type="text" name="emailKey" value="{$emailKey|escape}" id="emailKey" size="20" maxlength="120" class="textField" />
	</div>
{/if}

{foreach from=$supportedLocales item=localeName key=localeKey}
	<h3>{translate key="manager.emails.emailTemplate"} ({$localeName|escape})</h3>

	<div class="form-row">
		{fieldLabel name="subject-$localeKey" key="email.subject"}
		<input type="text" name="subject[{$localeKey|escape}]" id="subject-{$localeKey|escape}" value="{$subject.$localeKey|escape}" size="70" maxlength="120" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="body-$localeKey" key="email.body"}
		<textarea name="body[{$localeKey|escape}]" id="body-{$localeKey|escape}" cols="70" rows="20" class="textArea">{$body.$localeKey|escape}</textarea>
	</div>
{foreachelse}

	<h3>{translate key="manager.emails.emailTemplate"}</h3>

	<div class="form-row">
		{fieldLabel name="subject-$currentLocale" key="email.subject"}
		<input type="text" name="subject[{$currentLocale|escape}]" id="subject-{$currentLocale|escape}" value="{$subject.$currentLocale|escape}" size="70" maxlength="120" class="textField" />
	</div>

	<div class="form-row">
		{fieldLabel name="body-$currentLocale" key="email.body"}
		<textarea name="body[{$currentLocale|escape}]" id="body-{$currentLocale|escape}" cols="70" rows="20" class="textArea">{$body.$currentLocale|escape}</textarea>
	</div>
{/foreach}
</table>

{if $canDisable}
<div class="form-row">
	<input type="checkbox" name="enabled" id="emailEnabled" value="1"{if $enabled} checked="checked"{/if} />
	<label for="emailEnabled">{translate key="manager.emails.enabled"}</label>
</div>
{/if}

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="emails" escape=false}'" />
	<input type="reset" class="button" />
</div>
</form>
</section>
{include file="common/footer.tpl"}

