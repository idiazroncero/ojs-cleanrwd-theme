{**
 * templates/author/submission/management.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's submission management table.
 *
 *}
<section class="section" id="submission">
<h3>{translate key="article.submission"}</h3>
	
	<dl>
		<dt>{translate key="article.authors"}</dt>
		<dd>{$submission->getAuthorString(false)|escape}</dd>

		<dt>{translate key="article.title"}</dt>
		<dd>{$submission->getLocalizedTitle()|strip_unsafe_html}</dd>
		
		<dt>{translate key="submission.originalFile"}</dt>
		<dd>{if $submissionFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}" class="file">{$submissionFile->getFileName()|escape}</a>&nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}</dd>

		<dt>{translate key="article.suppFilesAbbrev"}</dt>
		<dd>
			{foreach name="suppFiles" from=$suppFiles item=suppFile}
				<a href="{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}{url op="editSuppFile" path=$submission->getId()|to_array:$suppFile->getId()}{else}{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}{/if}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;{$suppFile->getDateModified()|date_format:$dateFormatShort}
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
			{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}
				<a href="{url op="addSuppFile" path=$submission->getId()}" class="button button--small">{translate key="submission.addSuppFile"}</a>
			{else}
				&nbsp;
			{/if}
		</dd>

		<dt>{translate key="submission.submitter"}</dt>
		<dd>{assign var="submitter" value=$submission->getUser()}
			{assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
			{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
			{$submitter->getFullName()|escape} {icon name="mail" url=$url}</dd>

		<dt>{translate key="common.dateSubmitted"}</dt>
		<dd>{$submission->getDateSubmitted()|date_format:$datetimeFormatLong}</dd>

		<dt>{translate key="section.section"}</dt>
		<dd>{$submission->getSectionTitle()|escape}</dd>

		<dt>{translate key="user.role.editor"}</dt>
		<dd>{assign var="editAssignments" value=$submission->getEditAssignments()}

			{foreach from=$editAssignments item=editAssignment}
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
				{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
					{if $editAssignment->getCanEdit()}
						({translate key="submission.editing"})
					{else}
						({translate key="submission.review"})
					{/if}
				{/if}
				
                        {foreachelse}
                                {translate key="common.noneAssigned"}
                        {/foreach}
        </dd>


        {if $submission->getCommentsToEditor()}
        <dt>{translate key="article.commentsToEditor"}</dt>
        <dd>{$submission->getCommentsToEditor()|strip_unsafe_html|nl2br}</dd>
        {/if}

        {if $publishedArticle}
			<dt>{translate key="submission.abstractViews"}</dt>
			<dd>{$publishedArticle->getViews()}</dd>
		{/if}

	</dl>

</section>

