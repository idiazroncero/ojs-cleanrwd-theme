{**
 * templates/admin/journals.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of journals in site administration.
 *
 *}
{strip}
{assign var="pageTitle" value="journal.journals"}
{include file="common/header.tpl"}
{/strip}
<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#adminJournals", "moveJournal"); });
{/literal}
</script>

<br />

<div id="journals">
	<table class="listing" id="adminJournals">
		<thead>
			<tr>
				<th>{translate key="manager.setup.journalTitle"}</th>
				<th>{translate key="journal.path"}</th>
				<th>{translate key="common.order"}</th>
				<th>{translate key="common.action"}</th>
			</tr>
		</thead>
		<tbody>
			{iterate from=journals item=journal}
			<tr id="journal-{$journal->getId()}" class="data">
				<td data-title="{translate key="manager.setup.journalTitle"}">
					<a class="action" href="{url journal=$journal->getPath() page="manager"}">{$journal->getLocalizedTitle()|escape}</a>
				</td>
				<td data-title="{translate key="journal.path"}" class="drag">
					{$journal->getPath()|escape}
				</td>
				<td data-title="{translate key="common.order"}">
					<a href="{url op="moveJournal" d=u id=$journal->getId()}">&uarr;</a> <a href="{url op="moveJournal" d=d id=$journal->getId()}">&darr;</a>
				</td>
				<td data-title="{translate key="common.action"}">
					<a href="{url op="editJournal" path=$journal->getId()}" class="button button--small">{translate key="common.edit"}</a>&nbsp;
					<button class="button button--small button--cancel" href="{url op="deleteJournal" path=$journal->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="admin.journals.confirmDelete"}')">{translate key="common.delete"}</button>
				</td>
			</tr>
			{/iterate}
			{if $journals->wasEmpty()}
				<tr>
					<td>{translate key="admin.journals.noneCreated"}</td>
				</tr>
			{else}
				<tr class="listing-pager">
					<td>{page_info iterator=$journals}</td>
					<td>{page_links anchor="journals" name="journals" iterator=$journals}</td>
				</tr>
			{/if}
		</tbody>
	</table>
</div>
<div class="buttons">
	<a href="{url op="createJournal"}" class="button">{translate key="admin.journals.create"}</a>
</div>

{include file="common/footer.tpl"}

