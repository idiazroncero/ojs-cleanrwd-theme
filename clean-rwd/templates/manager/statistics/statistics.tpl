{**
 * templates/manager/statistics/statistics.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the statistics table.
 *
 *}
{* WARNING: This page should be kept roughly synchronized with the
   implementation of reader statistics in the About page.          *}

<section id="statistics">
<h3>{translate key="manager.statistics.statistics"}</h3>
<p>{translate key="manager.statistics.statistics.description"}</p>
<div id="selectSections">
<form action="{url op="saveStatisticsSettings"}" method="post">
	{if count($availableMetricTypes) > 1}
		<h3>{translate key="defaultMetric.title"}</h3>
		<p>{translate key="manager.statistics.defaultMetricDescription"}</p>
		<div id="defaultMetricSelection">
			<div class="form-row">
					{fieldLabel name="defaultMetricType" key="defaultMetric.availableMetrics"}
						<select name="defaultMetricType" class="selectMenu" id="defaultMetricType">
						{foreach from=$availableMetricTypes key=metricType item=displayName}
							<option value="{$metricType|escape}"{if $metricType == $defaultMetricType} selected="selected"{/if}>{$displayName|escape}</option>
						{/foreach}
						</select>
			</div>
		</div>
	{/if}
	<div class="form-row">
		<p class="label">{translate key="manager.statistics.statistics.selectSections"}</p>
		<select name="sectionIds[]" class="selectMenu" multiple="multiple" size="5">
			{foreach from=$sections item=section}
				<option {if in_array($section->getId(), $sectionIds)}selected="selected" {/if}value="{$section->getId()}">{$section->getLocalizedTitle()}</option>
			{/foreach}
		</select>&nbsp;
		<input type="submit" value="{translate key="common.record"}" class="button defaultButton"/>
	</div>
</form>
</div>


<form action="{url op="savePublicStatisticsList"}" method="post">

	<h4>{translate key="common.year"}
	{strip}
		{if $statisticsYear > $firstYear}
			<a class="action" href="{url statisticsYear=$statisticsYear-1}"><i class="fa fa-chevron-circle-left"></i> <!-- {translate key="navigation.previousPage"} --></a>&nbsp;
		{/if}
		{$statisticsYear|escape}
		{if $statisticsYear < $lastYear}
			&nbsp;<a class="action" href="{url statisticsYear=$statisticsYear+1}">
			<i class="fa fa-chevron-circle-right"></i>
			<!-- {translate key="navigation.nextPage"} --></a>
		{/if}
	{/strip}
	</h4>
	
