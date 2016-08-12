{**
 * templates/search/search.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * A unified search interface.
 *}
{strip}
{assign var="pageTitle" value="navigation.search"}
{include file="common/header.tpl"}
{/strip}

<div id="search">
	<script type="text/javascript">
		$(function() {ldelim}
			// Attach the form handler.
			$('#searchForm').pkpHandler('$.pkp.pages.search.SearchFormHandler');
		{rdelim});
	</script>

	<form id="searchForm" action="{url op="search"}">

			<div class="form-row">
				<label for="query">{translate key="search.searchAllCategories"}</label>
					{capture assign="queryFilter"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="query" filterValue=$query}{/capture}
					{if empty($queryFilter)}
						<input type="text" id="query" name="query" size="40" maxlength="255" value="{$query|escape}" class="textField" />
					{else}
						{$queryFilter}
					{/if}
					<input type="submit" value="{translate key="common.search"}" class="button" />
			</div>
			{if $siteSearch}
				<div class="form-row">
					<label for="searchJournal">{translate key="search.withinJournal"}</label>
					<select name="searchJournal" id="searchJournal" class="selectMenu">{html_options options=$journalOptions selected=$searchJournal}</select>
				</div>
			{/if}
			{if $hasActiveFilters}
				<div class="form-row">
					<h4>{translate key="search.activeFilters"}</h4>
				</div>
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="authors" filterValue=$authors key="search.author"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="title" filterValue=$title key="article.title"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="abstract" filterValue=$abstract key="search.abstract"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="galleyFullText" filterValue=$galleyFullText key="search.fullText"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="suppFiles" filterValue=$suppFiles key="article.suppFiles"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterType="date" filterName="dateFrom" filterValue=$dateFrom startYear=$startYear endYear=$endYear key="search.dateFrom"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterType="date" filterName="dateTo" filterValue=$dateTo startYear=$startYear endYear=$endYear key="search.dateTo"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="discipline" filterValue=$discipline key="search.discipline"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="subject" filterValue=$subject key="search.subject"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="type" filterValue=$type key="search.typeMethodApproach"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="coverage" filterValue=$coverage key="search.coverage"}
				{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="indexTerms" filterValue=$indexTerms key="search.indexTermsLong"}
			{/if}
		
		{if $hasEmptyFilters}
			{capture assign="emptyFilters"}
				<div class="search-filters">
					{if empty($authors) || empty($title) || empty($abstract) || empty($galleyFullText) || empty($suppFiles)}
						<h4>{translate key="search.searchCategories"}</h4>
					<div class="form-subrow">
						<div class="form-group">
							{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="authors" filterValue=$authors key="search.author"}
						</div>
						<div class="form-group">
							{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="title" filterValue=$title key="article.title"}
						</div>
						<div class="form-group">
							{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="abstract" filterValue=$abstract key="search.abstract"}
						</div>
						<div class="form-group">
							{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="galleyFullText" filterValue=$galleyFullText key="search.fullText"}
						</div>
						<div class="form-group">
							{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="suppFiles" filterValue=$suppFiles key="article.suppFiles"}
						</div>
					</div>
					{/if}

					{if $dateFrom == '--' || $dateTo == '--'}
						<h4>{translate key="search.date"}</h4>
						<div class="form-subrow">
							<div class="form-group">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterType="date" filterName="dateFrom" filterValue=$dateFrom startYear=$startYear endYear=$endYear key="search.dateFrom"}</div>
						
							<div class="form-row">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterType="date" filterName="dateTo" filterValue=$dateTo startYear=$startYear endYear=$endYear key="search.dateTo"}</div>
						</div>
					{/if}

					{if empty($discipline) || empty($subject) || empty($type) || empty($coverage)}
						<h4>{translate key="search.indexTerms"}</h4>
						<div class="form-subrow">
							<div class="form-group">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="discipline" filterValue=$discipline key="search.discipline"}</div>
							<div class="form-group">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="subject" filterValue=$subject key="search.subject"}</div>
							<div class="form-group">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="type" filterValue=$type key="search.typeMethodApproach"}</div>
							<div class="form-group">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="coverage" filterValue=$coverage key="search.coverage"}</div>
							<div class="form-group">{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="indexTerms" filterValue=$indexTerms key="search.indexTermsLong"}</div>
						</div>
						
					{/if}
				<div class="buttons">
					<input type="submit" value="{translate key="common.search"}" class="button" />
				</div>
			</div>
			{/capture}
			{include file="controllers/extrasOnDemand.tpl" id="emptyFilters" moreDetailsText="search.advancedSearchMore" lessDetailsText="search.advancedSearchLess" extraContent=$emptyFilters}
		{/if}
	</form>
