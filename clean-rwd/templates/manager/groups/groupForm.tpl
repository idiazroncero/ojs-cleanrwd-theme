{**
 * templates/manager/groups/groupForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Group form under journal management.
 *
 *}
{strip}
{assign var="pageId" value="manager.groups.groupForm"}
{assign var="pageCrumbTitle" value=$pageTitle}
{include file="common/header.tpl"}
{/strip}
<div id="groupFormDiv">
{if $group}
	<ul class="menu">
		<li class="current"><a href="{url op="editGroup" path=$group->getId()}">{translate key="manager.groups.editTitle"}</a></li>
		<li><a href="{url op="groupMembership" path=$group->getId()}">{translate key="manager.groups.membership}</a></li>
	</ul>
{/if}



<form id="groupForm" method="post" action="{url op="updateGroup"}">
{if $group}
	<input type="hidden" name="groupId" value="{$group->getId()}"/>
{/if}

{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
	<div class="form-row">
		<p class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</p>
			{if $group}{url|assign:"groupFormUrl" op="editGroup" path=$group->getId() escape=false}
			{else}{url|assign:"groupFormUrl" op="createGroup" escape=false}
			{/if}
			{form_language_chooser form="groupForm" url=$groupFormUrl}
			<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
{/if}
<div class="form-row">
	<p class="label">{fieldLabel name="title" required="true" key="manager.groups.title"}</p>
	<input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="35" maxlength="80" id="title" class="textField" />
</div>

<div class="form-row">
	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="publishEmail" value="1" {if $publishEmail}checked="checked" {/if} id="publishEmail" />&nbsp;
		{fieldLabel name="publishEmail" key="manager.groups.publishEmails"}
		</div>

		<div class="form-group">
			<p class="label">{translate key="common.type"}</p>
			<div class="form-subrow">
				{foreach from=$groupContextOptions item=groupContextOptionKey key=groupContextOptionValue}
					<div class="form-group">
					<input type="radio" name="context" value="{$groupContextOptionValue|escape}" {if $context == $groupContextOptionValue}checked="checked" {/if} id="context-{$groupContextOptionValue|escape}" />&nbsp;
					{fieldLabel name="context-"|concat:$groupContextOptionValue key=$groupContextOptionKey}
					</div>
				{/foreach}
			</div>
		</div>
	</div>
</table>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="groups" escape=false}'" />
</div>
</form>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</section>
{include file="common/footer.tpl"}

