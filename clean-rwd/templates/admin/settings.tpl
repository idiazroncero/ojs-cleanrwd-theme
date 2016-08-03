{**
 * templates/admin/settings.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site settings form.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.siteSettings"}
{include file="common/header.tpl"}
{/strip}

<form id="settings" class="settings-form" method="post" action="{url op="saveSettings"}" enctype="multipart/form-data">
{include file="common/formErrors.tpl"}
<p class="form-required">{translate key="common.requiredField"}</span></p>
	
	<div class="form-row">
		{if count($formLocales) > 1}
				{fieldLabel name="formLocale" key="form.formLanguage"}
					{url|assign:"settingsUrl" op="settings" escape=false}
					{form_language_chooser form="settings" url=$settingsUrl}
					<span class="instruct">{translate key="form.formLanguage.description"}</span>
		{/if}
	</div>
	<div class="form-row">
		{fieldLabel name="title" key="admin.settings.siteTitle" required="true"}
		<div class="form-subrow">
			<div class="form-group">
				<input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-0" value="0"{if not $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-0" key="manager.setup.useTextTitle"}
				<input type="text" id="title" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="40" maxlength="120" class="textField" />
			</div>
			<div class="form-group">
				<input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-1" value="1"{if $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-1" key="manager.setup.useImageTitle"}
				<input type="file" name="pageHeaderTitleImage" id="pageHeaderTitleImage" class="uploadField" /> <input type="submit" name="uploadPageHeaderTitleImage" value="{translate key="common.upload"}" class="button button--small" />
			</div>
			<div class="form-subrow">
				{if $pageHeaderTitleType[$formLocale] && $pageHeaderTitleImage[$formLocale]}
					<img src="{$publicFilesDir}/{$pageHeaderTitleImage[$formLocale].uploadName|escape:"url"}" width="{$pageHeaderTitleImage[$formLocale].width|escape}" height="{$pageHeaderTitleImage[$formLocale].height|escape}" alt="{translate key="admin.settings.homeHeaderImage.altText"}" />
					<div class="form-group">
						{if $pageHeaderTitleType[$formLocale] && $pageHeaderTitleImage[$formLocale]}
							{fieldLabel name="pageHeaderTitleImageAltText" key="common.altText"}
							<input type="text" id="pageHeaderTitleImageAltText" name="pageHeaderTitleImageAltText[{$formLocale|escape}]" value="{$pageHeaderTitleImage[$formLocale].altText|escape}" maxlength="255" class="textField" />
							<p class="instruct">{translate key="common.altTextInstructions"}</p>
						{/if}
					</div>
					<div class="form-group">
						<span class="instruct">{translate key="common.fileName"}: {$pageHeaderTitleImage[$formLocale].originalFilename|escape} {$pageHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort}</span>
						<input type="submit" name="deletePageHeaderTitleImage" value="{translate key="common.delete"}" class="button button--small" />
					</div>
				{/if}
			</div>
		</div>
	</div>

	<div class="form-row">
		{fieldLabel name="intro" key="admin.settings.introduction"}
		<textarea name="intro[{$formLocale|escape}]" id="intro" class="textarea">{$intro[$formLocale]|escape}</textarea>
	</div>

	<div class="form-row">
		{fieldLabel name="redirect" key="admin.settings.journalRedirect"}
		<select name="redirect" id="redirect" class="select-menu">
			<option value="">{translate key="admin.settings.noJournalRedirect"}</option>
				{html_options options=$redirectOptions selected=$redirect}
		</select>
		<p class="instruct">{translate key="admin.settings.journalRedirectInstructions"}</p>
	</div>

	<div class="form-row">
		{fieldLabel name="aboutField" key="admin.settings.aboutDescription"}
		<textarea name="about[{$formLocale|escape}]" id="aboutField" class="textarea">{$about[$formLocale]|escape}</textarea>
	</div>
	<div class="form-row">
		{fieldLabel name="contactName" key="admin.settings.contactName" required="true"}
		<input type="text" id="contactName" name="contactName[{$formLocale|escape}]" value="{$contactName[$formLocale]|escape}" size="40" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="contactEmail" key="admin.settings.contactEmail" required="true"}
		<input type="text" id="contactEmail" name="contactEmail[{$formLocale|escape}]" value="{$contactEmail[$formLocale]|escape}" size="40" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="minPasswordLength" key="admin.settings.minPasswordLength" required="true"}
		<input type="text" id="minPasswordLength" name="minPasswordLength" value="{$minPasswordLength|escape}" size="4" maxlength="2" class="textField" /> {translate key="admin.settings.passwordCharacters"}
	</div>
	<div class="form-row">
		{fieldLabel name="oneStepReset" key="admin.settings.oneStepReset" class="label--inline"}
		<input type="checkbox" id="oneStepReset" name="oneStepReset" {if $oneStepReset}checked="checked" {/if}/>
	</div>
	<div class="form-row">
		<label for="siteTheme">{translate key="admin.settings.siteTheme"}</label>
		<select name="siteTheme" class="selectMenu" id="siteTheme"{if empty($themes)} disabled="disabled"{/if}>
				<option value="">{translate key="common.none"}</option>
				{foreach from=$themes key=path item=themePlugin}
					<option value="{$path|escape}"{if $path == $siteTheme} selected="selected"{/if}>{$themePlugin->getDisplayName()|escape}</option>
				{/foreach}
			</select>
	</div>
	<div class="form-row">
		<label for="siteStyleSheet">{translate key="admin.settings.siteStyleSheet"}</label>
		<input type="file" name="siteStyleSheet" class="uploadField" id="siteStyleSheet" /> <input type="submit" name="uploadSiteStyleSheet" value="{translate key="common.upload"}" class="button" />
		{if $siteStyleFileExists}
			{translate key="common.fileName"}: <a href="{$publicFilesDir}/{$styleFilename}" class="file">{$originalStyleFilename|escape}</a> {$dateStyleFileUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteSiteStyleSheet" value="{translate key="common.delete"}" class="button" />
		{/if}
	</div>
	<div class="form-row">
		<label>{translate key="admin.settings.options"}</label>
		<div class="form-subrow">
			<div class="form-group">
				<input type="checkbox" id="useAlphalist" name="useAlphalist" {if $useAlphalist}checked="checked" {/if}/>
				{fieldLabel name="useAlphalist" key="admin.settings.useAlphalist"}
			</div>
			<div class="form-group">
				<input type="checkbox" id="usePaging" name="usePaging" {if $usePaging}checked="checked" {/if}/>
				{fieldLabel name="usePaging" key="admin.settings.usePaging"}
			</div>
		</div>
	</div>
	<div class="form-row">
		<label>{translate key="admin.settings.journalsList"}</label>
		<div class="form-subrow">
			<p class="instruct">{translate key="admin.settings.journalsList.description"}</p>
			<div class="form-group">
				<input type="checkbox" name="showThumbnail" id="showThumbnail" value="1"{if $showThumbnail} checked="checked"{/if} />
				{fieldLabel name="showThumbnail" key="admin.settings.journalsList.showThumbnail"}
			</div>
			<div class="form-group">
				<input type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} />
				{fieldLabel name="showTitle" key="admin.settings.journalsList.showTitle"}
			</div>
			<div class="form-group">
				<input type="checkbox" name="showDescription" id="showDescription" value="1"{if $showDescription} checked="checked"{/if} />
				{fieldLabel name="showDescription" key="admin.settings.journalsList.showDescription"}
			</div>
		</div>
	</div>
	<div class="form-row">
		<label>{translate key="admin.settings.security"}</label>
		<div class="form-subrow">
			<input type="checkbox" name="preventManagerPluginManagement" id="preventManagerPluginManagement" value="1"{if $preventManagerPluginManagement} checked="checked"{/if} />
			{fieldLabel name="preventManagerPluginManagement" key="admin.settings.security.plugins" }
		</div>
	</div>

	<div id="oaiRegistration">
		<h4>{translate key="admin.settings.oaiRegistration"}</h4>	

		{url|assign:"oaiUrl" page="oai"}
		{url|assign:"siteUrl" page="index"}
		<p>{translate key="admin.settings.oaiRegistrationDescription" siteUrl=$siteUrl oaiUrl=$oaiUrl}</p>
	</div>

{if count($availableMetricTypes) > 2}
	<div id="defaultMetricSelection">
		<h4>{translate key="defaultMetric.title"}</h4>
		<p>{translate key="admin.settings.defaultMetricDescription"}</p>
		<table class="data" width="100%">
			<div class="form-row">
				<td width="20%" class="label">{fieldLabel name="defaultMetricType" key="defaultMetric.availableMetrics"}</td>
				<td colspan="2" width="80%" class="value">
					<select name="defaultMetricType" class="selectMenu" id="defaultMetricType">
						{foreach from=$availableMetricTypes key=metricType item=displayName}
							<option value="{$metricType|escape}"{if $metricType == $defaultMetricType} selected="selected"{/if}>{$displayName|escape}</option>
						{/foreach}
					</select>
				</td>
			</div>
		</table>
	</div>
{/if}

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url page="admin" escape=false}'" />
</div>

</form>

{include file="common/footer.tpl"}

