{**
 * templates/user/register.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.register"}
{include file="common/header.tpl"}
{/strip}

{if $implicitAuth === true && !Validation::isLoggedIn()}
	<p>
		<a href="{url page="login" op="implicitAuthLogin"}">{translate key="user.register.implicitAuth"}</a>
	</p>
{else}
	<form id="registerForm" method="post" action="{url op="registerUser"}">

	<p>{translate key="user.register.completeForm"}<br>

	{if !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn())}
		{if !$existingUser}
			{url|assign:"url" page="user" op="register" existingUser=1}
			{translate key="user.register.alreadyRegisteredOtherJournal" registerUrl=$url}
		{else}
			{url|assign:"url" page="user" op="register"}
			{translate key="user.register.notAlreadyRegisteredOtherJournal" registerUrl=$url}
			<input type="hidden" name="existingUser" value="1"/>
		{/if}

		{if $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
			<a href="{url page="login" op="implicitAuthLogin"}">{translate key="user.register.implicitAuth"}</a>
		{/if}

		<h3>{translate key="user.profile"}</h3>

		{include file="common/formErrors.tpl"}

		{if $existingUser}
			<p>{translate key="user.register.loginToRegister"}</p>
		{/if}
	{/if}{* !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn()) *}

	{if $source}
		<input type="hidden" name="source" value="{$source|escape}" />
	{/if}
{/if}{* $implicitAuth === true && !Validation::isLoggedIn() *}
</p>


{if count($formLocales) > 1 && !$existingUser}
	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
		{url|assign:"userRegisterUrl" page="user" op="register" escape=false}
		{form_language_chooser form="registerForm" url=$userRegisterUrl}
		<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
{/if}{* count($formLocales) > 1 && !$existingUser *}

{if !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn())}
	<div class="form-row">
		{fieldLabel name="username" required="true" key="user.username"}
		<input type="text" name="username" value="{$username|escape}" id="username" size="20" maxlength="32" class="textField" />
	{if !$existingUser}
		<p class="instruct">{translate key="user.register.usernameRestriction"}</p>
	{/if}{* !$existingUser *}
	</div>

	<div class="form-row">
		{fieldLabel name="password" required="true" key="user.password"}
		<input type="password" name="password" value="{$password|escape}" id="password" size="20" class="textField" />
		<p class="instruct">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</p>
	</div>

	{if !$existingUser}
		<div class="form-row">
			{fieldLabel name="password2" required="true" key="user.repeatPassword"}
			<input type="password" name="password2" id="password2" value="{$password2|escape}" size="20" class="textField" />
		</div>

		{if $captchaEnabled}
			<div class="form-row">
				{if $reCaptchaEnabled}
				{fieldLabel name="recaptcha_challenge_field" required="true" key="common.captchaField"}
				{$reCaptchaHtml}
				{else}
				{fieldLabel name="captcha" required="true" key="common.captchaField"}
					<img src="{url page="user" op="viewCaptcha" path=$captchaId}" alt="{translate key="common.captchaField.altText"}" />
					<span class="instruct">{translate key="common.captchaField.description"}</span>
					<input name="captcha" id="captcha" value="" size="20" maxlength="32" class="textField" />
					<input type="hidden" name="captchaId" value="{$captchaId|escape:"quoted"}" />
				{/if}
			</div>
		{/if}{* $captchaEnabled *}

		<div class="form-row">
			{fieldLabel name="salutation" key="user.salutation"}
			<input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="textField" />
		</div>
		<div class="form-row">
			{fieldLabel name="firstName" required="true" key="user.firstName"}
			<input type="text" id="firstName" name="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="textField" />
		</div>

		<div class="form-row">
			{fieldLabel name="middleName" key="user.middleName"}
			<input type="text" id="middleName" name="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="textField" />
		</div>

		<div class="form-row">
			{fieldLabel name="lastName" required="true" key="user.lastName"}
			<input type="text" id="lastName" name="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="textField" />
		</div>

		<div class="form-row">
			{fieldLabel name="initials" key="user.initials"}
			<input type="text" id="initials" name="initials" value="{$initials|escape}" size="5" maxlength="5" class="textField" />
			<p class="instruct">{translate key="user.initialsExample"}</p>
		</div>

		<div class="form-row">
			{fieldLabel name="gender-m" key="user.gender"}
			
				<select name="gender" id="gender" size="1" class="selectMenu">
					{html_options_translate options=$genderOptions selected=$gender}
				</select>
			
		</div>

		<div class="form-row">
			{fieldLabel name="affiliation" key="user.affiliation"}
			
				<textarea id="affiliation" name="affiliation[{$formLocale|escape}]" rows="5" cols="40" class="textArea">{$affiliation[$formLocale]|escape}</textarea>
				<p class="instruct">{translate key="user.affiliation.description"}</p>
			
		</div>

		<div class="form-row">
			{fieldLabel name="signature" key="user.signature"}
			<textarea name="signature[{$formLocale|escape}]" id="signature" rows="5" cols="40" class="textArea">{$signature[$formLocale]|escape}</textarea>
		</div>

		<div class="form-row">
			{fieldLabel name="email" required="true" key="user.email"}
			<input type="text" id="email" name="email" value="{$email|escape}" size="30" maxlength="90" class="textField" /> {if $privacyStatement}<a class="action" href="#privacyStatement">{translate key="user.register.privacyStatement"}</a>{/if}
		</div>

		<div class="form-row">
			{fieldLabel name="confirmEmail" required="true" key="user.confirmEmail"}
			<input type="text" id="confirmEmail" name="confirmEmail" value="{$confirmEmail|escape}" size="30" maxlength="90" class="textField" />
		</div>

		<div class="form-row">
			{fieldLabel name="orcid" key="user.orcid"}
			<input type="text" id="orcid" name="orcid" value="{$orcid|escape}" size="40" maxlength="255" class="textField" />
			<p class="instruct">{translate key="user.orcid.description"}</p>
		</div>

		<div class="form-row">
			{fieldLabel name="userUrl" key="user.url"}
			<input type="text" id="userUrl" name="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="textField" />
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

		<div class="form-row">
			{fieldLabel name="sendPassword" key="user.sendPassword"}
			
			<input type="checkbox" name="sendPassword" id="sendPassword" value="1"{if $sendPassword} checked="checked"{/if} /> <label class="label--inline label--normal" for="sendPassword">{translate key="user.sendPassword.description"}</label>
			
		</div>

		{if count($availableLocales) > 1}
			<div class="form-row">
				<p class="label">{translate key="user.workingLanguages"}</p>
				<div class="form-subrow">
				{foreach from=$availableLocales key=localeKey item=localeName}
					<div class="form-group">
					<input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $userLocales)} checked="checked"{/if} /> 
					<label for="userLocales-{$localeKey|escape}">{$localeName|escape}</label>
					</div>
				{/foreach}
				</div>
			</div>
		{/if}{* count($availableLocales) > 1 *}
	{/if}{* !$existingUser *}

