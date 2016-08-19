{**
 * templates/editor/submissions.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor submissions page(s).
 *
 *}
{strip}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{url|assign:"currentUrl" page="editor"}
{include file="common/header.tpl"}
{/strip}
{/strip}

<ul class="menu">
	<li{if $pageToDisplay == "submissionsUnassigned"} class="current"{/if}><a href="{url op="submissions" path="submissionsUnassigned"}">{translate key="common.queue.short.submissionsUnassigned"}</a></li>
	<li{if $pageToDisplay == "submissionsInReview"} class="current"{/if}><a href="{url op="submissions" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a></li>
	<li{if $pageToDisplay == "submissionsInEditing"} class="current"{/if}><a href="{url op="submissions" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a></li>
	<li{if $pageToDisplay == "submissionsArchives"} class="current"{/if}><a href="{url op="submissions" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
</ul>

<form action="#">
<div class="form-row">
	{translate key="editor.submissions.assignedTo"}:&nbsp;<select name="filterEditor" onchange="location.href='{url|escape:"javascript" path=$pageToDisplay searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField filterEditor="EDITOR" escape=false}'.replace('EDITOR', this.options[this.selectedIndex].value)" size="1" class="selectMenu">{html_options options=$editorOptions selected=$filterEditor}</select>
	{translate key="editor.submissions.inSection"}:&nbsp;<select name="filterSection" onchange="location.href='{url|escape:"javascript" path=$pageToDisplay searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField filterSection="SECTION_ID" escape=false}'.replace('SECTION_ID', this.options[this.selectedIndex].value)" size="1" class="selectMenu">{html_options options=$sectionOptions selected=$filterSection}</select>
</div>
</form>

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

<form method="post" id="submit" action="{url op="submissions" path=$pageToDisplay}">
	
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

<!-- 	<input type="hidden" name="sort" value="id"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
	<select name="searchField" size="1" class="selectMenu">
		{html_options_translate options=$fieldOptions selected=$searchField}
	</select>
	<select name="searchMatch" size="1" class="selectMenu">
		<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
		<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
		<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
	</select>
	<input type="text" size="15" name="search" class="textField" value="{$search|escape}" />
	
	<select name="dateSearchField" size="1" class="selectMenu">
		{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
	</select>
	{translate key="common.between"}
	{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
	{translate key="common.and"}
	{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
	<input type="hidden" name="dateToHour" value="23" />
	<input type="hidden" name="dateToMinute" value="59" />
	<input type="hidden" name="dateToSecond" value="59" />
	
	<input type="submit" value="{translate key="common.search"}" class="button" /> -->
</form>

{if ($pageToDisplay == "submissionsInReview")}

<section class="section instruct">
<h4>{translate key="common.notes"}</h4>
{translate key="editor.submissionReview.notes"}
</section class="section">
{elseif ($pageToDisplay == "submissionsInEditing")}

<section class="section instruct">
<h4>{translate key="common.notes"}</h4>
{translate key="editor.submissionEditing.notes"}
</section class="section">
{/if}

{include file="editor/$pageToDisplay.tpl"}



{include file="common/footer.tpl"}

