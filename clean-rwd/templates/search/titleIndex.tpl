{**
 * templates/search/titleIndex.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display published articles by title
 *
 *}
{strip}
{assign var=pageTitle value="search.titleIndex"}
{include file="common/header.tpl"}
{/strip}



{if $currentJournal}
	{assign var=numCols value=3}
{else}
	{assign var=numCols value=4}
{/if}

<div id="results">
<table class="listing listing--wide">
<thead>
<tr class="heading" >
	{if !$currentJournal}<th>{translate key="journal.journal"}</th>{/if}
	<th>{translate key="issue.issue"}</th>
	<th>{translate key="article.title"}</td>
</tr>
</thead>

<tbody>
{iterate from=results item=result}
{assign var=publishedArticle value=$result.publishedArticle}
{assign var=article value=$result.article}
{assign var=issue value=$result.issue}
{assign var=issueAvailable value=$result.issueAvailable}
{assign var=journal value=$result.journal}
<tr >
	{if !$currentJournal}<td data-title='{translate key="journal.journal"}'><a href="{url journal=$journal->getPath()}">{$journal->getLocalizedTitle()|escape}</a></td>{/if}
	<td data-title='{translate key="issue.issue"}'>{if $issueAvailable}<a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)}">{/if}{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}{if $issueAvailable}</a>{/if}</td>
	<td data-title='{translate key="article.title"}'>
		{$article->getLocalizedTitle()|strip_unsafe_html}
		<p class="marginless">{foreach from=$article->getAuthors() item=author name=authorList}
			{$author->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
		{/foreach}</p>
		<p class="marginless"><a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)}">{if $article->getLocalizedAbstract()}{translate key="article.abstract"}{else}{translate key="article.details"}{/if}</a>
		{if $issueAvailable}
		{foreach from=$publishedArticle->getGalleys() item=galley name=galleyList}&nbsp;
			<i class="fa fa-file-o"></i>
			<a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)|to_array:$galley->getBestGalleyId($journal)}">{$galley->getGalleyLabel()|escape}</a>
		{/foreach}
		{/if}
		</p>
	</td>
</tr>
{/iterate}
{if $results->wasEmpty()}
<tr>
<td colspan="{$numCols|escape}" class="nodata">{translate key="search.noResults"}</td>
</tr>
{else}
	<tr class="listing-pager">
		<td {if !$currentJournal}colspan="2" {/if}>{page_info iterator=$results}</td>
		<td>{page_links anchor="results" iterator=$results name="search"}</td>
	</tr>
{/if}
</tbody>
</table>
</div>
{include file="common/footer.tpl"}

