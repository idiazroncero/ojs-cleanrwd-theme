{**
 * templates/sectionEditor/submission/layout.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the layout editing table.
 *
 *}
{assign var=layoutSignoff value=$submission->getSignoff('SIGNOFF_LAYOUT')}
{assign var=layoutFile value=$submission->getFileBySignoffType('SIGNOFF_LAYOUT')}
{assign var=layoutEditor value=$submission->getUserBySignoffType('SIGNOFF_LAYOUT')}

<section class="section" id="layout">
<h3>{translate key="submission.layout"}</h3>

{if $useLayoutEditors}
<div id="layoutEditors">
	<div class="form-row">
		<p class="label">{translate key="user.role.layoutEditor"}</p>
			{if $layoutSignoff->getUserId()}{$layoutEditor->getFullName()|escape}{/if}
			<a href="{url op="assignLayoutEditor" path=$submission->getId()}" class="action">{translate key="submission.layout.assignLayoutEditor"}</a>
		</tr>
	</div>
</div>
{/if}

<table class="listing listing--wide">
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th>{translate key="submission.request"}</th>
			<th>{translate key="submission.underway"}</th>
			<th>{translate key="submission.complete"}</th>
			<th>{translate key="submission.acknowledge"}</th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td>
			{translate key="submission.layout.layoutVersion"}
		</td>
		<td data-title='{translate key="submission.request"}'>
			{if $useLayoutEditors}
				{if $layoutSignoff->getUserId() && $layoutFile}
					{url|assign:"url" op="notifyLayoutEditor" articleId=$submission->getId()}
					{if $layoutSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.layout.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$layoutSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.underway"}'>
			{if $useLayoutEditors}
				{$layoutSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.complete"}'>
			{if $useLayoutEditors}
				{$layoutSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if $useLayoutEditors}
				{if $layoutSignoff->getUserId() &&  $layoutSignoff->getDateCompleted() && !$layoutSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankLayoutEditor" articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$layoutSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
	</tr>
	<tr >
		<td colspan="5">
			{translate key="common.file"}:&nbsp;&nbsp;&nbsp;&nbsp;
			{if $layoutFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$layoutFile->getFileId()}" class="file">{$layoutFile->getFileName()|escape}</a>&nbsp;&nbsp;{$layoutFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="submission.layout.noLayoutFile"}
			{/if}
		</td>
	</tr>
	</tbody>
</table>

<table class="listing listing--wide">
	<thead>
		<tr>
			<th></th>
			<th>{translate key="submission.layout.galleyFormat"}</td>
			<th>{translate key="common.file"}</td>
			<th>{translate key="common.order"}</td>
			<th>{translate key="common.action"}</td>
			<th>{translate key="submission.views"}</td>
		</tr>
	</thead>
	<tbody>
	{foreach name=galleys from=$submission->getGalleys() item=galley}
	<tr>
		<td>{$smarty.foreach.galleys.iteration}.</td>
		<td data-title='{translate key="submission.layout.galleyFormat"}'>{$galley->getGalleyLabel()|escape}{if !$galley->getRemoteURL()} &nbsp; <a href="{url op="proofGalley" path=$submission->getId()|to_array:$galley->getId()}" class="action">{translate key="submission.layout.viewProof"}</a>{/if}</td>
		<td data-title='{translate key="common.file"}'>{if $galley->getFileId() > 0}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$galley->getFileId()}" class="file">{$galley->getFileName()|escape}</a>&nbsp;&nbsp;{$galley->getDateModified()|date_format:$dateFormatShort}{elseif $galley->getRemoteURL() != ''}<a href="{$galley->getRemoteURL()|escape}" target="_blank">{$galley->getRemoteURL()|truncate:20:"..."|escape}</a>{/if}</td>
		<td data-title='{translate key="common.order"}'><a href="{url op="orderGalley" d=u articleId=$submission->getId() galleyId=$galley->getId()}" class="plain">&uarr;</a> <a href="{url op="orderGalley" d=d articleId=$submission->getId() galleyId=$galley->getId()}" class="plain">&darr;</a></td>
		<td data-title='{translate key="common.action"}'>
			<a href="{url op="editGalley" path=$submission->getId()|to_array:$galley->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteGalley" path=$submission->getId()|to_array:$galley->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.layout.confirmDeleteGalley"}')" class="action">{translate key="common.delete"}</a>
		</td>
		<td data-title='{translate key="submission.views"}'>{$galley->getViews()|escape}</td>
	</tr>
	{foreachelse}
	<tr>
		<td colspan="6" class="nodata">{translate key="common.none"}</td>
	</tr>
	{/foreach}
	</tbody>
</table>

<table class="listing listing--wide">
	<thead>
		<tr>
			<th></th>
			<th>{translate key="submission.supplementaryFiles"}</th>
			<th>{translate key="common.file"}</th>
			<th>{translate key="common.order"}</th>
			<th>{translate key="common.action"}</th>
		</tr>
	</thead>
	<tbody>
	{foreach name=suppFiles from=$submission->getSuppFiles() item=suppFile}
	<tr>
		<td>{$smarty.foreach.suppFiles.iteration}.</td>
		<td data-title='{translate key="submission.supplementaryFiles"}'>{$suppFile->getSuppFileTitle()|escape}</td>
		<td data-title='{translate key="common.file"}'>{if $suppFile->getFileId() > 0}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;{$suppFile->getDateModified()|date_format:$dateFormatShort}{elseif $suppFile->getRemoteURL() != ''}<a href="{$suppFile->getRemoteURL()|escape}" target="_blank">{$suppFile->getRemoteURL()|truncate:20:"..."|escape}</a>{/if}</td>
		<td data-title='{translate key="common.oreder"}'><a href="{url op="orderSuppFile" d=u articleId=$submission->getId() suppFileId=$suppFile->getId()}" class="plain">&uarr;</a> <a href="{url op="orderSuppFile" d=d articleId=$submission->getId() suppFileId=$suppFile->getId()}" class="plain">&darr;</a></td>
		<td data-title='{translate key="common.action"}'>
			<a href="{url op="editSuppFile" from="submissionEditing" path=$submission->getId()|to_array:$suppFile->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSuppFile" from="submissionEditing" path=$submission->getId()|to_array:$suppFile->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.layout.confirmDeleteSupplementaryFile"}')" class="action">{translate key="common.delete"}</a>
		</td>
	</tr>
	{foreachelse}
	<tr>
		<td colspan="5" class="nodata">{translate key="common.none"}</td>
	</tr>
	{/foreach}
	</tbody>
</table>



<form method="post" action="{url op="uploadLayoutFile"}"  enctype="multipart/form-data">
	<input type="hidden" name="from" value="submissionEditing" />
	<input type="hidden" name="articleId" value="{$submission->getId()}" />
	<div class="form-row">	
		<p class="label">{translate key="submission.uploadFileTo"}</p>
		<div class="form-subrow">
			<div class="form-group">
				<input type="radio" name="layoutFileType" id="layoutFileTypeSubmission" value="submission" checked="checked" />
				<label for="layoutFileTypeSubmission">{translate key="submission.layout.layoutVersion"}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="layoutFileType" id="layoutFileTypeGalley" value="galley" />
				<label for="layoutFileTypeGalley">{translate key="submission.galley"}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="layoutFileType" id="layoutFileTypeSupp" value="supp" />
				<label for="layoutFileTypeSupp">{translate key="article.suppFilesAbbrev"}</label>
			</div>
		</div>
		<div class="form-group">
			<input type="file" name="layoutFile" size="10" class="uploadField" />
			<input type="submit" value="{translate key="common.upload"}" class="button" />
		</div>
	</div>

	<div class="form-row">
		<p class="label">{translate key="submission.createRemote"}</p>
		<div class="form-subrow">
			<div class="form-group">
				<input type="radio" name="layoutFileType" id="layoutFileTypeGalley" value="galley" /><label for="layoutFileTypeGalley">{translate key="submission.galley"}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="layoutFileType" id="layoutFileTypeSupp" value="supp" /><label for="layoutFileTypeSupp">{translate key="article.suppFilesAbbrev"}</label>
			</div>
		</div>
		<input type="submit" name="createRemote" value="{translate key="common.create"}" class="button" />
	</div>
</form>

<div id="layoutComments">
{translate key="submission.layout.layoutComments"}
{if $submission->getMostRecentLayoutComment()}
	{assign var="comment" value=$submission->getMostRecentLayoutComment()}
	<a href="javascript:openComments('{url op="viewLayoutComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a> {$comment->getDatePosted()|date_format:$dateFormatShort}
{else}
	<a href="javascript:openComments('{url op="viewLayoutComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a> {translate key="common.noComments"}
{/if}

{if $currentJournal->getLocalizedSetting('layoutInstructions')}
&nbsp;&nbsp;
<a href="javascript:openHelp('{url op="instructions" path="layout"}')" class="action">{translate key="submission.layout.instructions"}</a>
{/if}
{if $currentJournal->getSetting('provideRefLinkInstructions')}
&nbsp;&nbsp;
<a href="javascript:openHelp('{url op="instructions" path="referenceLinking"}')" class="action">{translate key="submission.layout.referenceLinking"}</a>
{/if}
{foreach name=templates from=$templates key=templateId item=template}
&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="downloadLayoutTemplate" path=$submission->getId()|to_array:$templateId}" class="action">{$template.title|escape}</a>
{/foreach}
</div>

</section>

