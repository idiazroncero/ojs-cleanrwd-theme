{**
 * templates/manager/reviewForms/previewReviewForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Preview of a review form.
 *
 *}
{strip}
{assign var="pageId" value="manager.reviewFormElements.previewReviewForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}

{assign var=reviewFormId value=$reviewForm->getId()}
{if $completeCounts[$reviewFormId]==0 && $incompleteCounts[$reviewFormId]==0}
	{assign var=canEdit value=1}
{else}
	{assign var=canEdit value=0}
{/if}

{if $canEdit}
	<ul class="menu">
		<li><a href="{url op="editReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.edit"}</a></li>
		<li><a href="{url op="reviewFormElements" path=$reviewFormId}">{translate key="manager.reviewFormElements"}</a></li>
		<li class="current"><a href="{url op="previewReviewForm" path=$reviewFormId}">{translate key="manager.reviewForms.preview"}</a></li>
	</ul>
{/if}



<h3>{$reviewForm->getLocalizedTitle()}</h3>
<p>{$reviewForm->getLocalizedDescription()}</p>

{foreach from=$reviewFormElements name=reviewFormElements item=reviewFormElement}
<div class="form-row">
	<div class="form-group">{$reviewFormElement->getLocalizedQuestion()}{if $reviewFormElement->getRequired()}*{/if}</div>
	<div class="form-subrow">
		{if $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_SMALL_TEXT_FIELD}
			<div class="form-group">
				<input type="text" size="10" maxlength="40" class="textField" />
			</div>
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXT_FIELD}
			<div class="form-group">
				<input type="text" size="40" maxlength="120" class="textField" />
			</div>
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_TEXTAREA}
			<div class="form-group">
				<textarea rows="4" cols="40" class="textArea"></textarea>
			</div>
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_CHECKBOXES}
			{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
			{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
			<div class="form-group">
				<input id="check-{$responseId|escape}" type="checkbox"/>
				<label for="check-{$responseId|escape}">{$responseItem.content}</label>
			</div>
			{/foreach}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_RADIO_BUTTONS}
			{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
			{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
			<div class="form-group">
				<input id="radio-{$responseId|escape}" name="{$reviewFormElement->getId()}" type="radio"/>
				<label for="radio-{$responseId|escape}">{$responseItem.content}</label>
			</div>
			{/foreach}
		{elseif $reviewFormElement->getElementType() == REVIEW_FORM_ELEMENT_TYPE_DROP_DOWN_BOX}
			<div class="form-group">
			<select size="1" class="selectMenu">
				{assign var=possibleResponses value=$reviewFormElement->getLocalizedPossibleResponses()}
				{foreach name=responses from=$possibleResponses key=responseId item=responseItem}
					<option>{$responseItem.content}</option>
				{/foreach}
			</select>
			</div>
		{/if}
	</div>
</div>
{/foreach}



<form id="previewReviewForm" method="post" action="{if !$canEdit}{url op="reviewForms"}{else}{url op="editReviewForm" path=$reviewFormId}{/if}">
	<div class="buttons">
		<input type="submit" value="{translate key="common.close"}" class="button defaultButton" />
	</div>
</form>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>
{include file="common/footer.tpl"}