<dl>
	<dt>
		<label for="statNumPublishedIssues">{translate key="manager.statistics.statistics.numIssues"}</label>
		<input type="checkbox" id="statNumPublishedIssues" name="statNumPublishedIssues" {if $statNumPublishedIssues}checked="checked" {/if}/>
	</dt>
	<dd>{$issueStatistics.numPublishedIssues}</dd>

	<dt>
		<label for="statItemsPublished">{translate key="manager.statistics.statistics.itemsPublished"}</label>
		<input type="checkbox" id="statItemsPublished" name="statItemsPublished" {if $statItemsPublished}checked="checked" {/if}/>
	</dt>
	<dd>
		{$articleStatistics.numPublishedSubmissions}
	</dd>

	<dt>
		<label for="statNumSubmissions">{translate key="manager.statistics.statistics.numSubmissions"}</label>
		<input type="checkbox" id="statNumSubmissions" name="statNumSubmissions" {if $statNumSubmissions}checked="checked" {/if}/>
	</dt>
	<dd>
		{$articleStatistics.numSubmissions}
	</dd>

	<dt>
		<label for="statPeerReviewed">{translate key="manager.statistics.statistics.peerReviewed"}</label>
		<input type="checkbox" id="statPeerReviewed" name="statPeerReviewed" {if $statPeerReviewed}checked="checked" {/if}/>
	</dt>
	<dd>
		{$limitedArticleStatistics.numReviewedSubmissions}
	</dd>

	<dt>
		<label for="statCountAccept">{translate key="manager.statistics.statistics.count.accept"}</label>
		<input type="checkbox" id="statCountAccept" name="statCountAccept" {if $statCountAccept}checked="checked" {/if}/>
	</dt>
	<dd>
		{translate key="manager.statistics.statistics.count.value" count=$limitedArticleStatistics.submissionsAccept percentage=$limitedArticleStatistics.submissionsAcceptPercent}
	</dd>

	<dt>
		<label for="statCountDecline">{translate key="manager.statistics.statistics.count.decline"}</label>
		<input type="checkbox" id="statCountDecline" name="statCountDecline" {if $statCountDecline}checked="checked" {/if}/>
	</dt>
	<dd>{translate key="manager.statistics.statistics.count.value" count=$limitedArticleStatistics.submissionsDecline percentage=$limitedArticleStatistics.submissionsDeclinePercent}</dd>

	<dt>
		<label for="statCountRevise">{translate key="manager.statistics.statistics.count.revise"}</label>
		<input type="checkbox" id="statCountRevise" name="statCountRevise" {if $statCountRevise}checked="checked" {/if}/>
	</dt>
	<dd>{translate key="manager.statistics.statistics.count.value" count=$limitedArticleStatistics.submissionsRevise percentage=$limitedArticleStatistics.submissionsRevise}</td>
	</dd>

	<dt>
		<label for="statDaysPerReview">{translate key="manager.statistics.statistics.daysPerReview"}</label>
		<input type="checkbox" id="statDaysPerReview" name="statDaysPerReview" {if $statDaysPerReview}checked="checked" {/if}/>
	</dt>
	<dd>
		{assign var=daysPerReview value=$reviewerStatistics.daysPerReview}
		{math equation="round($daysPerReview)"}
	</dd>

	<dt>
		<label for="statDaysToPublication">{translate key="manager.statistics.statistics.daysToPublication"}</label>
		<input type="checkbox" id="statDaysToPublication" name="statDaysToPublication" {if $statDaysToPublication}checked="checked" {/if}/>
	</dt>
	<dd>
		{$limitedArticleStatistics.daysToPublication}
	</dd>

	<dt>
		<label for="statRegisteredUsers">{translate key="manager.statistics.statistics.registeredUsers"}</label>
		<input type="checkbox" id="statRegisteredUsers" name="statRegisteredUsers" {if $statRegisteredUsers}checked="checked" {/if}/>
	</dt>
	<dd>
		{translate key="manager.statistics.statistics.totalNewValue" numTotal=$allUserStatistics.totalUsersCount numNew=$userStatistics.totalUsersCount}
	</dd>

	<dt>
		<label for="statRegisteredReaders">{translate key="manager.statistics.statistics.registeredReaders"}</label>
		<input type="checkbox" id="statRegisteredReaders" name="statRegisteredReaders" {if $statRegisteredReaders}checked="checked" {/if}/>
	</dt>
	<dd>
		{translate key="manager.statistics.statistics.totalNewValue" numTotal=$allUserStatistics.reader|default:"0" numNew=$userStatistics.reader|default:"0"}
	</dd>

	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
		<dt>
			<label for="statSubscriptions">{translate key="manager.statistics.statistics.subscriptions"}</label>
			<input type="checkbox" id="statSubscriptions" name="statSubscriptions" {if $statSubscriptions}checked="checked" {/if}/>
		</dt>
		{foreach from=$allSubscriptionStatistics key=type_id item=stats}
		<dd>
			{$stats.name}:{translate key="manager.statistics.statistics.totalNewValue" numTotal=$stats.count|default:"0" numNew=$subscriptionStatistics.$type_id.count|default:"0"}
		</dd>
		{/foreach}
	{/if}

	<dt>
		<label for="statViews">{translate key="manager.statistics.statistics.articleViews"}</label>
		<input type="checkbox" id="statViews" name="statViews" {if $statViews}checked="checked" {/if}/>
	</dt>
</dl>

<p>{translate key="manager.statistics.statistics.note"}</p>

<p>{translate key="manager.statistics.statistics.makePublic"}</p>
<div class="buttons">
	<input type="submit" class="button defaultButton" value="{translate key="common.record"}"/>
</div>
</form>
</section>
