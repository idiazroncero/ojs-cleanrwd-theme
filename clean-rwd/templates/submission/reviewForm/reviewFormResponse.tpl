{**
 * templates/submission/reviewForm/reviewFormResponse.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Review Form to enter responses/comments/answers.
 *
 *}
{strip}
{if $editorPreview}
	{include file="common/header.tpl"}
{else}
	{translate|assign:"pageTitleTranslated" key="submission.reviewFormResponse"}
	{assign var="pageCrumbTitle" value="submission.reviewFormResponse"}
	{include file="common/header.tpl"}
	{include file="common/formErrors.tpl"}
{/if}
{/strip}

{assign var=disabled value=0}
{if $isLocked || $editorPreview}
	{assign var=disabled value=1}
{/if}
<section id="reviewFormResponse">
<h3>{$reviewForm->getLocalizedTitle()}</h3>
<p>{$reviewForm->getLocalizedDescription()}</p>

<form id="saveReviewFormResponse" method="post" action="{url op="saveReviewFormResponse" path=$reviewId|to_array:$reviewForm->getId()}">
	{foreach from=$reviewFormElements name=reviewFormElements key=elementId item=reviewFormElement}
	<div class="form-row">
		<div class="form-group">{$reviewFormElement->getLocalizedQuestion()} {if $reviewFormElement->getRequired() == 1}<span>*</span>{/if}</div>
			{if $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_SMALL_TEXT_FIELD}
				<input {if $disabled}onkeypress="return ((event.keyCode >= 37 && event.keyCode <= 40) || event.charCode == 99);" {/if}type="text" name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" value="{$reviewFormResponses[$elementId]|escape}" size="10" maxlength="40" class="textField" />
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXT_FIELD}
				<input {if $disabled}onkeypress="return ((event.keyCode >= 37 && event.keyCode <= 40) || event.charCode == 99);" {/if}type="text" name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" value="{$reviewFormResponses[$elementId]|escape}" size="40" maxlength="120" class="textField" />
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXTAREA}
				<textarea {if $disabled}onkeypress="return ((event.keyCode >= 37 && event.keyCode <= 40) || event.charCode == 99);" {/if}name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" rows="4" cols="40" class="textArea">{$reviewFormResponses[$elementId]|escape}</textarea>
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES}
				{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
				<div class="form-subrow">
				{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
						<div class="form-group">
							<input {if $disabled}disabled="disabled" {/if}type="checkbox" name="reviewFormResponses[{$elementId}][]" id="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}" value="{$smarty.foreach.responses.iteration}"{if !empty($reviewFormResponses[$elementId]) && in_array($smarty.foreach.responses.iteration, $reviewFormResponses[$elementId])} checked="checked"{/if} /><label for="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}">{$responseItem.content}</label>
						</div>
				{/foreach}
				</div>
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS}
				{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
				<div class="form-subrow">
				{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
						<div class="form-group">
					<input {if $disabled}disabled="disabled" {/if}type="radio"  name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}" value="{$smarty.foreach.responses.iteration}"{if $smarty.foreach.responses.iteration == $reviewFormResponses[$elementId]} checked="checked"{/if}/><label for="reviewFormResponses-{$elementId}-{$smarty.foreach.responses.iteration}">{$responseItem.content}</label>
				</div>
				{/foreach}
				</div>
			{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_DROP_DOWN_BOX}
				<select {if $disabled}disabled="disabled" {/if}name="reviewFormResponses[{$elementId}]" id="reviewFormResponses-{$elementId}" size="1" class="selectMenu">
					<option label="" value=""></option>
					{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
					{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
						<option label="{$responseItem.content}" value="{$smarty.foreach.responses.iteration}"{if $smarty.foreach.responses.iteration == $reviewFormResponses[$elementId]} selected="selected"{/if}>{$responseItem.content}</option>
					{/foreach}
				</select>
			{/if}
		</div>
	{/foreach}

	

<div class="buttons">{if $editorPreview}
		<input type="button" value="{translate key="common.close"}" class="button defaultButton" onclick="window.close()" />
	{else}
		<input {if $disabled}disabled="disabled" {/if}type="submit" name="save" value="{translate key="common.save"}" class="button defaultButton" /> <input type="button" value="{translate key="common.close"}" class="button button--cancel" onclick="document.location.href='{url op="submission" path=$reviewId}'" />
	{/if}</div>

	<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>
</section>

{include file="common/footer.tpl"}

