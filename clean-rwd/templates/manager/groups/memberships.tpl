{**
 * templates/manager/groups/memberships.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of groups in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.groups.membership"}
{assign var="pageId" value="manager.groups"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", {/literal}"{url op=moveMembership path=$group->getId()}"{literal}); });
{/literal}
</script>

<ul class="menu">
	<li><a href="{url op="editGroup" path=$group->getId()}">{translate key="manager.groups.editTitle"}</a></li>
	<li class="current"><a href="{url op="groupMembership" path=$group->getId()}">{translate key="manager.groups.membership}</a></li>
</ul>



<div id="membership">
<table class="listing" id="dragTable">
	<thead>
	<tr class="heading" >
		<th>{translate key="user.name"}</th>
		<th>{translate key="common.action"}</th>
	</tr>
	</thead>
	<tbody>
{iterate from=memberships item=membership}
	{assign var=user value=$membership->getUser()}
	<tr  class="data" id=membership-{$membership->getUserId()}>
		<td data-title='{translate key="user.name"}' class="drag">{$user->getFullName()|escape}</td>
		<td data-title='{translate key="common.action"}' >
			<a href="{url op="deleteMembership" path=$membership->getGroupId()|to_array:$membership->getUserId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.groups.membership.confirmDelete"}')" class="action">{translate key="common.delete"}</a>&nbsp;|&nbsp;<a href="{url op="moveMembership" d=u path=$group->getId() id=$user->getId()}">&uarr;</a>&nbsp;<a href="{url op="moveMembership" d=d path=$group->getId() id=$user->getId()}">&darr;</a>
		</td>
	</tr>
{/iterate}
{if $memberships->wasEmpty()}
	<tr>
		<td colspan="2" class="nodata">{translate key="manager.groups.membership.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td>{page_info iterator=$memberships}</td>
		<td>{page_links anchor="membership" name="memberships" iterator=$memberships}</td>
	</tr>
{/if}
</tbody>
</table>

<div class="buttons">
	<a href="{url op="addMembership" path=$group->getId()}" class="button">{translate key="manager.groups.membership.addMember"}</a>
</div>
</div>
{include file="common/footer.tpl"}