{/if}{* !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn()) *}


{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL || ($implicitAuth === true && Validation::isLoggedIn())}
	{if $allowRegReader || $allowRegReader === null || $allowRegAuthor || $allowRegAuthor === null || $allowRegReviewer || $allowRegReviewer === null || ($currentJournal && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification)}
		<div class="form-row">
			{fieldLabel suppressId="true" name="registerAs" key="user.register.registerAs"}
			<div class="form-subrow">
			{if $allowRegReader || $allowRegReader === null}
				<div class="form-group"><input type="checkbox" name="registerAsReader" id="registerAsReader" value="1"{if $registerAsReader} checked="checked"{/if} /> 
					<label for="registerAsReader">{translate key="user.role.reader"}</label> 
					<p class="instruct">{translate key="user.register.readerDescription"}</p>
				</div>
			{/if}
			{if $currentJournal && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification}
				<div class="form-group"><input type="checkbox" name="openAccessNotification" id="openAccessNotification" value="1"{if $openAccessNotification} checked="checked"{/if} /> 
				<label for="openAccessNotification">{translate key="user.role.reader"}</label> <p class="instruct">{translate key="user.register.openAccessNotificationDescription"}</p>
			</div>
			{/if}
			{if $allowRegAuthor || $allowRegAuthor === null}
			<div class="form-group">
				<input type="checkbox" name="registerAsAuthor" id="registerAsAuthor" value="1"{if $registerAsAuthor} checked="checked"{/if} /> 
				<label for="registerAsAuthor">{translate key="user.role.author"}</label>
				<p class="instruct">{translate key="user.register.authorDescription"}</p>
			</div>
			{/if}
			{if $allowRegReviewer || $allowRegReviewer === null}
			<div class="form-group">
				<input type="checkbox" name="registerAsReviewer" id="registerAsReviewer" value="1"{if $registerAsReviewer} checked="checked"{/if} /> 
				<label for="registerAsReviewer">{translate key="user.role.reviewer"}</label>
				<p class="instruct">{if $existingUser}{translate key="user.register.reviewerDescriptionNoInterests"}{else}{translate key="user.register.reviewerDescription"}</p>
			</div>
			{/if}
			<div id="reviewerInterestsContainer">
				<label class="desc">{translate key="user.register.reviewerInterests"}</label>
				{include file="form/interestsInput.tpl" FBV_interestsKeywords=$interestsKeywords FBV_interestsTextOnly=$interestsTextOnly}
			</div>
			
			{/if}
			</div>
		</div>
	{/if}

	
	<div id="privacyStatement">
	{if $privacyStatement}
		<h3>{translate key="user.register.privacyStatement"}</h3>
		<p>{$privacyStatement|nl2br}</p>
	{/if}
	</div>
	
	<div class="buttons">
		<input type="submit" value="{translate key="user.register"}" class="button defaultButton" /> 
		<input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url page="index" escape=false}'" />
	</div>
{/if}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL || ($implicitAuth === true && Validation::isLoggedIn()) *}


{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<p><span class="form-required">{translate key="common.requiredField"}</span></p>

{/if}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL *}

</form>


{include file="common/footer.tpl"}

