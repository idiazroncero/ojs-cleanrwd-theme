{**
 * templates/editor/issues/backIssues.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of back issues
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.backIssues"}
{assign var="page" value=$rangeInfo->getPage()}
{url|assign:"currentUrl" page="editor" op="backIssues"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveIssue"); });
{/literal}
</script>

<ul class="menu">
        <li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
        <li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
        <li class="current"><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>



{if $usesCustomOrdering}
	{url|assign:"resetUrl" op="resetIssueOrder"}
	<p>{translate key="editor.issues.resetIssueOrder" url=$resetUrl}</p>
{/if}

<section id="issues">
<table class="listing listing--wide" id="dragTable">
	<thead>
		<th>{translate key="issue.issue"}</th>
		<th>{translate key="editor.issues.published"}</th>
		<th>{translate key="editor.issues.numArticles"}</th>
		<th>{translate key="common.order"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	{iterate from=issues item=issue}
	<tr class="data" id="issue-{$issue->getId()}">
		<td  data-title="{translate key="issue.issue"}" class="drag"><a href="{url op="issueToc" path=$issue->getId()}">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></td>
		<td  data-title="{translate key="editor.issues.published"}" class="drag">{$issue->getDatePublished()|date_format:"$dateFormatShort"|default:"&mdash;"}</td>
		<td  data-title="{translate key="editor.issues.numArticles"}" class="drag">{$issue->getNumArticles()|escape}</td>
		<td data-title="{translate key="common.order"}" ><a href="{url op="moveIssue" d=u id=$issue->getId() issuesPage=$page }">&uarr;</a>	<a href="{url op="moveIssue" d=d id=$issue->getId() issuesPage=$page }">&darr;</a></td>
		<td data-title="{translate key="common.action"}"><a href="{url op="removeIssue" path=$issue->getId() issuesPage=$page }" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
{if $issues->wasEmpty()}
	<tr>
		<td colspan="5" class="nodata">{translate key="issue.noIssues"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="2" >{page_info iterator=$issues}</td>
		<td colspan="3" >{page_links anchor="issues" name="issues" iterator=$issues}</td>
	</tr>
{/if}
</table>

<form action="{url op="setCurrentIssue"}" method="post" class="form-row">
	<label for="issueId">{translate key="journal.currentIssue"}</label>
	<select name="issueId" class="selectMenu">
		<option value="">{translate key="common.none"}</option>
		{html_options options=$allIssues|truncate:40:"..." selected=$currentIssueId}
	</select>
	<input type="submit" value="{translate key="common.record"}" class="button defaultButton" />
</form>
</section>
{include file="common/footer.tpl"}

