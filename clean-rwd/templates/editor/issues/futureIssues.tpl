{**
 * templates/editor/issues/futureIssues.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of future (unpublished) issues.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.futureIssues"}
{url|assign:"currentUrl" page="editor" op="futureIssues"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
        <li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
        <li class="current"><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
        <li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>



<div id="issues">
<table class="listing">
	<thead>
		<th >{translate key="issue.issue"}</th>
		<th >{translate key="editor.issues.numArticles"}</th>
		<th >{translate key="common.action"}</th>
	</thead>
	{iterate from=issues item=issue}
	<tr>
		<td data-title="{translate key="issue.issue"}"><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></td>
		<td data-title="{translate key="editor.issues.numArticles"}">{$issue->getNumArticles()|escape}</td>
		<td data-title="{translate key="common.action"}" ><a href="{url op="removeIssue" path=$issue->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
{if $issues->wasEmpty()}
	<tr>
		<td colspan="3" class="nodata">{translate key="issue.noIssues"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td>{page_info iterator=$issues}</td>
		<td colspan="2">{page_links anchor="issues" name="issues" iterator=$issues}</td>
	</tr>
{/if}
</table>
</div>
{include file="common/footer.tpl"}

