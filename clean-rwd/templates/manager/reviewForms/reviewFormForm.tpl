{**
 * templates/manager/reviewForms/reviewFormForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to create/modify a review form.
 *
 *}
{strip}
{include file="common/header.tpl"}
{/strip}

{if $reviewFormId}
	<ul class="menu">
		<li class="current"><a href="{url op="editReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.edit"}</a></li>
		<li><a href="{url op="reviewFormElements" path=$reviewFormId}">{translate key="manager.reviewFormElements"}</a></li>
		<li><a href="{url op="previewReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.preview"}</a></li>
	</ul>
{/if}



<form id="reviewFormForm" method="post" action="{url op="updateReviewForm"}">
{if $reviewFormId}
	<input type="hidden" name="reviewFormId" value="{$reviewFormId}"/>
{/if}

{include file="common/formErrors.tpl"}


{if count($formLocales) > 1}
<div class="form-row">
	{fieldLabel name="formLocale" key="form.formLanguage"}
	{if $reviewFormId}{url|assign:"reviewFormFormUrl" op="editReviewForm" path=$reviewFormId escape=false}
	{else}{url|assign:"reviewFormFormUrl" op="createReviewForm" escape=false}
	{/if}
	{form_language_chooser form="reviewFormForm" url=$reviewFormFormUrl}
	<p class="instruct">{translate key="form.formLanguage.description"}</p>
</div>
{/if}

<div class="form-row">
	{fieldLabel name="title" required="true" key="manager.reviewForms.title"}
	<input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" id="title" size="40" maxlength="120" class="textField" />
</div>
<div class="form-row">
	{fieldLabel name="description" key="manager.reviewForms.description"}
	<textarea name="description[{$formLocale|escape}]" rows="4" cols="40" id="description" class="textArea">{$description[$formLocale]|escape}</textarea>
</div>


<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="reviewForms" escape=false}'" />
</div>
</form>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}

