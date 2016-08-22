{**
 * lib/pkp/templates/announcement/announcements.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of announcements in management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.announcements"}
{assign var="pageId" value="manager.announcements"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
	<li class="current"><a href="{url op="announcements"}">{translate key="manager.announcements"}</a></li>
	<li><a href="{url op="announcementTypes"}">{translate key="manager.announcementTypes"}</a></li>
</ul>

<section class="section" id="announcementList">
<table class="listing listing--wide">
	<thead>
	<tr>
		<th>{translate key="manager.announcements.dateExpire"}</th>
		<th>{translate key="manager.announcements.type"}</th>
		<th>{translate key="manager.announcements.title"}</th>
		<th>{translate key="common.action"}</th>
	</tr>
	</thead>
	<tbody>
{iterate from=announcements item=announcement}
	<tr>
		<td data-title='{translate key="manager.announcements.dateExpire"}'>{$announcement->getDateExpire()|date_format:$dateFormatShort}</td>
		<td data-title='{translate key="manager.announcements.type"}'>{$announcement->getAnnouncementTypeName()}</td>
		<td data-title='{translate key="manager.announcements.title"}'>{$announcement->getLocalizedTitle()|escape}</td>
		<td data-title='{translate key="common.action"}'><a href="{url op="editAnnouncement" path=$announcement->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;<a href="{url op="deleteAnnouncement" path=$announcement->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.announcements.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
{if $announcements->wasEmpty()}
	<tr>
		<td colspan="4" class="nodata">{translate key="manager.announcements.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="2" align="left">{page_info iterator=$announcements}</td>
		<td colspan="2" align="right">{page_links anchor="announcements" name="announcements" iterator=$announcements}</td>
	</tr>
{/if}
</tbody>
</table>

<div class="buttons">
	<a href="{url op="createAnnouncement"}" class="button">{translate key="manager.announcements.create"}</a>
</div>
</section>
{include file="common/footer.tpl"}

