{**
 * templates/sectionEditor/submissionEventLogEntry.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show a single event log entry.
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
</ul>

<ul class="menu">
	<li><a href="{url op="submissionEventLog" path=$submission->getId()}">{translate key="submission.history.submissionEventLog"}</a></li>
	<li><a href="{url op="submissionEmailLog" path=$submission->getId()}">{translate key="submission.history.submissionEmailLog"}</a></li>
	<li><a href="{url op="submissionNotes" path=$submission->getId()}">{translate key="submission.history.submissionNotes"}</a></li>
</ul>

{include file="sectionEditor/submission/summary.tpl"}

<div class="separator"></div>
<div id="submissionEventLog">
<h3>{translate key="submission.history.submissionEventLog"}</h3>

<dl>
	<dt>{translate key="common.id"}</dt>
	<dd>{$logEntry->getId()}</dd>

	<dt>{translate key="common.date"}</dt>
	<dd>{$logEntry->getDateLogged()|date_format:$datetimeFormatLong}</dd>

	<dt>{translate key="common.user"}</dt>
	<dd>
			{assign var=emailString value=$logEntry->getUserFullName()|concat:" <":$logEntry->getUserEmail():">"}
			{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$logEntry->getEventTitle()|translate articleId=$submission->getId()}
			{$logEntry->getUserFullName()|escape} {icon name="mail" url=$url}
	</dd>

	<dt>{translate key="common.event"}</dt>
	<dd>
			<strong>{translate key=$logEntry->getEventTitle()}</strong>
			
			{$logEntry->getMessage()|strip_unsafe_html|nl2br}
	</dd>
</dl>

<div class="buttons">
	{if $isEditor}
		<a href="{url page="editor" op="clearSubmissionEventLog" path=$submission->getId()|to_array:$logEntry->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.event.confirmDeleteLogEntry"}')" class="button button--cancel">{translate key="submission.event.deleteLogEntry"}</a>
	{/if}
	<a class="button" href="{url op="submissionEventLog" path=$submission->getId()}">{translate key="submission.event.backToEventLog"}</a>
</div>

{include file="common/footer.tpl"}

