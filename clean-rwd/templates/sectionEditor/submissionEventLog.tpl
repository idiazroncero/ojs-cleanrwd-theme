{**
 * templates/sectionEditor/submissionEventLog.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show submission event log page.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="submission.eventLog"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
	<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	{if $canReview}<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>{/if}
	{if $canEdit}<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>{/if}
	<li><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
	<li><a href="{url op="submissionCitations" path=$submission->getId()}">{translate key="submission.citations"}</a></li>
</ul>

<ul class="menu">
	<li class="current"><a href="{url op="submissionEventLog" path=$submission->getId()}">{translate key="submission.history.submissionEventLog"}</a></li>
	<li><a href="{url op="submissionEmailLog" path=$submission->getId()}">{translate key="submission.history.submissionEmailLog"}</a></li>
	<li><a href="{url op="submissionNotes" path=$submission->getId()}">{translate key="submission.history.submissionNotes"}</a></li>
</ul>

{include file="sectionEditor/submission/summary.tpl"}

<div id="eventLogEntries">
<h3>{translate key="submission.history.submissionEventLog"}</h3>

<table class="listing listing--wide">
	<thead>
		<tr >
			<th>{translate key="common.date"}</th>
			<th>{translate key="common.user"}</th>
			<th>{translate key="common.event"}</th>
			<th>{translate key="common.action"}</th>
		</tr>
	</thead>
	<tbody>
{iterate from=eventLogEntries item=logEntry}
	<tr >
		<td data-title='{translate key="common.date"}'>{$logEntry->getDateLogged()|date_format:$dateFormatShort}</td>
		<td data-title='{translate key="common.user"}'>
			{assign var=emailString value=$logEntry->getUserFullName()|concat:" <":$logEntry->getUserEmail():">"}
			{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$logEntry->getEventTitle()|translate articleId=$submission->getId()}
			{$logEntry->getUserFullName()|escape} {icon name="mail" url=$url}
		</td>
		<td data-title='{translate key="common.event"}'>
			{translate key=$logEntry->getEventTitle()}
			
			{$logEntry->getTranslatedMessage()|strip_tags|truncate:60:"..."}
		</td>
		<td data-title='{translate key="common.action"}' align="right"><a href="{url op="submissionEventLog" path=$submission->getId()|to_array:$logEntry->getId()}" class="action">{translate key="common.view"}</a>{if $isEditor}&nbsp;|&nbsp;<a href="{url page="editor" op="clearSubmissionEventLog" path=$submission->getId()|to_array:$logEntry->getId()}" class="action" onclick="return confirm('{translate|escape:"jsparam" key="submission.event.confirmDeleteLogEntry"}')">{translate key="common.delete"}</a>{/if}</td>
	</tr>
{/iterate}
{if $eventLogEntries->wasEmpty()}
	<tr >
		<td colspan="4" class="nodata">{translate key="submission.history.noLogEntries"}</td>
	</tr>
{else}
	<tr class="listing--pager">
		<td colspan="2" align="left">{page_info iterator=$eventLogEntries}</td>
		<td colspan="2" align="right">{page_links anchor="eventLogEntries" name="eventLogEntries" iterator=$eventLogEntries}</td>
	</tr>
{/if}
	</tbody>
</table>

{if $isEditor}
<div class="buttons">
	<a href="{url page="editor" op="clearSubmissionEventLog" path=$submission->getId()}" class="button" onclick="return confirm('{translate|escape:"jsparam" key="submission.event.confirmClearLog"}')">{translate key="submission.history.clearLog"}</a>
</div>
{/if}
</div>
{include file="common/footer.tpl"}

