{**
 * templates/manager/statistics/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display the statistics & reporting page.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.statistics"}
{include file="common/header.tpl"}
{/strip}

<br/>

{include file="manager/statistics/statistics.tpl"}

<div class="separator">&nbsp;</div>

<br/>

<div id="reports">
	<h3>{translate key="manager.statistics.reports"}</h3>
	<p>{translate key="manager.statistics.reports.description"}</p>
	
	<ul>
	{foreach from=$reportPlugins key=key item=plugin}
		<li><a href="{url op="report" path=$plugin->getName()|escape}">{$plugin->getDisplayName()|escape}</a></li>
	{/foreach}
	</ul>
	{if !empty($availableMetricTypes)}	
		<p><a href="{url op="reportGenerator"}">{translate key="manager.statistics.reports.generateReport"}</a></p>
	{/if}
</div>
{include file="common/footer.tpl"}

