{**
 * templates/manager/announcement/announcementTypeForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement type form under management.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="$announcementTypeTitle"}
{if $typeId}
	{assign var="pageTitle" value="manager.announcementTypes.edit"}
{else}
	{assign var="pageTitle" value="manager.announcementTypes.create"}
{/if}
{assign var="pageId" value="manager.announcementTypes.announcementTypeForm"}
{include file="common/header.tpl"}
{/strip}

<section class="section" id="announcementType">
<form id="announcementTypeForm" method="post" action="{url op="updateAnnouncementType"}">
{if $typeId}
<input type="hidden" name="typeId" value="{$typeId|escape}" />
{/if}

{include file="common/formErrors.tpl"}


{if count($formLocales) > 1}
	<div class="form-row">
		<p class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</p>

			{if $typeId}{url|assign:"announcementTypeUrl" op="editAnnouncementType" path=$typeId escape=false}
			{else}{url|assign:"announcementTypeUrl" op="createAnnouncementType" escape=false}
			{/if}
			{form_language_chooser form="announcementTypeForm" url=$announcementTypeUrl}
			<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
{/if}
<div class="form-row">
	<p class="label">{fieldLabel name="name" required="true" key="manager.announcementTypes.form.typeName"}</p>
	<input type="text" name="name[{$formLocale|escape}]" value="{$name[$formLocale]|escape}" size="40" id="name" maxlength="80" class="textField" />
</div>


<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" /> {if not $typeId}
	<input type="submit" name="createAnother" value="{translate key="manager.announcementTypes.form.saveAndCreateAnother"}" class="button" /> {/if}
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="announcementTypes" escape=false}'" />
</div>

</form>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>

</section>

{include file="common/footer.tpl"}

