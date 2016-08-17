{**
 * templates/editor/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor index.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.home"}
{assign var="pageCrumbTitle" value="user.role.editor"}
{include file="common/header.tpl"}
{/strip}
<section id="articleSubmissions">
<h3>{translate key="article.submissions"}</h3>

<ul class="steplist">
	<li><a href="{url op="submissions" path="submissionsUnassigned"}">{translate key="common.queue.short.submissionsUnassigned"}</a>&nbsp;({if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if})</li>
	<li><a href="{url op="submissions" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a>&nbsp;({if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if})</li>
	<li><a href="{url op="submissions" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a>&nbsp;({if $submissionsCount[2]}{$submissionsCount[2]}{else}0{/if})</li>
	<li><a href="{url op="submissions" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
	{call_hook name="Templates::Editor::Index::Submissions"}
</ul>
</section>


{if !$dateFrom}
{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
{assign var="dateTo" value="--"}
{/if}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
	var submitForm = document.getElementById('submit');
	submitForm.sort.value = heading;
	submitForm.sortDirection.value = direction;
	submitForm.submit();
}
// -->
{/literal}
</script>

<form method="post" id="submit" action="{url path="search"}">
	{if $section}
		<div class="form-group">
			<input type="hidden" name="section" value="{$section|escape:"quotes"}"/>
		</div>
	{/if}
	
	<input type="hidden" name="sort" value="id"/>
	<input type="hidden" name="sortDirection" value="ASC"/>

	<div class="form-group">
		<select name="searchField" size="1" class="selectMenu">
			{html_options_translate options=$fieldOptions selected=$searchField}
		</select>
		<select name="searchMatch" size="1" class="selectMenu">
			<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
			<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
			<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
		</select>
		<input type="text" size="15" name="search" class="textField" value="{$search|escape}" />
	</div>
	
	<div class="form-group">
		<div class="form-group">
			<select name="dateSearchField" size="1" class="selectMenu">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		<div class="form-subrow">
			<div class="form-group">
				<label>{translate key="common.between"}</label>
				{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<div class="form-group">
				<label>{translate key="common.and"}</label>
				{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
		</div>
		
		
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
	</div>
	
	<div class="buttons">
		<input type="submit" value="{translate key="common.search"}" class="button" />
	</div>
</form>

{if $displayResults}
	<section class="section" id="submissions">

<table class="listing listing--wide">
	<thead>
		<tr>
		<th>{sort_search key="common.id" sort="id"}</th>
		<th><span class="disabled">{translate key="submission.date.mmdd"}</span><!-- {sort_search key="submissions.submit" sort="submitDate"} --></th>
		<th>{sort_search key="submissions.sec" sort="section"}</th>
		<th>{sort_search key="article.authors" sort="authors"}</th>
		<th>{sort_search key="article.title" sort="title"}</th>
		<th>{sort_search key="common.status" sort="status"}</th>
		</tr>
	</thead>
	
	<tbody>
	{iterate from=submissions item=submission}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<tr {if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
		<td data-title='{translate key="common.id"}'>{$submission->getId()}</td>
		<td class="nowrap" data-title='{translate key="submission.date.mmdd"}'>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td data-title='{translate key="submissions.sec"}'>{$submission->getSectionAbbrev()|escape}</td>
		<td data-title='{translate key="article.authors"}'>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="article.title"}'><a href="{url op="submission" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td style="width:33%" data-title='{translate key="common.status"}'>
			{assign var="status" value=$submission->getSubmissionStatus()}
			{if $status == STATUS_ARCHIVED}
				{translate key="submissions.archived"}
			{elseif $status == STATUS_PUBLISHED}
				{print_issue_id articleId=$submission->getId()}
			{elseif $status == STATUS_DECLINED}
				{translate key="submissions.declined"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
			{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
			{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
			{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
			{else}{* SUBMISSION_QUEUED -- between cracks? *}
				{translate key="submissions.queued"}
			{/if}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="3">{page_info iterator=$submissions}</td>
		<td colspan="3">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
	</tbody>
</table>
</section>
{else}



{/if}{* displayResults *}
<section class="section" id="issues">
<h3>{translate key="editor.navigation.issues"}</h3>

<ul>
	<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
	<li><a href="{url op="notifyUsers"}">{translate key="editor.notifyUsers"}</a></li>
	<li><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
	<li><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	{call_hook name="Templates::Editor::Index::Issues"}
</ul>
</section>

{call_hook name="Templates::Editor::Index::AdditionalItems"}

{include file="common/footer.tpl"}

