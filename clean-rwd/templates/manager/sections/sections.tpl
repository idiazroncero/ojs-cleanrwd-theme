{**
 * templates/manager/sections/sections.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of sections in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="section.sections"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveSection"); });
{/literal}
</script>

<div id="sections">
<table class="listing" id="dragTable">
	<thead>
		<th>{translate key="section.title"}</th>
		<th>{translate key="section.abbreviation"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	<tbody>
	{iterate from=sections item=section name=sections}
		<tr id="section-{$section->getId()}">
			<td class="drag">{$section->getLocalizedTitle()|escape}</td>
			<td class="drag">{$section->getLocalizedAbbrev()|escape}</td>
			<td>
				<a href="{url op="editSection" path=$section->getId()}" class="button button--small">{translate key="common.edit"}</a>&nbsp;<a href="{url op="deleteSection" path=$section->getId()}" onclick="{if !in_array($section->getId(), $emptySectionIds)}alert('{translate|escape:"jsparam" key="manager.sections.alertDelete"}'); return false{else}return confirm('{translate|escape:"jsparam" key="manager.sections.confirmDelete"}'){/if}" class="button button--small button--cancel">{translate key="common.delete"}</a>&nbsp;<a href="{url op="moveSection" d=u id=$section->getId()}">&uarr;</a>&nbsp;<a href="{url op="moveSection" d=d id=$section->getId()}">&darr;</a>
			</td>
		</tr>
	{/iterate}
	{if $sections->wasEmpty()}
		<tr>
			<td>{translate key="manager.sections.noneCreated"}</td>
		</tr>
	{else}
		<tr class="listing-pager">
			<td>{page_info iterator=$sections}</td>
			<td>{page_links anchor="sections" name="sections" iterator=$sections}</td>
		</tr>
	{/if}
	</tbody>
</table>

<div class="buttons">
	<a class="button" href="{url op="createSection"}">{translate key="manager.sections.create"}</a>
</div>
</div>

{include file="common/footer.tpl"}

