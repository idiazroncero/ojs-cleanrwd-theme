{**
 * templates/admin/auth/sourceSettings.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Authentication source settings under site administration.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.authSources"}
{include file="common/header.tpl"}
{/strip}

<div id="sourceSettings">
<form method="post" action="{url op="updateAuthSource" path=$authId}">
	<div class="form-row">
		{fieldLabel name="title" key="common.title"}
		<input type="text" id="title" name="title" value="{$title|escape}" size="40" maxlength="120" class="textField" />
	</div>
	<div class="form-row">
		<h4 class="label">{translate key="common.options"}</h4>
		<div class="form-subrow">
			<div class="form-group">
				<input type="checkbox" name="settings[syncProfiles]" id="syncProfiles" value="1"{if $settings.syncProfiles} checked="checked"{/if} />
				<label class="label--inline" for="syncProfiles">{translate key="admin.auth.enableSyncProfiles"}</label>
			</div>
			<div class="form-group">
				<input type="checkbox" name="settings[syncPasswords]" id="syncPasswords" value="1"{if $settings.syncPasswords} checked="checked"{/if} />
				<label class="inline--label "for="syncPasswords">{translate key="admin.auth.enableSyncPasswords"}</label>
			</div>
			<div class="form-group">
				<input type="checkbox" name="settings[createUsers]" id="createUsers" value="1"{if $settings.createUsers} checked="checked"{/if} />
				<label class="label--inline" for="createUsers">{translate key="admin.auth.enableCreateUsers"}</label>
			</div>
		</div>
	</div>

{if $pluginTemplate}{include file=$pluginTemplate}{/if}

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="auth" escape=false}'" />
</div>

</form>
</div>
{include file="common/footer.tpl"}

