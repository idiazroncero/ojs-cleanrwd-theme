{**
 * announcementTypes.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcement types in management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.announcementTypes"}
{assign var="pageId" value="manager.announcementTypes"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
	<li><a href="{url op="announcements"}">{translate key="manager.announcements"}</a></li>
	<li class="current"><a href="{url op="announcementTypes"}">{translate key="manager.announcementTypes"}</a></li>
</ul>

<br />

<section id="announcementTypes">
<table class="listing">
	<thead>
		<tr>
			<th>{translate key="manager.announcementTypes.typeName"}</th>
			<th>{translate key="common.action"}</th>
		</tr>
	</thead>
	<tbody>
{iterate from=announcementTypes item=announcementType}
	<tr>
		<td data-title='{translate key="manager.announcementTypes.typeName"}'>{$announcementType->getLocalizedTypeName()|escape}</td>
		<td data-title='{translate key="common.action"}'><a href="{url op="editAnnouncementType" path=$announcementType->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteAnnouncementType" path=$announcementType->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.announcementTypes.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
{if $announcementTypes->wasEmpty()}
	<tr>
		<td colspan="2" class="nodata">{translate key="manager.announcementTypes.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td>{page_info iterator=$announcementTypes}</td>
		<td>{page_links anchor="announcementTypes" name="announcementTypes" iterator=$announcementTypes}</td>
	</tr>
{/if}
</tbody>
</table>

<div class="buttons">
	<a href="{url op="createAnnouncementType"}" class="button">{translate key="manager.announcementTypes.create"}</a>
</div>
</section>

{include file="common/footer.tpl"}

