{**
 * templates/manager/files/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Files browser.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.filesBrowser"}
{include file="common/header.tpl"}
{/strip}

{assign var=displayDir value="/$currentDir"}
<h3>{translate key="manager.files.indexOfDir" dir=$displayDir|escape}</h3>

{if $currentDir}
<p><a href="{url op="files" path=$parentDir|explode:"/"}" class="button">&lt; {translate key="manager.files.parentDir"}</a></p>
{/if}

<table class="listing listing--wide">
	<thead>
		<th></th>
		<th>{translate key="common.fileName"}</th>
		<th>{translate key="common.type"}</th>
		<th>{translate key="common.dateModified"}</th>
		<th>{translate key="common.size"}</th>
		<th>{translate key="common.action"}</th>
	</thead>

	{foreach from=$files item=file name=files}
	{if $currentDir}
		{assign var=filePath value=$currentDir|concat:"/":$file.name}
	{else}
		{assign var=filePath value=$file.name}
	{/if}
	{assign var=filePath value=$filePath|escape}
	<tbody>
		<tr>
			<td>{if $file.isDir}
				<i class="fa fa-folder"></i> <!-- {icon name="folder"} -->
				{else}
				<i class="fa fa-file-o"></i> <!-- {icon name="letter"} -->
				{/if}</td>
			<td data-title='{translate key="common.fileName"}'><a href="{url op="files" path=$filePath|explode:"/"}">{$file.name}</a></td>
			<td data-title='{translate key="common.type"}'>{$file.mimetype|escape|default:"&mdash;"}</td>
			<td data-title='{translate key="common.dateModified"}'>{$file.mtime|escape|date_format:$datetimeFormatShort}</td>
			<td data-title='{translate key="common.size"}'>{$file.size|escape|default:"&mdash;"}</td>
			<td data-title='{translate key="common.action"}'>
				{if !$file.isDir}
					<a href="{url op="files" path=$filePath|explode:"/" download=1}" class="button button--small">{translate key="common.download"}</a>&nbsp;|
				{/if}
				<a href="{url op="fileDelete" path=$filePath|explode:"/"}" onclick="return confirm('{translate|escape:"jsparam" key="manager.files.confirmDelete"}')" class="button button--small button--cancel">{translate key="common.delete"}</a>
			</td>
		</tr>
	{foreachelse}
		<tr>
			<td colspan="6">{translate key="manager.files.emptyDir"}</td>
		</tr>
	</tbody>
{/foreach}
</table>

<div class="section">
	<form method="post" action="{url op="fileUpload" path=$currentDir|explode:"/"}" enctype="multipart/form-data">
		<input type="file" size="20" name="file" class="uploadField" />
		<input type="submit" value="{translate key="manager.files.uploadFile"}" class="button" />
	</form>
</div>

<div class="section">
	<form method="post" action="{url op="fileMakeDir" path=$currentDir|explode:"/"}" enctype="multipart/form-data">
		<input type="text" size="20" maxlength="255" name="dirName" class="textField" />
		<input type="submit" value="{translate key="manager.files.createDir"}" class="button" />
	</form>
</div>

<p class="instruct">{translate key="manager.files.note"}</p>

{include file="common/footer.tpl"}

