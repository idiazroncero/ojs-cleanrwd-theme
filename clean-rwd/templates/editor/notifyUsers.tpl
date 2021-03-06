{**
 * templates/editor/notifyUsers.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor's "Notify Users" email template form
 *
 *}
{strip}
{assign var="pageTitle" value="email.compose"}
{assign var="pageCrumbTitle" value="email.email"}
{include file="common/header.tpl"}
{/strip}

<div id="notifyUsers">
<form method="post" action="{$formActionUrl}">
<input type="hidden" name="continued" value="1"/>
{if $hiddenFormParams}
	{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
		<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
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
	
{/if}

<div id="recipients">
<h3>{translate key="email.recipients"}</h3>

<section class="section">
<div class="form-subrow"><div class="form-group">
		<input type="radio" id="allUsers" name="whichUsers" value="allUsers"/>
		<label for="allUsers">{translate key="editor.notifyUsers.allUsers" count=$allUsersCount|default:0}</label>
	</div>
	
	<div class="form-group">
		<input type="radio" id="allReaders" name="whichUsers" value="allReaders"/>
		<label for="allReaders">{translate key="editor.notifyUsers.allReaders" count=$allReadersCount|default:0}</label>
	</div>
	
		<div class="form-group">
			<input type="radio" id="allAuthors" name="whichUsers" value="allAuthors"/>
			<label for="allAuthors">{translate key="editor.notifyUsers.allAuthors" count=$allAuthorsCount|default:0}</label>
		</div>
	
	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
		
		<div class="form-group">
			<input type="radio" id="allIndividualSubscribers" name="whichUsers" value="allIndividualSubscribers"/>
			<label for="allIndividualSubscribers">{translate key="editor.notifyUsers.allIndividualSubscribers" count=$allIndividualSubscribersCount|default:0}</label>
		</div>
	
		<div class="form-group">
			<input type="radio" id="allInstitutionalSubscribers" name="whichUsers" value="allInstitutionalSubscribers"/>
			<label for="allInstitutionalSubscribers">{translate key="editor.notifyUsers.allInstitutionalSubscribers" count=$allInstitutionalSubscribersCount|default:0}</label>
		</div>
	
	{/if}{* publishingMode is PUBLISHING_MODE_SUBSCRIPTION *}
	
	<div class="form-group">
		<input type="checkbox" name="sendToMailList" />
		<label for="sendToMailList">{translate key="editor.notifyUsers.allMailingList" count=$allMailListCount|default:0}</label>
	</div>
	
	{if $senderEmail}
		<div class="form-group">
			<input type="checkbox" name="ccSelf" />
			<label for="ccSelf">{translate key="email.bccSender" address=$senderEmail|escape}</label>
		</div>
	
	{/if}</div>

</section>{* recipients *}



<section class="section" id="issue">
<h3>{translate key="issue.issue"}</h3>


<div class="form-subrow">
	<input type="checkbox" name="includeToc" id="includeToc" value="1"/>
	
	<label for="includeToc">{translate key="editor.notifyUsers.includeToc"}</label>&nbsp;
	<select name="issue" id="issue" class="selectMenu">
		{iterate from=issues item=issue}
			<option {if $issue->getCurrent()}checked {/if}value="{$issue->getId()}">{$issue->getIssueIdentification()|strip_tags|truncate:40:"..."|escape}</option>
		{/iterate}
	</select>
</div>


</section>




<section id="email" class="section">
<h3>Email</h3>
<div class="form-subrow">
	<div class="form-group">
		{translate key="email.from"}
		{$from|escape}</p>
	</div>
	<div class="form-group">
		{fieldLabel name="subject" key="email.subject"}
		<input type="text" id="subject" name="subject" value="{$subject|escape}" size="60" maxlength="120" class="textField" />
	</div>
	<div class="form-group">
		{fieldLabel name="body" key="email.body"}
		<textarea name="body" cols="60" rows="15" class="textArea">{$body|escape}</textarea>
	</div>
</div>

</section>

<div class="buttons">
	<input name="send" type="submit" value="{translate key="email.send"}" class="button defaultButton" /><input type="button" value="{translate key="common.cancel"}" class="button" onclick="history.go(-1)" />
</div>
</form>
</div>
{include file="common/footer.tpl"}

