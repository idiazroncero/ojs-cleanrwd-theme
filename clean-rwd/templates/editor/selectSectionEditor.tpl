{**
 * templates/editor/selectSectionEditor.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List editors or section editors and give the ability to select one.
 *
 *}
{strip}
{assign var="pageTitle" value=$roleName|concat:"s"}
{include file="common/header.tpl"}
{/strip}

<h3>{translate key="editor.article.selectEditor" roleName=$roleName|translate}</h3>

<form id="submit" method="post" action="{url op="assignEditor" path=$rolePath articleId=$articleId}">
	<select name="searchField" size="1" class="selectMenu">
		{html_options_translate options=$fieldOptions selected=$searchField}
	</select>
	<select name="searchMatch" size="1" class="selectMenu">
		<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
		<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
		<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
	</select>
	<input type="text" name="search" class="textField" value="{$search|escape}" />&nbsp;<input type="submit" value="{translate key="common.search"}" class="button" />
</form>

<p class="alphabet">{foreach from=$alphaList item=letter}<a href="{url op="assignEditor" path=$rolePath articleId=$articleId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="assignEditor" articleId=$articleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

<div id="editors">
<table class="listing">
<thead>
<tr >
	<th>{translate key="user.name"}</th>
	<th>{translate key="section.sections"}</th>
	<th>{translate key="submissions.completed"}</th>
	<th>{translate key="submissions.active"}</th>
	<th>{translate key="common.action"}</th>
</tr>
</thead>

<tbody>
{iterate from=editors item=editor}
{assign var=editorId value=$editor->getId()}
<tr >
	<td data-title='{translate key="user.name"}'><a href="{url op="userProfile" path=$editorId}">{$editor->getFullName()|escape}</a></td>
	<td data-title='{translate key="section.sections"}'>
		{assign var=thisEditorSections value=$editorSections[$editorId]}
		{foreach from=$thisEditorSections item=section}
			{$section->getLocalizedAbbrev()|escape}&nbsp;
		{foreachelse}
			&mdash;
		{/foreach}
	</td>
	<td data-title='{translate key="submissions.completed"}'>
		{if $editorStatistics[$editorId] && $editorStatistics[$editorId].complete}
			{$editorStatistics[$editorId].complete}
		{else}
			0
		{/if}
	</td>
	<td data-title='{translate key="submissions.active"}'>
		{if $editorStatistics[$editorId] && $editorStatistics[$editorId].incomplete}
			{$editorStatistics[$editorId].incomplete}
		{else}
			0
		{/if}
	</td>
	<td data-title='{translate key="common.action"}'><a class="action" href="{url op="assignEditor" articleId=$articleId editorId=$editorId}">{translate key="common.assign"}</a></td>
</tr>

{/iterate}
{if $editors->wasEmpty()}
<tr>
<td colspan="5" class="nodata">{translate key="manager.people.noneEnrolled"}</td>
</tr>
{else}
	<tr class="listing-pager">
		<td colspan="2">{page_info iterator=$editors}</td>
		<td colspan="3">{page_links anchor="editors" name="editors" iterator=$editors searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth articleId=$articleId}</td>
	</tr>
{/if}
</tbody>
</table>
</div>
{include file="common/footer.tpl"}

