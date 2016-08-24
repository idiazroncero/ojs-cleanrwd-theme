{**
 * templates/notification/settings.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Displays the notification settings page and unchecks
 *
 *}
{strip}
{assign var="pageTitle" value="notification.settings"}
{include file="common/header.tpl"}
{/strip}

<p>{translate key="notification.settingsDescription"}</p>

<form id="notificationSettings" method="post" action="{url op="saveSettings"}">

<!-- Submission events -->
{foreach from=$notificationSettingCategories item=notificationSettingCategory}
	<h4>{translate key=$notificationSettingCategory.categoryKey}</h4>
	{foreach from=$notificationSettingCategory.settings item=settingId}
		{assign var="notificationSetting" value=$notificationSettings.$settingId}
		{assign var="settingName" value=$notificationSetting.settingName}
		{assign var="emailSettingName" value=$notificationSetting.emailSettingName}
		{assign var="settingKey" value=$notificationSetting.settingKey}

		<div class="form-row">
			<p class="label">{translate key=$settingKey title=$titleVar}</p>
			<div class="form-subrow">
				<div class="form-group">
					<input id="{$settingName|escape}" type="checkbox" name="{$settingName|escape}" {if !$settingId|in_array:$blockedNotifications} checked="checked"{/if} />
					{fieldLabel name="$settingName|escape" key="notification.allow"}
				</div>
				<div class="form-group">
					<input id="{$emailSettingName|escape}" type="checkbox" name="{$emailSettingName|escape}"{if $settingId|in_array:$emailSettings} checked="checked"{/if} />
					{fieldLabel name="$emailSettingName|escape" key="notification.email"}
				</div>
			</div>
		</div>
	{/foreach}
	
{/foreach}

<p><input type="submit" value="{translate key="form.submit"}" class="button defaultButton" />  <input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url page="notification" escape=false}'" /></p>

</form>

{include file="common/footer.tpl"}

