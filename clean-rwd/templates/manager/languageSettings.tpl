{**
 * templates/manager/languageSettings.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to edit journal language settings.
 *
 *}
{strip}
{assign var="pageTitle" value="common.languages"}
{include file="common/header.tpl"}
{/strip}

<p>{translate key="manager.languages.languageInstructions"}</p>

{include file="common/formErrors.tpl"}

{if count($availableLocales) > 1}
<form method="post" action="{url op="saveLanguageSettings"}">

<div class="form-row">
	<label for="primaryLocale">{translate key="locale.primary"}
	<span class="instruct">{translate key="manager.languages.primaryLocaleInstructions"}</span></label>
	<select id="primaryLocale" name="primaryLocale" size="1" class="selectMenu">
		{html_options options=$availableLocales selected=$primaryLocale}
	</select>
</div>

<div class="form-row">
<p class="label">{translate key="locale.supported"}</p>
<table class="listing" id="">
	<thead>
		<tr >
			<th>&nbsp;</th>
			<th class="center">{translate key="manager.language.ui"}</th>
			<th class="center">{translate key="manager.language.submissions"}</th>
			<th class="center">{translate key="manager.language.forms"}</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		{foreach from=$availableLocales key=localeKey item=localeName}
			<tr>
				<td>{$localeName|escape}</td>
				<td data-title='{translate key="manager.language.ui"}' class="center"><input type="checkbox" name="supportedLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedLocales)} checked="checked"{/if}/></td>
				<td data-title='{translate key="manager.language.submissions"}' class="center"><input type="checkbox" name="supportedSubmissionLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedSubmissionLocales)} checked="checked"{/if}/></td>
				<td data-title='{translate key="manager.language.forms"}' class="center"><input type="checkbox" name="supportedFormLocales[]" value="{$localeKey|escape}"{if in_array($localeKey, $supportedFormLocales)} checked="checked"{/if}/></td>
				<td><a href="{url op="reloadLocalizedDefaultSettings" localeToLoad=$localeKey}" onclick="return confirm('{translate|escape:"jsparam" key="manager.language.confirmDefaultSettingsOverwrite"}')" class="action">{translate key="manager.language.reloadLocalizedDefaultSettings"}</a></td>
			</tr>
		{/foreach}
	</tbody>
</table>

<p class="instruct">{translate key="manager.languages.supportedLocalesInstructions"}</p>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{else}
<p><span class="instruct instruct--spaced">{translate key="manager.languages.noneAvailable"}</span></p>
{/if}

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url page="manager"}'" />
</div>

{include file="common/footer.tpl"}

