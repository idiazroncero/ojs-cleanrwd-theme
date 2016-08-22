{**
 * templates/author/submission/layout.tpl
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
<table class="data">
	<tr>
		<td class="label" width="20%">{translate key="user.role.layoutEditor"}</td>
		<td class="value" width="80%">{if $layoutSignoff->getUserId()}{$layoutEditor->getFullName()|escape}{else}{translate key="common.none"}{/if}</td>
	</tr>
</table>
</div>
{/if}

<table class="listing">
	{if $useLayoutEditors}
	<tr>
		<td width="40%" colspan="2">{translate key="submission.layout.layoutVersion"}</td>
		<td width="15%" class="heading">{translate key="submission.request"}</td>
		<td width="15%" class="heading">{translate key="submission.underway"}</td>
		<td width="15%" class="heading">{translate key="submission.complete"}</td>
		<td class="heading">{translate key="submission.views"}</td>
	</tr>
	<tr>
		<td colspan="2">
			{if $layoutFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$layoutFile->getFileId()}" class="file">{$layoutFile->getFileName()|escape}</a>&nbsp;&nbsp;{$layoutFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</td>
		<td>
			{$layoutSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
		<td>
			{$layoutSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
		<td colspan="2">
			{$layoutSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
	</tr>
	{/if}

	<thead>
		<th>{translate key="submission.layout.galleyFormat"}</th>
		<th>{translate key="common.file"}</th>
		<th colspan="2">&nbsp;</th>
	</thead>
	<tbody>
	{foreach name=galleys from=$submission->getGalleys() item=galley}
	<tr>
		<td>{$smarty.foreach.galleys.iteration}.</td>
		<td>{$galley->getGalleyLabel()|escape} &nbsp; <a href="{url op="proofGalley" path=$submission->getId()|to_array:$galley->getId()}" class="action">{translate key="submission.layout.viewProof"}</td>
		<td colspan="2"><a href="{url op="downloadFile" path=$submission->getId()|to_array:$galley->getFileId()}" class="file">{$galley->getFileName()|escape}</a>&nbsp;&nbsp;{$galley->getDateModified()|date_format:$dateFormatShort}</td>
		<td>{$galley->getViews()}</td>
	</tr>
	{foreachelse}
	<tr>
		<td colspan="4" class="nodata">{translate key="common.none"}</td>
	</tr>
	{/foreach}
	</tbody>

</table>

<table class="listing">
	<thead>
		<tr>
			<th></th>
			<th>{translate key="submission.supplementaryFiles"}</th>
			<th>{translate key="common.file"}</th>
		</tr>
	</thead>

	<tbody>
	{foreach name=suppFiles from=$submission->getSuppFiles() item=suppFile}
	<tr>
		<td>{$smarty.foreach.suppFiles.iteration}.</td>
		<td>{$suppFile->getSuppFileTitle()|escape}</td>
		<td><a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;{$suppFile->getDateModified()|date_format:$dateFormatShort}</td>
	</tr>
	{foreachelse}
	<tr>
		<td colspan="3" class="nodata">{translate key="common.none"}</td>
	</tr>
	{/foreach}
	</tbody>
</table>



<div id="layoutComments">
{translate key="submission.layout.layoutComments"}
{if $submission->getMostRecentLayoutComment()}
	{assign var="comment" value=$submission->getMostRecentLayoutComment()}
	<a href="javascript:openComments('{url op="viewLayoutComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>{$comment->getDatePosted()|date_format:$dateFormatShort}
{else}
	<a href="javascript:openComments('{url op="viewLayoutComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
{/if}
</div>

</section>
