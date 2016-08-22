{**
 * templates/manager/emails/emails.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of email templates in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.emails"}
{include file="common/header.tpl"}
{/strip}



<section id="emails">
	<form action="{url op="exportEmails"}" method="post" id="emailsForm">
		<table class="listing listing--wide">
			<thead>
			<tr class="heading" >
				<th>{translate key="manager.emails.emailTemplates"}</th>
				<th>{translate key="email.sender"}</th>
				<th>{translate key="email.recipient"}</th>
				<th>{translate key="email.subject"}</th>
				<th>{translate key="common.action"}</th>
				<th>&nbsp;</th>
			</tr>
			</thead>
			<tbody>
		{iterate from=emailTemplates item=emailTemplate}
			<tr >
				<td data-title='{translate key="manager.emails.emailTemplates"}'>
					{url|assign:"emailUrl" op="email" template=$emailTemplate->getEmailKey()}
					{$emailTemplate->getEmailKey()|escape|replace:"_":" "}&nbsp;{icon name="mail" url=$emailUrl}
				</td>
				<td data-title='{translate key="email.sender"}'>{translate key=$emailTemplate->getFromRoleName()}</td>
				<td data-title='{translate key="email.recipient"}'>{translate key=$emailTemplate->getToRoleName()}</td>
				<td data-title='{translate key="email.subject"}'>{$emailTemplate->getSubject()|escape|truncate:50:"..."}</td>
				<td data-title='{translate key="common.action"}' class="nowrap">
					<a href="{url op="editEmail" path=$emailTemplate->getEmailKey()}" class="action">{translate key="common.edit"}</a>
					{if $emailTemplate->getCanDisable() && !$emailTemplate->isCustomTemplate()}
						{if $emailTemplate->getEnabled() == 1}
							&nbsp;<a href="{url op="disableEmail" path=$emailTemplate->getEmailKey()}" class="action">{translate key="manager.emails.disable"}</a>
						{else}
							&nbsp;<a href="{url op="enableEmail" path=$emailTemplate->getEmailKey()}" class="action">{translate key="manager.emails.enable"}</a>
						{/if}
					{/if}
					{if $emailTemplate->isCustomTemplate()}
						&nbsp;<a href="{url op="deleteCustomEmail" path=$emailTemplate->getEmailKey()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.emails.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
					{else}
						&nbsp;<a href="{url op="resetEmail" path=$emailTemplate->getEmailKey()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.emails.confirmReset"}')" class="action">{translate key="manager.emails.reset"}</a>
					{/if}
				</td>
				<td><input type="checkbox" name="tplId[]" value="{$emailTemplate->getEmailKey()}" /></td>
			</tr>
		{/iterate}
		{if $emailTemplates->wasEmpty()}
			<tr>
				<td colspan="5" class="nodata">{translate key="common.none"}</td>
			</tr>
		{else}
			<tr class="listing-pager">
				<td colspan="3" >{page_info iterator=$emailTemplates}</td>
				<td colspan="2">{page_links anchor="emails" name="emails" iterator=$emailTemplates}</td>
			</tr>
		{/if}
		</tbody>
		</table>
		
		<input type='submit' value='{translate key="manager.emails.exportXML"}' class='button' />

	</form>

	<form class="form-row" id="email_upload" name="email_upload" action="{url op="uploadEmails"}" method="post" enctype="multipart/form-data">
		<input id="uploader" name="email_file" type="file" />
		<input type="submit" value="{translate key="manager.emails.uploadXML"}" class="button" />
	</form>

<div class="buttons">
	<a href="{url op="createEmail"}" class="button">{translate key="manager.emails.createEmail"}</a>
	<a href="{url op="resetAllEmails"}" onclick="return confirm('{translate|escape:"jsparam" key="manager.emails.confirmResetAll"}')" class="button">{translate key="manager.emails.resetAll"}</a>
</div>

</section>
{include file="common/footer.tpl"}