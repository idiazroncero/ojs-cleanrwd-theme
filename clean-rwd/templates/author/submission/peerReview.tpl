{**
 * templates/author/submission/peerReview.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's peer review table.
 *
 *}
<section class="section" id="peerReview">
<h3>{translate key="submission.peerReview"}</h3>

{assign var=start value="A"|ord}
{section name="round" loop=$submission->getCurrentRound()}
{assign var="round" value=$smarty.section.round.index+1}
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}
{assign var="viewableFiles" value=$authorViewableFilesByRound[$round]}

<h4>{translate key="submission.round" round=$round}</h4>

<dl>
	<dt>{translate key="submission.reviewVersion"}</dt>
		<dd>
			{assign var="reviewFile" value=$reviewFilesByRound[$round]}
			{if $reviewFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</dd>
	<dt>{translate key="submission.initiated"}</dt>
	<dd>
			{if $reviewEarliestNotificationByRound[$round]}
				{$reviewEarliestNotificationByRound[$round]|date_format:$dateFormatShort}
			{else}
				&mdash;
			{/if}
	</dd>

	<tr >
		<td class="label" width="20%">
			{translate key="submission.lastModified"}
		</td>
		<td class="value" width="80%">
			{if $reviewModifiedByRound[$round]}
				{$reviewModifiedByRound[$round]|date_format:$dateFormatShort}
			{else}
				&mdash;
			{/if}
		</td>
	</tr>
	<tr >
		<td class="label" width="20%">
			{translate key="common.uploadedFile"}
		</td>
		<td class="value" width="80%">
			{foreach from=$viewableFiles item=reviewerFiles key=reviewer}
				{foreach from=$reviewerFiles item=viewableFilesForReviewer key=reviewId}
					{assign var="roundIndex" value=$reviewIndexesByRound[$round][$reviewId]}
					{assign var=thisReviewer value=$start+$roundIndex|chr}
					{foreach from=$viewableFilesForReviewer item=viewableFile}
						{translate key="user.role.reviewer"} {$thisReviewer|escape}
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$viewableFile->getFileId():$viewableFile->getRevision()}" class="file">{$viewableFile->getFileName()|escape}</a>&nbsp;&nbsp;{$viewableFile->getDateModified()|date_format:$dateFormatShort}
					{/foreach}
				{/foreach}
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
		</td>
	</tr>
	{if !$smarty.section.round.last}
		<tr >
			<td class="label" width="20%">
				{translate key="submission.editorVersion"}
			</td>
			<td class="value" width="80%">
				{foreach from=$editorFiles item=editorFile key=key}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorFile->getDateModified()|date_format:$dateFormatShort}
				{foreachelse}
					{translate key="common.none"}
				{/foreach}
			</td>
		</tr>
		<tr >
			<td class="label" width="20%">
				{translate key="submission.authorVersion"}
			</td>
			<td class="value" width="80%">
				{foreach from=$authorFiles item=authorFile key=key}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}
				{foreachelse}
					{translate key="common.none"}
				{/foreach}
			</td>
		</tr>
	{/if}
</dl>

{/section}
</section>
