{**
 * templates/admin/auth/sources.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of authentication sources in site administration.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.authSources"}
{include file="common/header.tpl"}
{/strip}

<form method="post" action="{url op="updateAuthSources"}">

<div id="sources">
<table class="listing">
	<thead>
		<tr>
			<th>{translate key="common.default"}</th>
			<th>{translate key="common.title"}</th>
			<th>{translate key="common.plugin"}</th>
			<th>{translate key="common.action"}</th>
		</tr>

	</thead>
	<tbody>
		{iterate from=sources item=auth}
		<tr>
			<td>
				<input type="radio" id="defaultAuthId_{$auth->getAuthId()}" name="defaultAuthId" value="{$auth->getAuthId()}"{if $auth->getDefault()} checked="checked"{assign var="defaultAuthId" value=$auth->getAuthId()}{/if} />
			</td>
			<td>
				<label for="defaultAuthId_{$auth->getAuthId()}">
					{$auth->getTitle()|escape}</label>
			</td>
			<td>{$auth->getPlugin()}</td>
			<td>
				<a href="{url op="editAuthSource" path=$auth->getAuthId()}" class="button button--small">{translate key="common.edit"}</a>&nbsp;<a class="button button--small button--cancel" href="{url op="deleteAuthSource" path=$auth->getAuthId()}" onclick="return confirm('{translate|escape:"jsparam" key="admin.auth.confirmDelete"}')">{translate key="common.delete"}</a>
			</td>
		</tr>
	{/iterate}
	{if $sources->wasEmpty()}
		<tr>
			<td class="nodata">{translate key="admin.auth.noneCreated"}</td>
		</tr>
	{else}
		<tr class="listing-pager">
			<td>{page_info iterator=$sources}</td>
			<td>{page_links anchor="sources" name="sources" iterator=$sources}</td>
		</tr>
	{/if}
	<tr >
		<td>
			<input type="radio" id="defaultAuthId_0" name="defaultAuthId" value="0"{if !$defaultAuthId} checked="checked"{/if} />
		</td>
		<td>
			<label for="defaultAuthId_0">{translate key="admin.auth.ojs"}</label>
		</td>
		<td>
			<input type="submit" value="{translate key="common.save"}" class="button button--small" />
		</td>
		<td>
			<!-- Dummy table cell to avoid :last-child issues -->
		</td>
	</tr>
</table>

</form>

{translate key="admin.auth.defaultSourceDescription"}

<div id="createAuth" class="form-row">
<h4>{translate key="admin.auth.create"}</h4>

<form method="post" action="{url op="createAuthSource"}">
	<label for="plugin">{translate key="common.plugin"}:</label> <select name="plugin" size="1"><option value=""></option>{html_options options=$pluginOptions}</select><input type="submit" value="{translate key="common.create"}" class="button" />
</form>
</div>
</div>
{include file="common/footer.tpl"}

