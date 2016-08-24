{**
 * templates/sectionEditor/createReviewerForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for editors to create reviewers.
 *
 *}
{strip}
{assign var="pageTitle" value="sectionEditor.review.createReviewer"}
{include file="common/header.tpl"}
{/strip}

<form method="post" id="reviewerForm" action="{url op="createReviewer" path=$articleId|to_array:"create"}">

{include file="common/formErrors.tpl"}

<script type="text/javascript">
{literal}
// <!--

	function generateUsername() {
		var req = makeAsyncRequest();

		if (document.getElementById('reviewerForm').lastName.value == "") {
			alert("{/literal}{translate key="manager.people.mustProvideName"}{literal}");
			return;
		}

		req.onreadystatechange = function() {
			if (req.readyState == 4) {
				document.getElementById('reviewerForm').username.value = req.responseText;
			}
		}
		sendAsyncRequest(req, '{/literal}{url op="suggestUsername" firstName="REPLACE1" lastName="REPLACE2" escape=false}{literal}'.replace('REPLACE1', escape(document.getElementById('reviewerForm').firstName.value)).replace('REPLACE2', escape(document.getElementById('reviewerForm').lastName.value)), null, 'get');
	}


// -->
{/literal}
</script>

<div id="createReviewerForm">

{if count($formLocales) > 1}
	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
			{url|assign:"createReviewerUrl" op="createReviewer" path=$articleId escape=false}
			{form_language_chooser form="reviewerForm" url=$createReviewerUrl}
			<p class="instruct">{translate key="form.formLanguage.description"}</p>
		</td>
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
		{fieldLabel name="initials" key="user.initials"}
		<input type="text" name="initials" id="initials" value="{$initials|escape}" size="5" maxlength="5" class="textField" />&nbsp;&nbsp;{translate key="user.initialsExample"}
	</div>
	<div class="form-row">
		{fieldLabel name="gender" key="user.gender"}
		<select name="gender" id="gender" size="1" class="selectMenu">
				{html_options_translate options=$genderOptions selected=$gender}
		</select>
	</div>
	<div class="form-row">
		<div class="form-group">
			{fieldLabel name="username" required="true" key="user.username"}
			<input type="text" name="username" id="username" value="{$username|escape}" size="20" maxlength="32" class="textField" />&nbsp;&nbsp;<input type="button" class="button" value="{translate key="common.suggest"}" onclick="generateUsername()" />
			<p class="instruct">{translate key="user.register.usernameRestriction"}</p>
		</div>
		<div class="form-subrow">
			<input type="checkbox" name="sendNotify" id="sendNotify" value="1"{if $sendNotify} checked="checked"{/if} />
			<label class="label--inline"for="sendNotify">{translate key="manager.people.createUserSendNotify"}</label>
		</div>
	</div>
	<div class="form-row">
		{fieldLabel name="affiliation" key="user.affiliation"}
		<textarea name="affiliation[{$formLocale|escape}]" id="affiliation" rows="5" cols="40" class="textArea">{$affiliation[$formLocale]|escape}</textarea>
		<p class="instruct">{translate key="user.affiliation.description"}</p>
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
		{fieldLabel name="biography" key="user.biography"}{translate key="user.biography.description"}
		<textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="textArea">{$biography[$formLocale]|escape}</textarea>
	</div>
	{if count($availableLocales) > 1}
	<div class="form-row">
		{translate key="user.workingLanguages"}
		<div class="form-subrow">
		{foreach from=$availableLocales key=localeKey item=localeName}
			<div class="form-group">
				<input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if $userLocales && in_array($localeKey, $userLocales)} checked="checked"{/if} />
				<label for="userLocales-{$localeKey|escape}">{$localeName|escape}</label>
			</div>
		{/foreach}
		</div>
	</div>
	{/if}
</table>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="selectReviewer" path=$articleId escape=false}'" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>
</div>
</form>

{include file="common/footer.tpl"}

