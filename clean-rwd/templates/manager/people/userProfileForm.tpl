{**
 * templates/manager/people/userProfileForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User profile form under journal management.
 *
 *}
{strip}
{url|assign:"currentUrl" op="people" path="all"}
{assign var="pageTitle" value="manager.people"}
{include file="common/header.tpl"}
{/strip}

{if not $userId}
{assign var="passwordRequired" value="true"}

{literal}
<script type="text/javascript">
<!--
	function setGenerateRandom(value) {
		var userForm = document.getElementById('userForm');
		if (value) {
			userForm.password.value='********';
			userForm.password2.value='********';
			userForm.password.disabled=1;
			userForm.password2.disabled=1;
			userForm.sendNotify.checked=1;
			userForm.sendNotify.disabled=1;
		} else {
			userForm.password.disabled=0;
			userForm.password2.disabled=0;
			userForm.sendNotify.disabled=0;
			userForm.password.value='';
			userForm.password2.value='';
			userForm.password.focus();
		}
	}

	function enablePasswordFields() {
		var userForm = document.getElementById('userForm');
		userForm.password.disabled=0;
		userForm.password2.disabled=0;
	}

	function generateUsername() {
		var userForm = document.getElementById('userForm');
		var req = makeAsyncRequest();

		if (userForm.lastName.value == "") {
			alert("{/literal}{translate key="manager.people.mustProvideName"}{literal}");
			return;
		}

		req.onreadystatechange = function() {
			if (req.readyState == 4) {
				userForm.username.value = req.responseText;
			}
		}
		sendAsyncRequest(req, '{/literal}{url op="suggestUsername" firstName="REPLACE1" lastName="REPLACE2" escape=false}{literal}'.replace('REPLACE1', escape(userForm.firstName.value)).replace('REPLACE2', escape(userForm.lastName.value)), null, 'get');
	}

// -->
</script>
{/literal}
{/if}

{if $userCreated}
<p>{translate key="manager.people.userCreatedSuccessfully"}</p>
{/if}

<h3>{if $userId}{translate key="manager.people.editProfile"}{else}{translate key="manager.people.createUser"}{/if}</h3>

<form id="userForm" method="post" action="{url op="updateUser"}" onsubmit="enablePasswordFields()">
<input type="hidden" name="source" value="{$source|escape}" />
{if $userId}
<input type="hidden" name="userId" value="{$userId|escape}" />
{/if}

{include file="common/formErrors.tpl"}


