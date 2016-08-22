{**
 * templates/sectionEditor/selectReviewForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Assign a review form to a review.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.article.reviewForms"}
{include file="common/header.tpl"}
{/strip}

<h3>{translate key="editor.article.selectReviewForm"}</h3>

<section class="section" id="assignReviewForm">
<table class="listing">
	<thead>
		<tr>
			<th>{translate key="manager.reviewForms.title"}</th>
			<th>{translate key="common.action"}</th>
		</tr>
	</thead>
	<tbody>
{iterate from=reviewForms item=reviewForm name=reviewForms}
	<tr >
		<td data-title='{translate key="manager.reviewForms.title"}'>{$reviewForm->getLocalizedTitle()|escape}</td>
		<td data-title='{translate key="common.action"}' >
			{if $assignedReviewFormId == $reviewForm->getId()}{translate key="common.alreadyAssigned"}{else}<a href="{url op="selectReviewForm" path=$articleId|to_array:$reviewId:$reviewForm->getId()}" class="button button--small">{translate key="common.assign"}</a>{/if}&nbsp;<a href="{url op="previewReviewForm" path=$reviewId|to_array:$reviewForm->getId()}" class="button button--small">{translate key="common.preview"}</a>
	</tr>
{/iterate}

{if $reviewForms->wasEmpty()}
	<tr>
		<td colspan="2" class="nodata">{translate key="manager.reviewForms.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td>{page_info iterator=$reviewForms}</td>
		<td>{page_links anchor="reviewForms" name="reviewForms" iterator=$reviewForms}</td>
	</tr>
{/if}
	</tbody>
</table>
</section>

{include file="common/footer.tpl"}

