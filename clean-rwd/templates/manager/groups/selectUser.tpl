{**
 * templates/manager/groups/selectUser.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List a set of users and allow one to be selected.
 *
 *}
{strip}
{assign var=pageTitle value="manager.groups.membership.addMember"}
{include file="common/header.tpl"}
{/strip}

<form name="submit" method="post" action="{url op="addMembership" path=$group->getId()}">
	<select name="searchField" size="1" class="selectMenu">
		{html_options_translate options=$fieldOptions selected=$searchField}
	</select>
	<select name="searchMatch" size="1" class="selectMenu">
		<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
		<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
		<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
	</select>
	<input type="text" size="15" name="search" class="textField" value="{$search|escape}" />&nbsp;<input type="submit" value="{translate key="common.search"}" class="button" />
</form>

<p class="alphabet">{foreach from=$alphaList item=letter}<a href="{url path=$group->getId() searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url path=$group->getId()}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>

<div id="users">
<table class="listing">
<thead>
<tr class="heading" >
	<th>{translate key="user.name"}</td>
	<th>{translate key="common.action"}</td>
</tr>
</thead>
<tbody>
{iterate from=users item=user}
{assign var="userid" value=$user->getId()}
<tr >
	<td data-title='{translate key="user.name"}'><a href="{url op="userProfile" path=$userid}">{$user->getFullName(true)|escape}</a></td>
	<td data-title='{translate key="common.action"}'>
		<a href="{url op="addMembership" path=$group->getId()|to_array:$user->getId()}" class="action">{translate key="manager.groups.membership.addMember"}</a>
	</td>
</tr>
{/iterate}
{if $users->wasEmpty()}
	<tr>
	<td colspan="2" class="nodata">{translate key="manager.groups.membership.noUsers"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td>{page_info iterator=$users}</td>
		<td>{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
	</tr>
{/if}
</tbody>
</table>

{if $backLink}
<div class="buttons">
	<a class="buttons" href="{$backLink}">{translate key="$backLinkLabel"}</a>
</div>
{/if}
</div>

{include file="common/footer.tpl"}