{if count($formLocales) > 1}
	 <div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
			{url|assign:"userFormUrl" page="manager" op="editUser" path=$userId escape=false}
			{form_language_chooser form="userForm" url=$userFormUrl}
			<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
{/if}
	<div class="form-row">
		{fieldLabel name="salutation" key="user.salutation"}
		<input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="firstName" required="true" key="user.firstName"}
		<input type="text" name="firstName" id="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="middleName" key="user.middleName"}
		<input type="text" name="middleName" id="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="lastName" required="true" key="user.lastName"}
		<input type="text" name="lastName" id="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel suppressId="true" name="gender" key="user.gender"}
		<select name="gender" id="gender" size="1" class="selectMenu">
				{html_options_translate options=$genderOptions selected=$gender}
		</select>
	</div>
	<div class="form-row">
		{fieldLabel name="initials" key="user.initials"}
		<input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="textField" />&nbsp;&nbsp;{translate key="user.initialsExample"}
	</div>
	{if not $userId}
	<div class="form-row">
		{fieldLabel name="enrollAs" key="manager.people.enrollUserAs"}
		<select name="enrollAs[]" id="enrollAs" multiple="multiple" size="11" class="selectMenu">
			{html_options_translate options=$roleOptions selected=$enrollAs}
		</select>
		<p class="instruct">{translate key="manager.people.enrollUserAsDescription"}</p>
	</div>
	<div class="form-row">
		{fieldLabel name="username" required="true" key="user.username"}
		<input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="32" class="textField" />&nbsp;&nbsp;<input type="button" class="button" value="{translate key="common.suggest"}" onclick="generateUsername()" />
		<p class="instruct">{translate key="user.register.usernameRestriction"}</p>
	</div>
	{else}
	<div class="form-row">
		{fieldLabel suppressId="true" name="username" key="user.username"}
		<strong>{$username|escape}</strong>
	</div>
	{/if}
	{if $authSourceOptions}
	<div class="form-row">
		{fieldLabel name="authId" key="manager.people.authSource"}
		<select name="authId" id="authId" size="1" class="selectMenu">
			<option value=""></option>
			{html_options options=$authSourceOptions selected=$authId}
		</select>
	</div>
	{/if}

	{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
		<div class="form-row">
			<div class="form-group">
				{fieldLabel name="password" required=$passwordRequired key="user.password"}
				<input type="password" name="password" id="password" value="{$password|escape}" size="20" class="textField" />
				<p class="instruct">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</p>
			</div>

			<div class="form-group">
				{fieldLabel name="password2" required=$passwordRequired key="user.repeatPassword"}
				<input type="password" name="password2"  id="password2" value="{$password2|escape}" size="20" class="textField" />
				{if $userId}
					<p class="instruct">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}{translate key="user.profile.leavePasswordBlank"}</p>
				{else}
					<div class="form-group">
						<input type="checkbox" onclick="setGenerateRandom(this.checked)" name="generatePassword" id="generatePassword" value="1"{if $generatePassword} checked="checked"{/if} />
						<label class="label--inline" for="generatePassword">{translate key="manager.people.createUserGeneratePassword"}</label>
					</div>
					<div class="form-group">
						<input type="checkbox" name="sendNotify" id="sendNotify" value="1"{if $sendNotify} checked="checked"{/if} />
						<label class="label--inline" for="sendNotify">{translate key="manager.people.createUserSendNotify"}</label>
					</div>
				{/if}
			</div>
		</div>

		<div class="form-row">
			<input type="checkbox" name="mustChangePassword" id="mustChangePassword" value="1"{if $mustChangePassword} checked="checked"{/if} />
			<label class="label--inline" for="mustChangePassword">{translate key="manager.people.userMustChangePassword"}</label>
		</div>
	{/if}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL *}

	<div class="form-row">
		{fieldLabel name="affiliation" key="user.affiliation"}
			<textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="textArea">{$affiliation[$formLocale]|escape}</textarea>
			<p class="instruct">{translate key="user.affiliation.description"}</p>
	</div>
	<div class="form-row">
		{fieldLabel name="signature" key="user.signature"}
		<textarea name="signature[{$formLocale|escape}]" id="signature" rows="5" cols="40" class="textArea">{$signature[$formLocale]|escape}</textarea>
	</div>
	<div class="form-row">
		{fieldLabel name="email" required="true" key="user.email"}
		<input type="text" name="email" id="email" value="{$email|escape}" size="30" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="orcid" key="user.orcid"}
		<input type="text" name="orcid" id="orcid" value="{$orcid|escape}" size="30" maxlength="255" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="userUrl" key="user.url"}
		<input type="text" name="userUrl" id="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="phone" key="user.phone"}
		<input type="text" name="phone" id="phone" value="{$phone|escape}" size="15" maxlength="24" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="fax" key="user.fax"}
		<input type="text" name="fax" id="fax" value="{$fax|escape}" size="15" maxlength="24" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel for="interests" key="user.interests"}
		{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
	</div>
	<div class="form-row">
		{fieldLabel name="gossip" key="user.gossip"}
		<textarea name="gossip[{$formLocale|escape}]" id="gossip" rows="3" cols="40" class="textArea">{$gossip[$formLocale]|escape}</textarea>
	</div>
	<div class="form-row">
		{fieldLabel name="mailingAddress" key="common.mailingAddress"}
		<textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="textArea">{$mailingAddress|escape}</textarea>
	</div>
	<div class="form-row">
		{fieldLabel name="country" key="common.country"}
			<select name="country" id="country" class="selectMenu">
				<option value=""></option>
				{html_options options=$countries selected=$country}
			</select>
	</div>
	<div class="form-row">
		{fieldLabel name="biography" key="user.biography"}
		<textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="textArea">{$biography[$formLocale]|escape}</textarea>
		<p class="instruct">{translate key="user.biography.description"}</p>
	</div>
	{if count($availableLocales) > 1}
	<div class="form-row">
		<p class="label">{translate key="user.workingLanguages"}</p>
		<div class="form-subrow">
		{foreach from=$availableLocales key=localeKey item=localeName}
			<div class="form-group">
				<input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if $userLocales && in_array($localeKey, $userLocales)} checked="checked"{/if} /><label for="userLocales-{$localeKey|escape}">{$localeName|escape}</label>
			</div>
		{/foreach}
		</div>
	</div>
	{/if}


<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" /> {if not $userId}
	<input type="submit" name="createAnother" value="{translate key="manager.people.saveAndCreateAnotherUser"}" class="button" /> {/if}
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="{if $source == ''}history.go(-1);{else}document.location='{$source|escape:"jsparam"}';{/if}" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{if $generatePassword}
{literal}
	<script type="text/javascript">
		<!--
		setGenerateRandom(1);
		// -->
	</script>
{/literal}
{/if}

{include file="common/footer.tpl"}

