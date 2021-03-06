{**
 * templates/manager/reviewForms/reviewForms.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of unpublished review forms in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.reviewForms"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveReviewForm"); });
{/literal}
</script>

<p>{translate key="manager.reviewForms.list.description"}</p>

<div id="reviewForms">
<table class="listing" id="dragTable">
	<thead>
		<th>{translate key="manager.reviewForms.title"}</th>
		<th>{translate key="manager.reviewForms.inReview"}</th>
		<th>{translate key="manager.reviewForms.completed"}</th>
		<th>{translate key="common.action"}</th>
	</thead>
	<tbody>
{iterate from=reviewForms item=reviewForm name=reviewForms}
{assign var=reviewFormId value=$reviewForm->getId()}
{if $completeCounts[$reviewFormId] == 0 && $incompleteCounts[$reviewFormId] == 0}
	{assign var=canEdit value=1}
{else}
	{assign var=canEdit value=0}
{/if}

	<tr id="reviewform-{$reviewForm->getId()}">
		<td class="drag">{$reviewForm->getLocalizedTitle()|escape}</td>
		<td class="drag">{$incompleteCounts[$reviewFormId]}</td>
		<td class="drag">{$completeCounts[$reviewFormId]}</td>
		<td>
			{if $canEdit}<a href="{url op="editReviewForm" path=$reviewForm->getId()}" class="button button--small">{translate key="common.edit"}</a>&nbsp;{/if}
			{strip}
				{if $reviewForm->getActive()}
					<a href="{url op="deactivateReviewForm" path=$reviewForm->getId()}" class="button button--small">{translate key="common.deactivate"}</a>
				{else}
					<a href="{url op="activateReviewForm" path=$reviewForm->getId()}" class="button button--small">{translate key="common.activate"}</a>
				{/if}
				&nbsp;
			{/strip}
			{if !$canEdit}<a href="{url op="copyReviewForm" path=$reviewForm->getId()}" class="button button--small">{translate key="common.copy"}</a>&nbsp;{/if}
			<a href="{url op="previewReviewForm" path=$reviewForm->getId()}" class="button button--small">{translate key="common.preview"}</a>&nbsp;
			{if $canEdit}<a href="{url op="deleteReviewForm" path=$reviewForm->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.reviewForms.confirmDeleteUnpublished"}')" class="button button--small button--cancel">{translate key="common.delete"}</a>&nbsp;{/if}
			<a href="{url op="moveReviewForm" d=u id=$reviewForm->getId()}" class="action">&uarr;</a>&nbsp;<a href="{url op="moveReviewForm" d=d id=$reviewForm->getId()}" class="action">&darr;</a>
		</td>
	</tr>
{/iterate}

{if $reviewForms->wasEmpty()}
	<tr>
		<td colspan="4">{translate key="manager.reviewForms.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="2">{page_info iterator=$reviewForms}</td>
		<td colspan="2">{page_links anchor="reviewForms" name="reviewForms" iterator=$reviewForms}</td>
	</tr>
{/if}
	<tbody>
</table>

<div class="buttons">
	<a class="button" href="{url op="createReviewForm"}">{translate key="manager.reviewForms.create"}</a>
</div>
</div>
{include file="common/footer.tpl"}

