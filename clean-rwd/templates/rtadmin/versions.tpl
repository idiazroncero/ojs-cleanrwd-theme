{**
 * templates/rtadmin/versions.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin version list
 *
 *}
{strip}
{assign var="pageTitle" value="rt.versions"}
{include file="common/header.tpl"}
{/strip}



<div id="versions">
<table class="listing listing--wide">
	<thead>
	<tr >
		<th>{translate key="rt.version.title"}</td>
		<th>{translate key="rt.version.locale"}</td>
		<th>{translate key="common.action"}</td>
	</tr>
	</thead>
	<tbody>
	{iterate from=versions item=version}
		<tr >
			<td>{$version->getTitle()|escape}</td>
			<td>{$version->getLocale()|escape}</td>
			<td><a href="{url op="validateUrls" path=$version->getVersionId()}" class="action">{translate key="rt.admin.validateUrls.validate"}</a>&nbsp;|&nbsp;<a href="{url op="editVersion" path=$version->getVersionId()}" class="action">{translate key="rt.admin.versions.metadata"}</a>&nbsp;|&nbsp;<a href="{url op="contexts" path=$version->getVersionId()}" class="action">{translate key="rt.contexts"}</a>&nbsp;|&nbsp;<a href="{url op="exportVersion" path=$version->getVersionId()}" class="action">{translate key="rt.admin.versions.export"}</a>&nbsp;|&nbsp;<a href="{url op="deleteVersion" path=$version->getVersionId()}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.versions.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
		</tr>
	{/iterate}
	{if $versions->wasEmpty()}
		<tr >
			<td class="nodata" colspan="3">{translate key="common.none"}</td>
		</tr>
	{else}
		<tr class="listing-pager">
			<td>{page_info iterator=$versions}</td>
			<td colspan="2">{page_links anchor="versions" name="versions" iterator=$versions}</td>
		</tr>
	{/if}
	</table>
	</tbody>
</div>

<form class="form-row" method="post" action="{url op="importVersion"}" enctype="multipart/form-data">
	<input type="file" class="uploadField" name="versionFile" />
	<input type="submit" class="button" value="{translate key="rt.admin.versions.importVersion"}" />
</form>


<div class="buttons">
	<a href="{url op="createVersion"}" class="button">{translate key="rt.admin.versions.createVersion"}</a>
	
	<a href="{url op="restoreVersions"}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.versions.confirmRestore"}')" class="button">{translate key="rt.admin.versions.restoreVersions"}</a>
</div>






{include file="common/footer.tpl"}

