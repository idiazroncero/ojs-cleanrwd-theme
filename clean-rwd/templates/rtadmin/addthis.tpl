{**
 * temlates/rtadmin/addthis.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RT Administration settings.
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.sharing"}
{include file="common/header.tpl"}
{/strip}

<form method="post" action='{url op="saveSharingSettings"}'>

<p>{translate key="rt.admin.sharing.description"}</p>

<h3>{translate key="rt.admin.sharing.basic"}</h3>

	<div class="form-row">
		<div class="form-group">
			<input type="checkbox" name="sharingEnabled" id="sharingEnabled" {if isset($sharingEnabled) && $sharingEnabled} checked="checked" {/if} /><label class="label--inline" for="sharingEnabled">{translate key="rt.admin.sharing.enabled"}</label>
		</div>
		<div class="form-subrow">
			<div class="form-group">
				<label for="sharingUserName">{translate key="rt.admin.sharing.userNameLabel"}</label>
				<input type="text" name="sharingUserName" id="sharingUserName" value="{$sharingUserName|escape}"/>
			</div>
			
			<div class="form-group">
				<label for="sharingButtonStyle">{translate key="rt.admin.sharing.buttonStyleLabel"}</label>
				{html_options name="sharingButtonStyle" id="sharingButtonStyle" values=$sharingButtonStyleOptions|@array_values output=$sharingButtonStyleOptions|@array_values selected=$sharingButtonStyle}
			</div>

			<div class="form-group">
				<input type="checkbox" name="sharingDropDownMenu" id="sharingDropDownMenu" {if isset($sharingDropDownMenu) && $sharingDropDownMenu} checked="checked" {/if} /> <label for="sharingDropDownMenu">{translate key="rt.admin.sharing.dropDownMenuLabel"}</label>
			</div>
		</div>
	</div>




<h3>{translate key="rt.admin.sharing.advanced"}</h3>
<p>{translate key="rt.admin.sharing.customizationLink"}</p>

	<div class="form-row">
		<label for="sharingBrand">{translate key="rt.admin.sharing.brandLabel"}</label>
		<input type="text" name="sharingBrand" id="sharingBrand" value="{$sharingBrand|escape}"/>
	</div>
	<div class="form-row">
		<label for="sharingDropDown">{translate key="rt.admin.sharing.dropDownLabel"}</label>
		<textarea rows="4" cols="20" name="sharingDropDown" id="sharingDropDown">{$sharingDropDown|escape}</textarea>
	</div>
	<div class="form-row">
		<label for="sharingLanguage">{translate key="rt.admin.sharing.languageLabel"}</label>
		{html_options name="sharingLanguage" id="sharingLanguage" options="$sharingLanguageOptions" selected=$sharingLanguage}
	</div>
	<div class="form-row">
		<label for="sharingLogo">{translate key="rt.admin.sharing.logolabel"}</label>
		<input type="text" name="sharingLogo" id="sharingLogo" value="{$sharingLogo}" />
	</div>
	<div class="form-row">
		<label for="sharingLogoBackground">{translate key="rt.admin.sharing.logoBackgroundLabel"}</label>
		<input type="text" name="sharingLogoBackground" id="sharingLogoBackground" value="{$sharingLogoBackground|escape}"/>
	</div>
	<div class="form-row">
		<label for="sharingLogoColor">{translate key="rt.admin.sharing.logoColorLabel"}</label>
		<input type="text" name="sharingLogoColor" id="sharingLogoColor" value="{$sharingLogoColor|escape}"/>
	</div>


<div class="buttons">
	<input type="submit" value='{translate key="common.save"}' class="button defaultButton" />
	<input type="button" value='{translate key="common.cancel"}' class="button" onclick="document.location.href='{url page=rtadmin escape=false}'" />
</div>

</form>

{include file="common/footer.tpl"}

