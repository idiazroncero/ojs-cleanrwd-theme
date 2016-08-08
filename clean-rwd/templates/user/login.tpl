{**
 * templates/user/login.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{strip}
{assign var="helpTopicId" value="user.registerAndProfile"}
{assign var="registerOp" value="register"}
{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/strip}

{**
 * templates/user/login.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login"}
{include file="common/header.tpl"}
{/strip}

{if !$registerOp}
	{assign var="registerOp" value="register"}
{/if}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

{if $loginMessage}
	<p class="instruct">{translate key="$loginMessage"}</p>
{/if}

{if $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<h3>{translate key="user.login.implicitAuth"}</h3>
{/if}
{if $implicitAuth}
	<a id="implicitAuthLogin" href="{url page="login" op="implicitAuthLogin"}">{translate key="user.login.implicitAuthLogin"}</a>
{/if}
{if $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<h3>{translate key="user.login.localAuth"}</h3>
{/if}
{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<form id="signinForm" method="post" action="{$loginUrl}">
{/if}

{if $error}
	<p class="form-error form-error--box">{translate key="$error" reason=$reason}</p>
{/if}

<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<div class="form-row">
		<label for="loginUsername">{translate key="user.username"}</label>
		<input type="text" id="loginUsername" name="username" value="{$username|escape}" size="20" maxlength="32" class="textField" />
	</div>
	<div class="form-row">
		<label for="loginPassword">{translate key="user.password"}</label>
		<input type="password" id="loginPassword" name="password" value="{$password|escape}" size="20" class="textField" />
	</div>
	{if $showRemember}
	<div class="form-row">
		<input type="checkbox" id="loginRemember" name="remember" value="1"{if $remember} checked="checked"{/if} /> <label for="loginRemember" class="label--inline">{translate key="user.login.rememberUsernameAndPassword"}</label>
	</div>
	{/if}{* $showRemember *}

	<div class="buttons">
		<input type="submit" value="{translate key="user.login"}" class="button" />
	</div>


	<ul>
		{if !$hideRegisterLink}<li><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></li>{/if}
		<li><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></li>
	</ul>

<script type="text/javascript">
<!--
	document.getElementById('{if $username}loginPassword{else}loginUsername{/if}').focus();
// -->
</script>
</form>
{/if}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL *}

{include file="common/footer.tpl"}


