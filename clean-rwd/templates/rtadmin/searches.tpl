{**
 * templates/rtadmin/searches.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin search list
 *
 *}
{strip}
{assign var="pageTitle" value="rt.searches"}
{include file="common/header.tpl"}
{/strip}
<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", 
{/literal}
"{url op=moveSearch path=$version->getVersionId()|to_array:$context->getContextId()}"
{literal}
); });
{/literal}
</script>

<ul class="menu">
	<li><a href="{url op="editContext" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.admin.contexts.metadata"}</a></li>
	<li class="current"><a href="{url op="searches" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.searches"}</a></li>
</ul>



<div id="searches">

<table class="listing listing--wide" id="dragTable">
	<thead>
	<tr >
		<th>{translate key="rt.search.title"}</td>
		<th>{translate key="rt.search.url"}</td>
		<th>&nbsp;</td>
	</tr>
	</thead>

	<tbody>
	{iterate from=searches item=search}
		<tr  class="data" id=search-{$search->getSearchId()}>
			<td data-title='{translate key="rt.search.title"}' class="drag">{$search->getTitle()|escape}</td>
			<td data-title='{translate key="rt.search.url"}' class="drag">{$search->getUrl()|truncate:30|escape}</td>
			<td align="right"><a href="{url op="moveSearch" path=$version->getVersionId()|to_array:$context->getContextId() id=$search->getSearchId() dir=u}" class="action">&uarr;</a>&nbsp;<a href="{url op="moveSearch" path=$version->getVersionId()|to_array:$context->getContextId() id=$search->getSearchId() dir=d}" class="action">&darr;</a>&nbsp;|&nbsp;<a href="{url op="editSearch" path=$version->getVersionId()|to_array:$context->getContextId():$search->getSearchId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSearch" path=$version->getVersionId()|to_array:$context->getContextId():$search->getSearchId()}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.searches.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
		</tr>
	{/iterate}
	{if $searches->wasEmpty()}
		<tr >
			<td class="nodata" colspan="3">{translate key="common.none"}</td>
		</tr>
	{else}
		<tr class="listing-pager">
			<td>{page_info iterator=$searches}</td>
			<td>{page_links anchor="searches" name="searches" iterator=$searches}</td>
		</tr>
	{/if}
	</tbody>
</table>


<div class="buttons">
	<a href="{url op="createSearch" path=$version->getVersionId()|to_array:$context->getContextId()}" class="button">{translate key="rt.admin.searches.createSearch"}</a>
</div>

</div>

{include file="common/footer.tpl"}

