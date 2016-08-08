{**
 * templates/manager/categories/categories.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of categories in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="admin.categories"}
{assign var="pageId" value="admin.categories"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveCategory"); });
{/literal}
</script>

<form action="{url op="setCategoriesEnabled"}" method="post">
	<p>{translate key="admin.categories.enable.description"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" id="categoriesEnabledOff" {if !$categoriesEnabled}checked="checked" {/if}name="categoriesEnabled" value="0"/>&nbsp;<label for="categoriesEnabledOff">{translate key="admin.categories.disableCategories"}</label>
		</div>
		<div class="form-group">
			<input type="radio" id="categoriesEnabledOn" {if $categoriesEnabled}checked="checked" {/if}name="categoriesEnabled" value="1"/>&nbsp;<label for="categoriesEnabledOn">{translate key="admin.categories.enableCategories"}</label>
		</div>
	</div>
	<input type="submit" value="{translate key="common.record"}" class="button"/>
</form>

<div id="categories">

<table class="listing" id="dragTable">
	<thead>
		<tr>
			<th>{translate key="admin.categories.name"}</th>
			<th>{translate key="common.action"}</th>
		</tr>
	<thead>
	<tbody>
		{iterate from=categories item=category key=categoryId}
			<tr id="category-{$categoryId|escape}">
				<td class="drag">
					{$category|escape}
				</td>
				<td>
					<a href="{url op="editCategory" path=$categoryId}" class="button button--small">{translate key="common.edit"}</a>&nbsp;
					<a href="{url op="deleteCategory" path=$categoryId}" onclick="return confirm('{translate|escape:"jsparam" key="admin.categories.confirmDelete"}')" class="button button--small button--cancel">{translate key="common.delete"}</a>&nbsp;
					<a href="{url op="moveCategory" d=u id=$categoryId}">&uarr;</a>&nbsp;<a href="{url op="moveCategory" d=d id=$categoryId}">&darr;</a>
				</td>
			</tr>
		{/iterate}
	</tbody>

{if $categories->wasEmpty()}
	<tr>
		<td>{translate key="admin.categories.noneCreated"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td>{page_info iterator=$categories}</td>
		<td>{page_links anchor="categories" name="categories" iterator=$categories}</td>
	</tr>
{/if}
</table>

<div class="buttons">
	<a href="{url op="createCategory"}" class="button">{translate key="admin.categories.create"}</a>
</div>
</div>

{include file="common/footer.tpl"}

