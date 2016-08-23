{**
 * templates/rtadmin/search.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin search editing
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.searches.edit.editSearch"}
{include file="common/header.tpl"}
{/strip}

<form action="{if $searchId}{url op="saveSearch" path=$versionId|to_array:$contextId:$searchId}{else}{url op="createSearch" path=$versionId|to_array:$contextId:"save"}{/if}" method="post">

	<div class="form-row">
		<label for="title">{translate key="rt.search.title"}</label>
		<input type="text" class="textField" name="title" id="title" value="{$title|escape}" size="60" />
	</div>
	<div class="form-row">
		<label for="url">{translate key="rt.search.url"}</label>
		<input type="text" class="textField" name="url" id="url" value="{$url|escape}" size="60" />
	</div>
	<div class="form-row">
		<label for="searchUrl">{translate key="rt.search.searchUrl"}</label>
		<input type="text" class="textField" name="searchUrl" id="searchUrl" value="{$searchUrl|escape}" size="60" />
	</div>
	<div class="form-row">
		<label for="searchPost">{translate key="rt.search.searchPost"}</label>
		<input type="text" class="textField" name="searchPost" id="searchPost" value="{$searchPost|escape}" size="60" />
	</div>
	<div class="form-row">
		<label for="description">{translate key="rt.context.description"}</label>
		<textarea class="textArea" name="description" id="description" rows="5" cols="60">{$description|escape}</textarea>
	</div>
</table>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="searches" path=$versionId|to_array:$contextId escape=false}'" />
</div>

</form>

{include file="common/footer.tpl"}

