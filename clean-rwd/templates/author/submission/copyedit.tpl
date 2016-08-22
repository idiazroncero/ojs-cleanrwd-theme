{**
 * templates/author/submission/copyedit.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the copyediting table.
 *
 *}
<section class="section" id="copyedit">
<h3>{translate key="submission.copyediting"}</h3>

{if $currentJournal->getLocalizedSetting('copyeditInstructions') != ''}
<p>
	<i class="fa fa-info-circle"></i>
	<a href="javascript:openHelp('{url op="instructions" path="copy"}')" class="action">{translate key="submission.copyedit.instructions"}</a>
</p>
{/if}

{if $useCopyeditors}
<table class="data" width="100%">
	<tr>
		<td class="label" width="20%">{translate key="user.role.copyeditor"}</td>
		<td class="label" width="80%">{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL')}{$copyeditor->getFullName()|escape}{else}{translate key="common.none"}{/if}</td>
	</tr>
</table>
{/if}

<p>
	<i class="fa fa-info-circle"></i>
	<a href="{url op="viewMetadata" path=$submission->getId()}" class="action">{translate key="submission.reviewMetadata"}</a>
</p>

<table class="listing">
	<thead>
		<th colspan="2"></th>
		<th>{translate key="submission.request"}</th>
		<th>{translate key="submission.underway"}</th>
		<th>{translate key="submission.complete"}</th>
	</thead>
	<tbody>
	<tr>
		<td>1.</td>
		{assign var="copyeditInitialSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
		<td>{translate key="submission.copyedit.initialCopyedit"}</td>
		<td data-title='{translate key="submission.request"}'>{$copyeditInitialSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.underway"}'>{$copyeditInitialSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.complete"}'>{$copyeditInitialSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td colspan="5">
			{translate key="common.file"}:
			{if $copyeditInitialSignoff->getDateCompleted() && $initialCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditInitialSignoff->getFileId():$copyeditInitialSignoff->getFileRevision()}" class="file">{$initialCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$initialCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</td>
	</tr>
	<tr>
		<td>2.</td>
		{assign var="copyeditAuthorSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_AUTHOR')}
		<td>{translate key="submission.copyedit.editorAuthorReview"}</td>
		<td data-title='{translate key="submission.request"}'>{$copyeditAuthorSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.underway"}'>{$copyeditAuthorSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.complete"}'>
			{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()}
				{icon name="mail" disabled="disabled"}
			{else}
				{url|assign:"url" op="completeAuthorCopyedit" articleId=$submission->getId()}
				{translate|assign:"confirmMessage" key="common.confirmComplete"}
				{icon name="mail" onclick="return confirm('$confirmMessage')" url=$url}
			{/if}
			{$copyeditAuthorSignoff->getDateCompleted()|date_format:$dateFormatShort|default:""}
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="5">
			{translate key="common.file"}:
			{if $copyeditAuthorSignoff->getDateNotified() && $editorAuthorCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditAuthorSignoff->getFileId():$copyeditAuthorSignoff->getFileRevision()}" class="file">{$editorAuthorCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorAuthorCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
			
			<form method="post" action="{url op="uploadCopyeditVersion"}"  enctype="multipart/form-data">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="hidden" name="copyeditStage" value="author" />
				<input type="file" name="upload"{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()} disabled="disabled"{/if} class="uploadField" />
				<input type="submit" class="button" value="{translate key="common.upload"}"{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()} disabled="disabled"{/if} />
			</form>
		</td>
	</tr>
	<tr>
		<td>3.</td>
		{assign var="copyeditFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
		<td>{translate key="submission.copyedit.finalCopyedit"}</td>
		<td data-title='{translate key="submission.request"}'>{$copyeditFinalSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.underway"}'>{$copyeditFinalSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.complete"}'>{$copyeditFinalSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="5">
			{translate key="common.file"}:
			{if $copyeditFinalSignoff->getDateCompleted() && $finalCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditFinalSignoff->getFileId():$copyeditFinalSignoff->getFileRevision()}" class="file">{$finalCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$finalCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</td>
	</tr>
	</tbody>
</table>

{translate key="submission.copyedit.copyeditComments"}
{if $submission->getMostRecentCopyeditComment()}
	{assign var="comment" value=$submission->getMostRecentCopyeditComment()}
	<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>{$comment->getDatePosted()|date_format:$dateFormatShort}
{else}
	<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
{/if}
</section>
