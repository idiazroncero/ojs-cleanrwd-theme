{**
 * templates/manager/sections/sectionForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to create/modify a journal section.
 *
 *}
{strip}
{assign var="pageTitle" value="section.section"}
{assign var="pageCrumbTitle" value="section.section"}
{include file="common/header.tpl"}
{/strip}

<form id="section" method="post" action="{url op="updateSection" path=$sectionId}" onsubmit="return checkEditorAssignments()">
<input type="hidden" name="editorAction" value="" />
<input type="hidden" name="userId" value="" />

{literal}
<script type="text/javascript">
<!--

function addSectionEditor(editorId) {
	var sectionForm = document.getElementById('section');
	sectionForm.editorAction.value = "addSectionEditor";
	sectionForm.userId.value = editorId;
	sectionForm.submit();
}

function removeSectionEditor(editorId) {
	var sectionForm = document.getElementById('section');
	sectionForm.editorAction.value = "removeSectionEditor";
	sectionForm.userId.value = editorId;
	sectionForm.submit();
}

function checkEditorAssignments() {
	var isOk = true;
	{/literal}
	{foreach from=$assignedEditors item=editorEntry}
	{assign var=editor value=$editorEntry.user}
	{literal}
		if (!document.getElementById('section').canReview{/literal}{$editor->getId()}{literal}.checked && !document.getElementById('section').canEdit{/literal}{$editor->getId()}{literal}.checked) {
			isOk = false;
		}
	{/literal}{/foreach}{literal}
	if (!isOk) {
		alert({/literal}'{translate|escape:"jsparam" key="manager.sections.form.mustAllowPermission"}'{literal});
		return false;
	}
	return true;
}

// -->
</script>
{/literal}

