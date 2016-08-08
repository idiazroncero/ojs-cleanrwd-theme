{**
 * templates/manager/reviewForms/reviewFormElementForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to create/modify a review form element.
 *
 *}
{strip}
{assign var="pageId" value="manager.reviewFormElements.reviewFormElementForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function togglePossibleResponses(newValue, multipleResponsesElementTypesString) {
	if (multipleResponsesElementTypesString.indexOf(';'+newValue+';') != -1) {
		document.getElementById('reviewFormElementForm').addResponse.disabled=false;
	} else {
		if (document.getElementById('reviewFormElementForm').addResponse.disabled == false) {
			alert({/literal}'{translate|escape:"jsparam" key="manager.reviewFormElement.changeType"}'{literal});
		}
		document.getElementById('reviewFormElementForm').addResponse.disabled=true;
	}
}
// -->
{/literal}
</script>


<form id="reviewFormElementForm" method="post" action="{url op="updateReviewFormElement" anchor="possibleResponses"}">
	<input type="hidden" name="reviewFormId" value="{$reviewFormId}"/>
	<input type="hidden" name="reviewFormElementId" value="{$reviewFormElementId}"/>

{include file="common/formErrors.tpl"}


{if count($formLocales) > 1}
	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
			{if $reviewFormElementId}{url|assign:"reviewFormElementFormUrl" op="editReviewFormElement" path=$reviewFormId|to_array:$reviewFormElementId escape=false}
			{else}{url|assign:"reviewFormElementFormUrl" op="createReviewFormElement" path=$reviewFormId escape=false}
			{/if}
			{form_language_chooser form="reviewFormElementForm" url=$reviewFormElementFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
	</div>
{/if}
<div class="form-row">
	{fieldLabel name="question" required="true" key="manager.reviewFormElements.question"}
	<textarea name="question[{$formLocale|escape}]" rows="4" cols="40" id="question" class="textArea">{$question[$formLocale]|escape}</textarea>
</div>
<div class="form-row">
	<input type="checkbox" name="required" id="required" value="1" {if $required}checked="checked"{/if} />
	{fieldLabel name="required" class="label--inline" key="manager.reviewFormElements.required"}
</div>
<div class="form-row">
	<input type="checkbox" name="included" id="included" value="1" {if $included}checked="checked"{/if} />
	{fieldLabel name="included" class="label--inline" key="manager.reviewFormElements.included"}
</div>
<div class="form-row">
	{fieldLabel name="elementType" required="true" key="manager.reviewFormElements.elementType"}
	<select name="elementType" id="elementType" class="selectMenu" size="1" onchange="togglePossibleResponses(this.options[this.selectedIndex].value, '{$multipleResponsesElementTypesString}')">{html_options_translate options=$reviewFormElementTypeOptions selected=$elementType}</select>
</div>
<div class="form-row">
		<a name="possibleResponses"></a>
		{foreach name=responses from=$possibleResponses[$formLocale] key=responseId item=responseItem}
			{if !$notFirstResponseItem}
				{assign var=notFirstResponseItem value=1}
				<table class="listing">
				<thead >
					<th>{translate key="common.order"}</th>
					<th>{translate key="manager.reviewFormElements.possibleResponse"}</th>
					<th>&nbsp;</th>
				</thead>
				<tbody>
			{/if}
				<tr >
					<td><input type="text" name="possibleResponses[{$formLocale|escape}][{$responseId|escape}][order]" value="{$responseItem.order|escape}" size="3" maxlength="2" class="textField" /></td>
					<td><textarea name="possibleResponses[{$formLocale|escape}][{$responseId|escape}][content]" id="possibleResponses-{$responseId}" rows="3" cols="40" class="textArea">{$responseItem.content|escape}</textarea></td>
					<td><input type="submit" name="delResponse[{$responseId}]" value="{translate key="common.delete"}" class="button button--small" /></td>
				</tr>
		{/foreach}
		</tbody>

		{if $notFirstResponseItem}
				</table>
		{/if}
		
		<input type="submit" name="addResponse" value="{translate key="manager.reviewFormElements.addResponseItem"}" class="button" {if not in_array($elementType, $multipleResponsesElementTypes)}disabled="disabled"{/if}/>
</div>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="reviewFormElements" path=$reviewFormId escape=false}'" />
</div>
</form>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

{include file="common/footer.tpl"}

