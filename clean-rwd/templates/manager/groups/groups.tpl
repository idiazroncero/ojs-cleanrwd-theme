{**
 * templates/manager/groups/groups.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of groups in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.groups"}
{assign var="pageId" value="manager.groups"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveGroup"); });
{/literal}
</script>



<form action="{url op="setBoardEnabled"}" method="post">
	{url|assign:"aboutEditorialTeamUrl" page="about" op="editorialTeam"}
	{url|assign:"peopleManagementUrl" page="manager" op="people" path="all"}
	<p>{translate key="manager.groups.enableBoard.description" aboutEditorialTeamUrl=$aboutEditorialTeamUrl}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" id="boardEnabledOff" {if !$boardEnabled}checked="checked" {/if}name="boardEnabled" value="0"/>&nbsp;
			<label for="boardEnabledOff">{translate key="manager.groups.disableBoard"}</label>
		</div>
		<div class="form-group">
			<input type="radio" id="boardEnabledOn" {if $boardEnabled}checked="checked" {/if}name="boardEnabled" value="1"/>&nbsp;
			<label for="boardEnabledOn">{translate key="manager.groups.enableBoard"}</label>
		</div>
		<input type="submit" value="{translate key="common.record"}" class="button defaultButton"/>
	</div>
</form>



<section id="groups">

<table class="listing" id="dragTable">
	<thead>
	<tr >
		<th>{translate key="manager.groups.title"}</th>
		<th>{translate key="common.action"}</th>
	</tr>
	</thead>

	<tbody>
{assign var="isFirstEditorialTeamEntry" value=1}
{iterate from=groups item=group}
	{if $group->getContext() == GROUP_CONTEXT_EDITORIAL_TEAM}
<!-- 		{if $isFirstEditorialTeamEntry}
			{assign var="isFirstEditorialTeamEntry" value=0}
				<tr >
					<td colspan="3">{translate key="manager.groups.context.editorialTeam.short"}</td>
				</tr>
			{/if} -->
		<tr  id=editorialteam-{$group->getId()} class="data">
			<td data-title='{translate key="manager.groups.title"}' class="drag">
				{url|assign:"url" page="manager" op="email" toGroup=$group->getId()}
				{$group->getLocalizedTitle()|escape}&nbsp;{icon name="mail" url=$url}
			</td>
		{else}
		<tr  id="other-{$group->getId()}" class="data">
			<td data-title='{translate key="manager.groups.title"}' class="drag" colspan="2">
				{url|assign:"url" page="manager" op="email" toGroup=$group->getId()}
				{$group->getLocalizedTitle()|escape}&nbsp;{icon name="mail" url=$url}
			</td>
		{/if}
		<td data-title='{translate key="common.action"}'>
			<a href="{url op="editGroup" path=$group->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="groupMembership" path=$group->getId()}" class="action">{translate key="manager.groups.membership"}</a>&nbsp;|&nbsp;<a href="{url op="deleteGroup" path=$group->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.groups.confirmDelete"}')" class="action">{translate key="common.delete"}</a>&nbsp;|&nbsp;<a href="{url op="moveGroup" d=u id=$group->getId()}">&uarr;</a>&nbsp;<a href="{url op="moveGroup" d=d id=$group->getId()}">&darr;</a>
		</td>
	</tr>
{/iterate}
{if $groups->wasEmpty()}
	<tr>
		<td colspan="3" class="nodata">{translate key="manager.groups.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="2" >{page_info iterator=$groups}</td>
		<td colspan="1" >{page_links anchor="groups" name="groups" iterator=$groups}</td>
	</tr>
{/if}
</tbody>
</table>

<div class="buttons">
	<a href="{url op="createGroup"}" class="button">{translate key="manager.groups.create"}</a>
</div>

</section>

{include file="common/footer.tpl"}

