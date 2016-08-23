{**
 * templates/user/changePassword.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to change a user's password.
 *
 *}
{strip}
{assign var="pageTitle" value="user.changePassword"}
{url|assign:"currentUrl" page="user" op="changePassword"}
{include file="common/header.tpl"}
{/strip}

<div id="changePassword">
<form method="post" action="{url op="savePassword"}">

{include file="common/formErrors.tpl"}

{if $implicitAuth}
<p>{translate key="user.profile.implicitAuthChangePasswordInstructions"}</p>
{/if}
<p>{translate key="user.profile.changePasswordInstructions"}</p>


<div class="form-row">
	{fieldLabel name="oldPassword" key="user.profile.oldPassword"}
	<input type="password" name="oldPassword" id="oldPassword" value="{$oldPassword|escape}" size="20" class="textField" />
</div>
<div class="form-row">
	{fieldLabel name="password" key="user.profile.newPassword"}
	<input type="password" name="password" value="{$password|escape}" id="password" size="20" class="textField" />
	<p class="instruct">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</p>
</div>
<div class="form-row">
	{fieldLabel name="password2" key="user.profile.repeatNewPassword"}
	<input type="password" name="password2" id="password2" value="{$password2|escape}" size="20" class="textField" />
</div>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url page="user" escape=false}'" />
</div>
</form>
</div>
{include file="common/footer.tpl"}

