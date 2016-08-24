{**
 * templates/sectionEditor/searchUsers.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Search form for enrolled users.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="manager.people.enrollment"}
{include file="common/header.tpl"}
{/strip}

<form id="submit" method="post" action="{url op="enrollSearch" path=$articleId}">
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

<p class="alphabet">
	{foreach from=$alphaList item=letter}<a href="{url op="enrollSearch" path=$articleId searchInitial=$letter}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="enrollSearch" path=$articleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a>
</p>

<div id="users">
<form action="{url op="enroll" path=$articleId}" method="post">
<table class="listing listing--wide">
<thead>
<tr>
	<th>&nbsp;</th>
	<th>{translate key="user.username"}</th>
	<th>{translate key="user.name"}</th>
	<th>{translate key="user.email"}</th>
	<th>{translate key="common.action"}</th>
</tr>
</thead>

<tbody>
{iterate from=users item=user}
{assign var="userid" value=$user->getId()}
{assign var="stats" value=$statistics[$userid]}
<tr >
	<td>
		<input type="checkbox" name="users[]" value="{$user->getId()}" />
	</td>
	<td data-title='{translate key="user.username"}'><a href="{url op="userProfile" path=$userid}">{$user->getUsername()|escape}</a></td>
	<td data-title='{translate key="user.name"}'>{$user->getFullName(true)|escape}</td>
	<td data-title='{translate key="user.email"}'>{$user->getEmail(true)|escape}</td>
	<td data-title='{translate key="common.action"}'><a href="{url op="enroll" path=$articleId userId=$user->getId()}" class="action">{translate key="manager.people.enroll"}</a></td>
</tr>

{/iterate}
{if $users->wasEmpty()}
	<tr>
		<td colspan="5" class="nodata">{translate key="common.none"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="3">{page_info iterator=$users}</td>
		<td colspan="2">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

<div class="buttons">
	<input type="submit" value="{translate key="manager.people.enrollSelected"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url page="manager" escape=false}'" />
</div>

</form>


{if $backLink}
<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
{/if}

{include file="common/footer.tpl"}