{include file="common/formErrors.tpl"}
<div id="sectionForm">
{if count($formLocales) > 1}
	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
			{if $sectionId}{url|assign:"sectionFormUrl" op="editSection" path=$sectionId escape=false}
			{else}{url|assign:"sectionFormUrl" op="createSection" path=$sectionId escape=false}
			{/if}
			{form_language_chooser form="section" url=$sectionFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
	</div>
{/if}
<div class="form-row">
	{fieldLabel name="title" required="true" key="section.title"}
	<input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" id="title" size="40" maxlength="120" class="textField" />
</div>
<div class="form-row">
	{fieldLabel name="abbrev" required="true" key="section.abbreviation"}
	<input type="text" name="abbrev[{$formLocale|escape}]" id="abbrev" value="{$abbrev[$formLocale]|escape}" size="20" maxlength="20" class="textField" />&nbsp;&nbsp;<span class="instruct">{translate key="section.abbreviation.example"}</span>
</div>
<div class="form-row">
	{fieldLabel name="policy" key="manager.sections.policy"}
	<textarea name="policy[{$formLocale|escape}]" rows="4" cols="40" id="policy" class="textArea">{$policy[$formLocale]|escape}</textarea>
</div>
<div class="form-row">
	{fieldLabel name="reviewFormId" key="submission.reviewForm"}
	<select name="reviewFormId" size="1" id="reviewFormId" class="selectMenu">
		<option value="">{translate key="manager.reviewForms.noneChosen"}</option>
			{html_options options=$reviewFormOptions selected=$reviewFormId}
	</select>
</div>

{call_hook name="Templates::Manager::Sections::SectionForm::AdditionalMetadata" sectionId=$sectionId}
<div class="form-row">
	<label>
		{translate key="submission.indexing"}
		<span class="instruct">{translate key="manager.section.submissionsToThisSection"}</span>
	</label>
	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="metaReviewed" id="metaReviewed" value="1" {if $metaReviewed}checked="checked"{/if} />
			{fieldLabel name="metaReviewed" key="manager.sections.submissionReview"}
		</div>
		<div class="form-group">
			<input type="checkbox" name="abstractsNotRequired" id="abstractsNotRequired" value="1" {if $abstractsNotRequired}checked="checked"{/if} />
			{fieldLabel name="abstractsNotRequired" key="manager.sections.abstractsNotRequired"}
		</div>
		<div class="form-group">
			<input type="checkbox" name="metaIndexed" id="metaIndexed" value="1" {if $metaIndexed}checked="checked"{/if} />
			{fieldLabel name="metaIndexed" key="manager.sections.submissionIndexing"}
		</div>
		<div class="form-group">
			{fieldLabel name="identifyType" key="manager.sections.identifyType"} <input type="text" name="identifyType[{$formLocale|escape}]" id="identifyType" value="{$identifyType[$formLocale]|escape}" size="20" maxlength="60" class="textField" />
			<span class="instruct">{translate key="manager.sections.identifyTypeExamples"}</span>
		</div>
		<div class="form-group">
			<input type="checkbox" name="editorRestriction" id="editorRestriction" value="1" {if $editorRestriction}checked="checked"{/if} />
			{fieldLabel name="editorRestriction" key="manager.sections.editorRestriction"}
		</div>
		<div class="form-group">
			{fieldLabel name="wordCount" key="manager.sections.wordCountInstructions"}&nbsp;&nbsp;<input type="text" name="wordCount" id="abbrev" value="{$wordCount}" size="10" maxlength="20" class="textField" />
		</div>
		<div class="form-group">
			{fieldLabel name="hideTitle" key="issue.toc" class="label--heading"}
			<div class="form-subrow">
				<div class="form-group">
					<input type="checkbox" name="hideTitle" id="hideTitle" value="1" {if $hideTitle}checked="checked"{/if} />
					{fieldLabel name="hideTitle" key="manager.sections.hideTocTitle"}
				</div>
				<div class="form-group">
					<input type="checkbox" name="hideAuthor" id="hideAuthor" value="1" {if $hideAuthor}checked="checked"{/if} />
					{fieldLabel name="hideAuthor" key="manager.sections.hideTocAuthor"}
				</div>
			</div>
		</div>
		<div class="form-group">
			{fieldLabel name="hideAbout" key="navigation.about" class="label--heading"}
			<div class="form-subrow">
				<div class="form-group">
					<input type="checkbox" name="hideAbout" id="hideAbout" value="1" {if $hideAbout}checked="checked"{/if} />
					{fieldLabel name="hideAbout" key="manager.sections.hideAbout"}
				</div>
			</div>
		</div>
		{if $commentsEnabled}
		<div class="form-group">
			<input type="checkbox" name="disableComments" id="disableComments" value="1" {if $disableComments}checked="checked"{/if} />
			{fieldLabel name="disableComments" key="manager.sections.disableComments"}
		</div>
		{/if}
	</div>
</div>
</table>
</div>

<div id="sectionEditors">
<h3>{translate key="user.role.sectionEditors"}</h3>
{url|assign:"sectionEditorsUrl" op="people" path="sectionEditors"|to_array}
<p class="instruct instruct--spaced">{translate key="manager.section.sectionEditorInstructions"}</p>
<h4>{translate key="manager.sections.unassigned"}</h4>

<table width="100%" class="listing" id="unassignedSectionEditors">
	<thead>
		<th>{translate key="user.username"}</th>
		<th>{translate key="user.name"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	<tbody>
	{foreach from=$unassignedEditors item=editor}
		<tr >
			<td>{$editor->getUsername()|escape}</td>
			<td>{$editor->getFullName()|escape}</td>
			<td>
				<a class="button button--small" href="javascript:addSectionEditor({$editor->getId()})">{translate key="common.add"}</a>
			</td>
		</tr>
	{foreachelse}
		<tr>
			<td colspan="3">{translate key="common.none"}</td>
		</tr>
	{/foreach}
	</tbody>
</table>
</div>

<div id="sectionsAssigned">
<h4>{translate key="manager.sections.assigned"}</h4>

<table width="100%" class="listing" id="assignedSectionEditors">
	<thead>
		<th>{translate key="user.username"}</th>
		<th>{translate key="user.name"}</th>
		<th>{translate key="submission.review"}</th>
		<th>{translate key="submission.editing"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	<tbody>
	{foreach from=$assignedEditors item=editorEntry}
		{assign var=editor value=$editorEntry.user}
		<input type="hidden" name="assignedEditorIds[]" value="{$editor->getId()|escape}" />
		<tr>
			<td>{$editor->getUsername()|escape}</td>
			<td>{$editor->getFullName()|escape}</td>
			<td><input type="checkbox" {if $editorEntry.canReview}checked="checked"{/if} name="canReview{$editor->getId()}" /></td>
			<td><input type="checkbox" {if $editorEntry.canEdit}checked="checked"{/if} name="canEdit{$editor->getId()}" /></td>
			<td>
				<a class="button button--small button--cancel" href="javascript:removeSectionEditor({$editor->getId()})">{translate key="common.remove"}</a>
			</td>
		</tr>
	{foreachelse}
		<tr>
			<td colspan="5">{translate key="common.none"}</td>
		</tr>
	{/foreach}
	</tbody>
</table>
</div>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="sections" escape=false}'" />
</div>

</form>

<p class="form-required">{translate key="common.requiredField"}
</p>
{include file="common/footer.tpl"}

