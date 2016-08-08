{**
 * templates/rtadmin/context.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin context editing
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.contexts.edit.editContext"}
{include file="common/header.tpl"}
{/strip}
<div id="editContext">
{if $contextId}
	<ul class="menu">
		<li class="current"><a href="{url op="editContext" path=$versionId|to_array:$contextId}" class="action">{translate key="rt.admin.contexts.metadata"}</a></li>
		<li><a href="{url op="searches" path=$versionId|to_array:$contextId}" class="action">{translate key="rt.searches"}</a></li>
	</ul>
{/if}



<form action="{if $contextId}{url op="saveContext" path=$versionId|to_array:$contextId}{else}{url op="createContext" path=$versionId|to_array:"save"}{/if}" method="post">
<table class="data" width="100%">
	<tr >
		<td class="label" width="20%"><label for="title">{translate key="rt.context.title"}</label></td>
		<td class="value" width="80%"><input type="text" class="textField" name="title" id="title" value="{$title|escape}" size="60" /></td>
	</tr>
	<tr >
		<td class="label"><label for="abbrev">{translate key="rt.context.abbrev"}</label></td>
		<td class="value"><input type="text" class="textField" name="abbrev" id="abbrev" value="{$abbrev|escape}" size="60" /></td>
	</tr>
	<tr >
		<td class="label"><label for="description">{translate key="rt.context.description"}</label></td>
		<td class="value">
			<textarea class="textArea" name="description" id="description" rows="5" cols="60">{$description|escape}</textarea>
		</td>
	</tr>
	<tr >
		<td class="label">{translate key="rt.admin.contexts.options"}</label></td>
		<td class="value">
			<table width="100%" class="data">
				<tr >
					<td width="3%"><input type="checkbox" name="authorTerms" id="authorTerms" {if $authorTerms}checked="checked"{/if} /></td>
					<td><label for="authorTerms">{translate key="rt.admin.contexts.options.authorTerms"}</label></td>
				</tr>
				<tr >
					<td width="3%"><input type="checkbox" name="geoTerms" id="geoTerms" {if $geoTerms}checked="checked"{/if} /></td>
					<td><label for="geoTerms">{translate key="rt.admin.contexts.options.geoTerms"}</label></td>
				</tr>
				<tr >
					<td><input type="checkbox" name="defineTerms" id="defineTerms" {if $defineTerms}checked="checked"{/if} /></td>
					{url|assign:"url" page="rtadmin" op="settings"}
					<td><label for="defineTerms">{translate key="rt.admin.contexts.options.defineTerms" settingsUrl=$url}</label></td>
				</tr>
				<tr >
					<td><input type="checkbox" name="citedBy" id="citedBy" {if $citedBy}checked="checked"{/if} /></td>
					{url|assign:"url" page="rtadmin" op="settings"}
					<td><label for="citedBy">{translate key="rt.admin.contexts.options.citedBy" settingsUrl=$url}</label></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<p><input type="submit" value="{translate key="common.save"}" class="button defaultButton" /> <input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url op="contexts" path=$versionId escape=false}'" /></p>

</form>
</div>
{include file="common/footer.tpl"}

