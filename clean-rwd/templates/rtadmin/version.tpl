{**
 * templates/rtadmin/version.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin version editing
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.versions.edit.editVersion"}
{include file="common/header.tpl"}
{/strip}

{if $versionId}
	<ul class="menu">
		<li class="current"><a href="{url op="editVersion" path=$versionId}" class="action">{translate key="rt.admin.versions.metadata"}</a></li>
		<li><a href="{url op="contexts" path=$versionId}" class="action">{translate key="rt.contexts"}</a></li>
	</ul>
{/if}



<form action="{if $versionId}{url op="saveVersion" path=$versionId}{else}{url op="createVersion" path="save"}{/if}" method="post">

	<div class="form-row">
		<label for="title">{translate key="rt.version.title"}</label>
		<input type="text" class="textField" name="title" id="title" value="{$title|escape}" size="60" />
	</div>
	
	<div class="form-row">
		<label for="key">{translate key="rt.version.key"}</label>
		<input type="text" class="textField" name="key" id="key" value="{$key|escape}" size="60" />
	</div>
	
	<div class="form-row">
		<label for="locale">{translate key="rt.version.locale"}</label>
		<input type="text" class="textField" name="locale" id="locale" maxlength="5" size="5" value="{$locale|escape}" />
	</div>
	
	<div class="form-row">
		<label for="description">{translate key="rt.version.description"}</label>
		<textarea class="textArea" name="description" id="description" rows="5" cols="60">{$description|escape}</textarea>
	</div>


<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="versions" escape=false}'" />
</div>

</form>

{include file="common/footer.tpl"}

