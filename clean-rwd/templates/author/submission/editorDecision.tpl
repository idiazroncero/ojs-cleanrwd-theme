{**
 * templates/author/submission/editorDecision.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's editor decision table.
 *
 *}
<section class="section" id="editorDecision">
<h3>{translate key="submission.editorDecision"}</h3>

{assign var=authorFiles value=$submission->getAuthorFileRevisions($submission->getCurrentRound())}
{assign var=editorFiles value=$submission->getEditorFileRevisions($submission->getCurrentRound())}

<dl>
	<dt>{translate key="editor.article.decision"}</dt>
		<dd>
			{if $lastEditorDecision}
				{assign var="decision" value=$lastEditorDecision.decision}
				{translate key=$editorDecisionOptions.$decision}{if $lastEditorDecision.dateDecided != 0} {$lastEditorDecision.dateDecided|date_format:$dateFormatShort}{/if}
			{else}
				&mdash;
			{/if}
		</dd>

		<dt>{translate key="submission.notifyEditor"}</dt>
		<dd>
			{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}
			{icon name="mail" url=$notifyAuthorUrl}
			&nbsp;&nbsp;
			{translate key="submission.editorAuthorRecord"}
			<br>
			{if $submission->getMostRecentEditorDecisionComment()}
				{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
				<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">&nbsp;&nbsp;{icon name="comment"}</a>{$comment->getDatePosted()|date_format:$dateFormatShort}
			{else}
				<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{translate key="common.noComments"}
			{/if}
		</dd>

	<dt>{translate key="submission.editorVersion"}</dt>
		<dd>
			{foreach from=$editorFiles item=editorFile key=key}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorFile->getDateModified()|date_format:$dateFormatShort}
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
		</dd>
	
	<dt>{translate key="submission.authorVersion"}</dt>
		<dd>
			{foreach from=$authorFiles item=authorFile key=key}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="action">{translate key="common.delete"}</a>
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
		</dd>


		<dt>{translate key="author.article.uploadAuthorVersion"}
		</dt>
		<dd>
			<form method="post" action="{url op="uploadRevisedVersion"}" enctype="multipart/form-data">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="file" name="upload" class="uploadField" />
				<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
			</form>

		</dd>
</dl>
</section>
