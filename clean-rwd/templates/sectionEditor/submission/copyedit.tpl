{**
 * templates/sectionEditor/submission/copyedit.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the copyediting table.
 *
 *}
<section id="copyedit">
<h3>{translate key="submission.copyediting"}</h3>

{if $currentJournal->getLocalizedSetting('copyeditInstructions') != ''}
<p class="marginless">
	<i class="fa fa-info-circle"></i>
	<a href="javascript:openHelp('{url op="instructions" path="copy"}')" class="action">{translate key="submission.copyedit.instructions"}</a>
</p>
{/if}

{if $useCopyeditors}
<div class="form-row">
	<p class="label">{translate key="user.role.copyeditor"}</p>
		{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL')}{$copyeditor->getFullName()|escape}{/if}
		<a href="{url op="selectCopyeditor" path=$submission->getId()}" class="action">{translate key="editor.article.selectCopyeditor"}</a>
</div>
{/if}

<table class="listing listing--wide">
	<thead>
		<tr>
			<th></th>
			<th><a href="{url op="viewMetadata" path=$submission->getId()}">{translate key="submission.reviewMetadata"}</a></th>
			<th>{translate key="submission.request"}</th>
			<th>{translate key="submission.underway"}</th>
			<th>{translate key="submission.complete"}</th>
			<th>{translate key="submission.acknowledge"}</th>
		</tr>
	</thead>
	<tr>
		<td>1.</td>
		{assign var="initialCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
		<td data-title='{translate key="submission.reviewMetadata"}'>{translate key="submission.copyedit.initialCopyedit"}</td>
		<td data-title='{translate key="submission.request"}'>
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') && $initialCopyeditFile}
					{url|assign:"url" op="notifyCopyeditor" articleId=$submission->getId()}
					{if $initialCopyeditSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.copyedit.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
			{else}
				{if !$initialCopyeditSignoff->getDateNotified() && $initialCopyeditFile}
					<a href="{url op="initiateCopyedit" articleId=$submission->getId()}" class="action">{translate key="common.initiate"}</a>
				{/if}
			{/if}
			{$initialCopyeditSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</td>
		<td data-title='{translate key="submission.underway"}'>
			{if $useCopyeditors}
				{$initialCopyeditSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.complete"}'>
			{if $initialCopyeditSignoff->getDateCompleted()}
				{$initialCopyeditSignoff->getDateCompleted()|date_format:$dateFormatShort}
			{elseif !$useCopyeditors}
				<a href="{url op="completeCopyedit" articleId=$submission->getId()}" class="action">{translate key="common.complete"}</a>
			{else}
				&mdash;
			{/if}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') &&  $initialCopyeditSignoff->getDateNotified() && !$initialCopyeditSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankCopyeditor" articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$initialCopyeditSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
	</tr>
	<tr>
		<td colspan="6">
			{translate key="common.file"}:
			{if $initialCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$initialCopyeditFile->getFileId():$initialCopyeditFile->getRevision()}" class="file">{$initialCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$initialCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="submission.copyedit.mustUploadFileForInitialCopyedit"}
			{/if}
		</td>
	</tr>
	<tr>
		<td>2.</td>
		{assign var="authorCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_AUTHOR')}
		<td data-title='{translate key="submission.reviewMetadata"}'>{translate key="submission.copyedit.editorAuthorReview"}</td>
		<td data-title='{translate key="submission.request"}'>
			{if ($submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') || !$useCopyeditors) && $initialCopyeditSignoff->getDateCompleted()}
				{url|assign:"url" op="notifyAuthorCopyedit articleId=$submission->getId()}
				{if $authorCopyeditSignoff->getDateUnderway()}
					{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.author.confirmRenotify"}
					{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
				{else}
					{icon name="mail" url=$url}
				{/if}
			{else}
				{icon name="mail" disabled="disable"}
			{/if}
			{$authorCopyeditSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</td>
		<td data-title='{translate key="submission.underway"}'>
				{$authorCopyeditSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
		<td data-title='{translate key="submission.complete"}'>
				{$authorCopyeditSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if ($submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') || !$useCopyeditors) && $authorCopyeditSignoff->getDateNotified() && !$authorCopyeditSignoff->getDateAcknowledged()}
				{url|assign:"url" op="thankAuthorCopyedit articleId=$submission->getId()}
				{icon name="mail" url=$url}
			{else}
				{icon name="mail" disabled="disable"}
			{/if}
			{$authorCopyeditSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
		</td>
	</tr>
	<tr>
		<td colspan="6">
			{translate key="common.file"}:
			{if $editorAuthorCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorAuthorCopyeditFile->getFileId():$editorAuthorCopyeditFile->getRevision()}" class="file">{$editorAuthorCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorAuthorCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{/if}
		</td>
	</tr>
	<tr>
		<td>3.</td>
		{assign var="finalCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
		<td data-title='{translate key="submission.reviewMetadata"}'>{translate key="submission.copyedit.finalCopyedit"}</td>
		<td data-title='{translate key="submission.request"}'>
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') && $authorCopyeditSignoff->getDateCompleted()}
					{url|assign:"url" op="notifyFinalCopyedit articleId=$submission->getId()}
					{if $finalCopyeditSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.copyedit.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
			{/if}
			{$finalCopyeditSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</td>
		<td data-title='{translate key="submission.underway"}'>
			{if $useCopyeditors}
				{$finalCopyeditSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.complete"}'>
			{if $finalCopyeditSignoff->getDateCompleted()}
				{$finalCopyeditSignoff->getDateCompleted()|date_format:$dateFormatShort}
			{elseif !$useCopyeditors}
				<a href="{url op="completeFinalCopyedit" articleId=$submission->getId()}" class="action">{translate key="common.complete"}</a>
			{else}
				&mdash;
			{/if}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') &&  $finalCopyeditSignoff->getDateNotified() && !$finalCopyeditSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankFinalCopyedit articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$finalCopyeditSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
	</tr>
	<tr>
		<td colspan="6">
			{translate key="common.file"}:
			{if $finalCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$finalCopyeditFile->getFileId():$finalCopyeditFile->getRevision()}" class="file">{$finalCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$finalCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{/if}
		</td>
	</tr>
</table>

<div class="form-row">
	{if $authorCopyeditSignoff->getDateCompleted()}
	{assign var="canUploadCopyedit" value="3"}
	{elseif $initialCopyeditSignoff->getDateCompleted() && !$authorCopyeditSignoff->getDateCompleted()}
	{assign var="canUploadCopyedit" value="2"}
	{elseif !$initialCopyeditSignoff->getDateCompleted()}
	{assign var="canUploadCopyedit" value="1"}
	{/if}
	<p class="label">{translate key="submission.uploadFileTo"}</p>
	<div class="form-subrow">
		<form method="post" action="{url op="uploadCopyeditVersion"}"  enctype="multipart/form-data">
			<input type="hidden" name="articleId" value="{$submission->getId()}" />
			<div class="form-group">
				<input type="radio" name="copyeditStage" id="copyeditStageInitial" value="initial" checked="checked" /><label for="copyeditStageInitial">{translate key="navigation.stepNumber" step=1}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="copyeditStage" id="copyeditStageAuthor" value="author"{if $canUploadCopyedit == 1} disabled="disabled"{else} checked="checked"{/if} /><label for="copyeditStageAuthor"{if $canUploadCopyedit == 1} class="disabled"{/if}>{translate key="navigation.stepNumber" step=2}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="copyeditStage" id="copyeditStageFinal" value="final"{if $canUploadCopyedit != 3} disabled="disabled"{else} checked="checked"{/if} /><label for="copyeditStageFinal"{if $canUploadCopyedit != 3} class="disabled"{/if}>{translate key="navigation.stepNumber" step=3}</label>
			</div>
			<div class="form-group">
				<input type="file" name="upload" size="10" class="uploadField"{if !$canUploadCopyedit} disabled="disabled"{/if} />
				<input type="submit" value="{translate key="common.upload"}" class="button"{if !$canUploadCopyedit} disabled="disabled"{/if} />
			</div>
		</form>
	</div>
</div>

<div class="form-row">
	<p class="label">{translate key="submission.copyedit.copyeditComments"}</p>
	{if $submission->getMostRecentCopyeditComment()}
		{assign var="comment" value=$submission->getMostRecentCopyeditComment()}
		<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>{$comment->getDatePosted()|date_format:$dateFormatShort}
	{else}
		<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
	{/if}</div>
</section>

