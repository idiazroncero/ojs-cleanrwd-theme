{**
 * templates/user/lostPassword.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Password reset form.
 *
 *}
{strip}
{assign var="registerOp" value="register"}
{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{assign var="pageTitle" value="user.login.resetPassword"}
{include file="common/header.tpl"}
{/strip}

{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

<form id="reset" action="{url page="login" op="requestResetPassword"}" method="post">

<p>{translate key="user.login.resetPasswordInstructions"}</p>

{if $error}
	<p class="form-error form-error--box">{translate key="$error"}</p>
{/if}


<div class="form-row">
	<label for="email">{translate key="user.login.registeredEmail"}</label>
	<input type="text" name="email" value="{$username|escape}" size="30" maxlength="90" class="textField" />
</div>

<div class="buttons">
	<input type="submit" value="{translate key="user.login.resetPassword"}" class="button" />
</div>

{if !$hideRegisterLink}
	<ul><li><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></li></ul>
{/if}

<script type="text/javascript">
<!--
	document.getElementById('reset').email.focus();
// -->
</script>
</form>

{include file="common/footer.tpl"}

