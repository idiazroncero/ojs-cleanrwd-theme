{**
 * templates/rtadmin/contexts.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin context list
 *
 *}
{strip}
{assign var="pageTitle" value="rt.contexts"}
{include file="common/header.tpl"}
{/strip}
<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", 
{/literal}
"{url op=moveContext path=$version->getVersionId()}"
{literal}
); });
{/literal}
</script>

<ul class="menu">
	<li><a href="{url op="editVersion" path=$version->getVersionId()}" class="action">{translate key="rt.admin.versions.metadata"}</a></li>
	<li class="current"><a href="{url op="contexts" path=$version->getVersionId()}" class="action">{translate key="rt.contexts"}</a></li>
</ul>



<div id="contexts">
<table class="listing" id="dragTable">
	<thead>
	<tr >
		<th>{translate key="rt.context.title"}</td>
		<th>{translate key="rt.context.abbrev"}</td>
		<th>&nbsp;</td>
	</tr>
	</thead>
	
	<tbody>
	{iterate from=contexts item=context}
		<tr class="data" id=context-{$context->getContextId()}>
			<td data-title='{translate key="rt.context.title"}' class="drag">{$context->getTitle()|escape}</td>
			<td data-title='{translate key="rt.context.abbrev"}' class="drag">{$context->getAbbrev()|escape}</td>
			<td align="right"><a href="{url op="moveContext" path=$version->getVersionId()|to_array id=$context->getContextId() dir=u}" class="action">&uarr;</a>&nbsp;<a href="{url op="moveContext" path=$version->getVersionId()|to_array id=$context->getContextId() dir=d}" class="action">&darr;</a>&nbsp;|&nbsp;<a href="{url op="editContext" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.admin.contexts.metadata"}</a>&nbsp;|&nbsp;<a href="{url op="searches" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.searches"}</a>&nbsp;|&nbsp;<a href="{url op="deleteContext" path=$version->getVersionId()|to_array:$context->getContextId()}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.contexts.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
		</tr>
	{/iterate}
	{if $contexts->wasEmpty()}
		<tr >
			<td class="nodata" colspan="3">{translate key="common.none"}</td>
		</tr>
	{else}
		<tr class="listing-pager">
			<td>{page_info iterator=$contexts}</td>
			<td colspan="2">{page_links anchor="contexts" name="contexts" iterator=$contexts}</td>
		</tr>
	{/if}
	</tbody>
</table>


<div class="buttons">
	<a href="{url op="createContext" path=$version->getVersionId()}" class="button">{translate key="rt.admin.contexts.createContext"}</a>
</div>

</div>

{include file="common/footer.tpl"}