</div>


{call_hook name="Templates::Search::SearchResults::PreResults"}

{if $currentJournal}
	{assign var=numCols value=3}
{else}
	{assign var=numCols value=4}
{/if}

<section id="results" class="section">

		{iterate from=results item=result}
			{assign var=publishedArticle value=$result.publishedArticle}
			{assign var=article value=$result.article}
			{assign var=issue value=$result.issue}
			{assign var=issueAvailable value=$result.issueAvailable}
			{assign var=journal value=$result.journal}
			{assign var=section value=$result.section}
			<article class="search__result">
				<h4>{$article->getLocalizedTitle()|strip_unsafe_html}</h4>
				{if !$currentJournal}
					<div class="search__result__issue">
						<a href="{url journal=$journal->getPath()}">{$journal->getLocalizedTitle()|escape}</a>
					</div>
				{/if}
				<div class="search__result__issue">
					<a href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)}">{$issue->getIssueIdentification()|escape}</a>
				</div>

				<div class="search__result__author">
				{foreach from=$article->getAuthors() item=authorItem name=authorList}
					{$authorItem->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
				{/foreach}
				</div>
				

					{if $publishedArticle->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN|| $issueAvailable}
						{assign var=hasAccess value=1}
					{else}
						{assign var=hasAccess value=0}
					{/if}
					{if $publishedArticle->getLocalizedAbstract() != ""}
						{assign var=hasAbstract value=1}
					{else}
						{assign var=hasAbstract value=0}
					{/if}
					<div class="search__result__access">
					{if !$hasAccess || $hasAbstract}
					
						<a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)}" class="file">
							{if !$hasAbstract}
								{translate key="article.details"}
							{else}
								{translate key="article.abstract"}
							{/if}
						</a>
					
					{/if}
					{if $hasAccess}
						{foreach from=$publishedArticle->getGalleys() item=galley name=galleyList}
							&nbsp;<a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)|to_array:$galley->getBestGalleyId($journal)}" class="file">{$galley->getGalleyLabel()|escape}</a>
						{/foreach}
					{/if}
					</div>
					{call_hook name="Templates::Search::SearchResults::AdditionalArticleLinks" articleId=$publishedArticle->getId()}

			</article>
			{call_hook name="Templates::Search::SearchResults::AdditionalArticleInfo" articleId=$publishedArticle->getId() numCols=$numCols|escape}
		{/iterate}

		{if $results->wasEmpty()}
					{if $error}
						{$error|escape}
					{else}
						{translate key="search.noResults"}
					{/if}
		{else}
			<div class="listing-pager">
				{page_info iterator=$results}
				{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText suppFiles=$suppFiles discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
			</div>
		{/if}
</section>

<section class="search__instructions">
{capture assign="syntaxInstructions"}{call_hook name="Templates::Search::SearchResults::SyntaxInstructions"}{/capture}
	{if empty($syntaxInstructions)}
		{translate key="search.syntaxInstructions"}
	{else}
		{* Must be properly escaped in the controller as we potentially get HTML here! *}
		{$syntaxInstructions}
	{/if}
</section>

{include file="common/footer.tpl"}

