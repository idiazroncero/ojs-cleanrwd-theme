{**
 * templates/admin/languages.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to edit site language settings.
 *
 *}
{strip}
{assign var="pageTitle" value="common.languages"}
{include file="common/header.tpl"}
{/strip}

<form method="post" action="{url op="saveLanguageSettings"}">
<div id="languageSettings">
	<h3>{translate key="admin.languages.languageSettings"}</h3>

	<div class="form-row">
		<p class="label">{translate key="locale.primary"}<span class="instruct">{translate key="admin.languages.primaryLocaleInstructions"}</></p>
		<select name="primaryLocale" id="primaryLocale" size="1" class="selectMenu">
			{foreach from=$installedLocales item=localeKey}
				<option value="{$localeKey|escape}"{if $localeKey == $primaryLocale} selected="selected"{/if}>{$localeNames.$localeKey|escape}</option>
			{/foreach}
		</select>
	</div>
	<div class="form-row">
		<p class="label">{translate key="locale.supported"}</p>
			<div class="form-subrow">
				<ul>
				{foreach from=$installedLocales item=localeKey}
					<li>
						<input type="checkbox" name="supportedLocales[]" id="supportedLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $supportedLocales)} checked="checked"{/if} />
						<label for="supportedLocales-{$localeKey|escape}">{$localeNames.$localeKey|escape}</label>
						{if !$localesComplete[$localeKey]}
							<span class="formError">*</span>
							{assign var=incompleteLocaleFound value=1}
						{/if}
					</li>
				{/foreach}
				</ul>
			</div>
			<p class="instruct">{translate key="admin.languages.supportedLocalesInstructions"}</p>
			{if $incompleteLocaleFound}
				<span class="formError">*</span>&nbsp;{translate key="admin.locale.maybeIncomplete"}
			{/if}{* $incompleteLocaleFound *}
		</td>
	</div>

	<div class="buttons">
		<input type="submit" value="{translate key="common.save"}" class="button" />
		<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url page="admin" escape=false}'" />
	</div>
	</div>
</form>

<form method="post" action="{url op="installLocale"}">
	<div id="installLanguages">
		<h3>{translate key="admin.languages.installLanguages"}</h3>
		<h4>{translate key="admin.languages.installedLocales"}</h4>
		{foreach from=$installedLocales item=localeKey}
		<div class="form-row">
			<p class="label">{$localeNames.$localeKey|escape} ({$localeKey|escape})</p>
			<div class="options">
				<a href="{url op="reloadLocale" locale=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="admin.languages.confirmReload"}')" class="action">{translate key="admin.languages.reload"}</a>
				&nbsp;|&nbsp;<a href="{url op="reloadDefaultEmailTemplates" locale=$localeKey}" class="action">{translate key="admin.languages.reloadDefaultEmailTemplates"}</a>
				{if $localeKey != $primaryLocale}
					&nbsp;|&nbsp;<a href="{url op="uninstallLocale" locale=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="admin.languages.confirmUninstall"}')" class="action">{translate key="admin.languages.uninstall"}</a>
				{/if}
			</div>
		</div>
		{/foreach}
	</div>
<div id="installNewLocales">
	<h4>{translate key="admin.languages.installNewLocales"}</h4>
	<p>
		{translate key="admin.languages.installNewLocalesInstructions"}
	</p>
	{assign var=incompleteLocaleFound value=0}
	<ul class="form-subrow">
	{foreach from=$uninstalledLocales item=localeKey}
		<li>
			<input type="checkbox" name="installLocale[]" id="installLocale-{$localeKey|escape}" value="{$localeKey|escape}" />&nbsp;<label for="installLocale-{$localeKey|escape}">{$localeNames.$localeKey|escape} ({$localeKey|escape})</label>
			{if !$localesComplete[$localeKey]}
				<span class="form-error">*</span>
				{assign var=incompleteLocaleFound value=1}
			{/if}
		</li>
	{foreachelse}
		<li>
		{assign var="noLocalesToInstall" value="1"}
		<span class="nodata">{translate key="admin.languages.noLocalesAvailable"}</span>
		</li>
	{/foreach}
	</ul>
	{if $incompleteLocaleFound}
		<p class="instruct instruct--spaced">* {translate key="admin.locale.maybeIncomplete"}</p>
	{/if}{* $incompleteLocaleFound *}

	{if not $noLocalesToInstall}
	<p class="buttons">
		<input type="submit" value="{translate key="admin.languages.installLocales"}" class="button" />
		<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url page="admin" escape=false}'" />
	</p>
	{/if}
</div>
</form>

<div id="downloadLocales">
<h3>{translate key="admin.languages.downloadLocales"}</h3>

{if $downloadAvailable}

<table class="data" width="100%">
	{foreach from=$downloadableLocales item=downloadableLocale}
		<tr valign="top">
			<td width="30%">&bull;&nbsp;{$downloadableLocale.name|escape} ({$downloadableLocale.key})</td>
			<td width="70%">
				<a href="{url op="downloadLocale" locale=$downloadableLocale.key}" class="action">{translate key="admin.languages.download"}</a>
			</td>
		</tr>
	{foreachelse}
		<tr valign="top">
			<td colspan="4" class="nodata">{translate key="common.none"}</td>
		</tr>
	{/foreach}
</table>
{else}{* not $downloadAvailable *}
	{translate key="admin.languages.downloadUnavailable"}
{/if}{* $downloadAvailable *}
</div>
{include file="common/footer.tpl"}

