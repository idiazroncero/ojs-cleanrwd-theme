{**
 * templates/manager/announcement/announcementForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement form under management.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="$announcementTitle"}
{if $announcementId}
	{assign var="pageTitle" value="manager.announcements.edit"}
{else}
	{assign var="pageTitle" value="manager.announcements.create"}
{/if}
{assign var="pageId" value="manager.announcement.announcementForm"}
{include file="common/header.tpl"}
{/strip}

<section id="announcement">
<form id="announcementForm" method="post" action="{url op="updateAnnouncement"}">
{if $announcementId}
<input type="hidden" name="announcementId" value="{$announcementId|escape}" />
{/if}

{include file="common/formErrors.tpl"}


{if count($formLocales) > 1}
	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
			{if $typeId}{url|assign:"announcementUrl" op="editAnnouncement" path=$announcementId escape=false}
			{else}{url|assign:"announcementUrl" op="createAnnouncement" escape=false}
			{/if}
			{form_language_chooser form="announcementForm" url=$announcementUrl}
			<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
{/if}

{if $announcementTypes->getCount() != 0}
<div class="form-row">
	{fieldLabel name="typeId" key="manager.announcements.form.typeId"}
	<select name="typeId" id="typeId" class="selectMenu">
		<option value=""></option>
		{iterate from=announcementTypes item=announcementType}
		<option value="{$announcementType->getId()}"{if $typeId == $announcementType->getId()} selected="selected"{/if}>{$announcementType->getLocalizedTypeName()|escape}</option>
		{/iterate}
	</select>
</div>
{/if}{* $announcementTypes->getCount() != 0 *}

<div class="form-row">
	{fieldLabel name="title" required="true" key="manager.announcements.form.title"}
	<input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="40" id="title" maxlength="255" class="textField" />
</div>

<div class="form-row">
	{fieldLabel name="descriptionShort" required="true" key="manager.announcements.form.descriptionShort"}
	<textarea name="descriptionShort[{$formLocale|escape}]" id="descriptionShort" cols="40" rows="6" class="textArea richContent">{$descriptionShort[$formLocale]|escape}</textarea>
	<p class="instruct">{translate key="manager.announcements.form.descriptionShortInstructions"}</p>
</div>

<div class="form-row">
	{fieldLabel name="description" key="manager.announcements.form.description"}
	<textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="6" class="textArea richContent">{$description[$formLocale]|escape}</textarea>
	<p class="instruct">{translate key="manager.announcements.form.descriptionInstructions"}</p>
</div>

<div class="form-row">
	{fieldLabel name="datePosted" key="manager.announcements.datePublish"}
	{html_select_date prefix="datePosted" all_extra="class=\"selectMenu\"" end_year="$yearOffsetFuture" year_empty="" month_empty="" day_empty="" time="$datePosted"}
</div>

<div class="form-row">
	{fieldLabel name="dateExpire" key="manager.announcements.form.dateExpire"}
		{if $dateExpire != null}
			{html_select_date prefix="dateExpire" all_extra="class=\"selectMenu\"" end_year="$yearOffsetFuture" year_empty="" month_empty="" day_empty="" time="$dateExpire"}
		{else}
			{html_select_date prefix="dateExpire" all_extra="class=\"selectMenu\"" end_year="$yearOffsetFuture" year_empty="" month_empty="" day_empty="" time="-00-00"}
		{/if}
		<input type="hidden" name="dateExpireHour" value="23" />
		<input type="hidden" name="dateExpireMinute" value="59" />
		<input type="hidden" name="dateExpireSecond" value="59" />
		<p class="instruct">{translate key="manager.announcements.form.dateExpireInstructions"}</p>
</div>

<div class="form-row">
	{fieldLabel name="notificationToggle" key="manager.announcements.form.notificationToggle"}
	<input type="checkbox" name="notificationToggle" id="notificationToggle" value="1" {if $notificationToggle} checked="checked"{/if} />
	&nbsp;{translate key="manager.announcements.form.notificationToggleInstructions"}
</div>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	{if not $announcementId}<input type="submit" name="createAnother" value="{translate key="manager.announcements.form.saveAndCreateAnother"}" class="button" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="announcements" escape=false}'" />
</div>

</form>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</section>

{include file="common/footer.tpl"}

