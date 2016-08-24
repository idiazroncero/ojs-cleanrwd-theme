{**
 * templates/sectionEditor/setDueDate.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to set the due date for a review.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.dueDate"}
{include file="common/header.tpl"}
{/strip}
<div id="setDueDate">
<h3>{translate key="editor.article.designateDueDate"}</h3>

<p>{translate key="editor.article.designateDueDateDescription"}</p>

<form method="post" action="{url op=$actionHandler path=$articleId|to_array:$reviewId}">

		<div class="form-row">
			<p class="label">{translate key="editor.article.todaysDate"}</p>
			{$todaysDate|escape}
		</div>
		<div class="form-row">
			<p class="label">{translate key="editor.article.requestedByDate"}</p>
				<input type="text" size="11" maxlength="10" name="dueDate" value="{if $dueDate}{$dueDate|date_format:"%Y-%m-%d"}{/if}" class="textField" onfocus="this.form.numWeeks.value=''" />
				<p class="instruct">{translate key="editor.article.dueDateFormat"}</p>
		</div>
		<p class="form-row">{translate key="common.or"}</p>
		<div class="form-row">
			<p class="label">{translate key="editor.article.numberOfWeeks"}</p>
			<input type="text" name="numWeeks" value="{if not $dueDate}{$numWeeksPerReview|escape}{/if}" size="3" maxlength="2" class="textField" onfocus="this.form.dueDate.value=''" />
		</div>

<div class="buttons">
	<input type="submit" value="{translate key="common.continue"}" class="button defaultButton" />
	<input type="button" class="button button--cancel" onclick="history.go(-1)" value="{translate key="common.cancel"}" />
</div>

</form>
</div>
{include file="common/footer.tpl"}

