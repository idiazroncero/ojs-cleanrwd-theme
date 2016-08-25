{**
 * templates/sectionEditor/submissionEmailLog.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show submission email log page.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="submission.emailLog"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
	<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	{if $canReview}<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>{/if}
	{if $canEdit}<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>{/if}
	<li><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
</ul>

<ul class="menu">
	<li><a href="{url op="submissionEventLog" path=$submission->getId()}">{translate key="submission.history.submissionEventLog"}</a></li>
	<li class="current"><a href="{url op="submissionEmailLog" path=$submission->getId()}">{translate key="submission.history.submissionEmailLog"}</a></li>
	<li><a href="{url op="submissionNotes" path=$submission->getId()}">{translate key="submission.history.submissionNotes"}</a></li>
</ul>

{include file="sectionEditor/submission/summary.tpl"}

<div id="emailLogEntries">
<h3>{translate key="submission.history.submissionEmailLog"}</h3>

<table class="listing listing--wide">
	<thead>
	<tr class="heading" >
		<th>{translate key="common.date"}</th>
		<th>{translate key="email.sender"}</th>
		<th>{translate key="email.recipients"}</th>
		<th>{translate key="common.subject"}</th>
		<th>{translate key="common.action"}</th>
	</tr>
	</thead>
	<tbody>
{iterate from=emailLogEntries item=logEntry}
	<tr >
		<td data-title='{translate key="common.date"}'>{$logEntry->getDateSent()|date_format:$dateFormatShort}</td>
		<td data-title='{translate key="email.sender"}'>{$logEntry->getFrom()|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="email.recipients"}'>{$logEntry->getRecipients()|truncate:40:"..."|escape}</td>
		<td data-title='{translate key="common.subject"}'>{$logEntry->getSubject()|truncate:60:"..."|escape}</td>
		<td data-title='{translate key="common.action"}'><a href="{url op="submissionEmailLog" path=$submission->getId()|to_array:$logEntry->getId()}" class="action">{translate key="common.view"}</a>{if $isEditor}&nbsp;|&nbsp;<a href="{url page="editor" op="clearSubmissionEmailLog" path=$submission->getId()|to_array:$logEntry->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.email.confirmDeleteLogEntry"}')" class="action">{translate key="common.delete"}</a>{/if}</td>
	</tr>
{/iterate}
{if $emailLogEntries->wasEmpty()}
	<tr >
		<td colspan="5" class="nodata">{translate key="submission.history.noLogEntries"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="3" align="left">{page_info iterator=$emailLogEntries}</td>
		<td colspan="2" align="right">{page_links anchor="emailLogEntries" name="emailLogEntries" iterator=$emailLogEntries}</td>
	</tr>
{/if}
</tbody>
</table>

{if $isEditor}
<div class="buttons">
	<a class="button button--cancel" href="{url page="editor" op="clearSubmissionEmailLog" path=$submission->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.email.confirmClearLog"}')">{translate key="submission.history.clearLog"}</a>
</div>
{/if}
</div>
{include file="common/footer.tpl"}

