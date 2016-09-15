{**
 * templates/subscription/subscriptionTypes.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of subscription types in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.subscriptionTypes"}
{assign var="pageId" value="manager.subscriptionTypes"}
{include file="common/header.tpl"}
{/strip}
<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#subscriptionTypesTable", "moveSubscriptionType"); });
{/literal}
</script>

<ul class="menu">
	<li><a href="{url op="subscriptionsSummary"}">{translate key="manager.subscriptions.summary"}</a></li>
	<li><a href="{url op="subscriptions" path="individual"}">{translate key="manager.individualSubscriptions"}</a></li>
	<li><a href="{url op="subscriptions" path="institutional"}">{translate key="manager.institutionalSubscriptions"}</a></li>
	<li class="current"><a href="{url op="subscriptionTypes"}">{translate key="manager.subscriptionTypes"}</a></li>
	<li><a href="{url op="subscriptionPolicies"}">{translate key="manager.subscriptionPolicies"}</a></li>
	<li><a href="{url op="payments"}">{translate key="manager.payments"}</a></li>
</ul>



<div id="subscriptionTypes">
<table class="listing" id="subscriptionTypesTable">
	<thead>
		<th>{translate key="manager.subscriptionTypes.name"}</th>
		<th>{translate key="manager.subscriptionTypes.subscriptions"}</th>
		<th>{translate key="manager.subscriptionTypes.duration"}</th>
		<th>{translate key="manager.subscriptionTypes.cost"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	<tbody>
{iterate from=subscriptionTypes item=subscriptionType}
	<tr  id="subtype-{$subscriptionType->getTypeId()}" class="data">
		<td data-title='{translate key="manager.subscriptionTypes.name"}' class="drag">{$subscriptionType->getSubscriptionTypeName()|escape}</td>
		<td data-title='{translate key="manager.subscriptionTypes.subscriptions"}' class="drag">{if $subscriptionType->getInstitutional()}{translate key="manager.subscriptionTypes.institutional"}{else}{translate key="manager.subscriptionTypes.individual"}{/if}</td>
		<td data-title='{translate key="manager.subscriptionTypes.duration"}' class="drag">{$subscriptionType->getDurationYearsMonths()|escape}</td>
		<td data-title='{translate key="manager.subscriptionTypes.cost"}' class="drag">{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()})</td>
		<td data-title='{translate key="common.action"}'><a href="{url op="moveSubscriptionType" id=$subscriptionType->getTypeId() dir=u}" class="action">&uarr;</a>&nbsp;<a href="{url op="moveSubscriptionType" id=$subscriptionType->getTypeId() dir=d}" class="action">&darr;</a>&nbsp;|&nbsp;<a href="{url op="editSubscriptionType" path=$subscriptionType->getTypeId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSubscriptionType" path=$subscriptionType->getTypeId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.subscriptionTypes.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
</tbody>
{if $subscriptionTypes->wasEmpty()}
	<tr>
		<td colspan="5" class="nodata">{translate key="manager.subscriptionTypes.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td align="left">{page_info iterator=$subscriptionTypes}</td>
		<td colspan="2" align="right">{page_links anchor="subscriptionTypes" name="subscriptionTypes" iterator=$subscriptionTypes}</td>
	</tr>
{/if}
</table>

<div class="buttons">
	<a href="{url op="createSubscriptionType"}" class="button">{translate key="manager.subscriptionTypes.create"}</a>
</div>
</div>

{include file="common/footer.tpl"}

