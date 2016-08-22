{**
 * templates/sectionEditor/submission/management.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission management table.
 *
 *}
<section class="section" id="submission">
<h3>{translate key="article.submission"}</h3>

{assign var="submissionFile" value=$submission->getSubmissionFile()}
{assign var="suppFiles" value=$submission->getSuppFiles()}
<dl>
	
		<dt>{translate key="article.authors"}</dt>
		<dd>
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
			{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
		</dd>


		<dt>{translate key="article.title"}</dt>
		<dd>{$submission->getLocalizedTitle()|strip_unsafe_html}</dd>
	

		<dt>{translate key="submission.originalFile"}</dt>
		<dd>
			{if $submissionFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId()}" class="file">{$submissionFile->getFileName()|escape}</a>&nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</dd>

		<dt>{translate key="article.suppFilesAbbrev"}</dt>
		<dd>
			{foreach name="suppFiles" from=$suppFiles item=suppFile}
				{if $suppFile->getFileId()}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a>
					&nbsp;&nbsp;
				{elseif $suppFile->getRemoteURL() != ''}
					<a href="{$suppFile->getRemoteURL()|escape}" target="_blank">{$suppFile->getRemoteURL()|truncate:20:"..."|escape}</a>
					&nbsp;&nbsp;
				{/if}
				{if $suppFile->getDateModified()}
					{$suppFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;
				{else}
					{$suppFile->getDateSubmitted()|date_format:$dateFormatShort}&nbsp;&nbsp;
				{/if}
				<a href="{url op="editSuppFile" from="submission" path=$submission->getId()|to_array:$suppFile->getId()}" class="button button--small">{translate key="common.edit"}</a>
				&nbsp;|&nbsp;
				<a href="{url op="deleteSuppFile" from="submission" path=$submission->getId()|to_array:$suppFile->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="button button--small">{translate key="common.delete"}</a>
				{if !$notFirst}
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="{url op="addSuppFile" from="submission" path=$submission->getId()}" class="button button--small">{translate key="submission.addSuppFile"}</a>
				{/if}
				
				{assign var=notFirst value=1}
			{foreachelse}
				{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="addSuppFile" from="submission" path=$submission->getId()}" class="button button--small">{translate key="submission.addSuppFile"}</a>
			{/foreach}
		</dd>

		<dt>{translate key="submission.submitter"}</dt>
		<dd>
			{assign var="submitter" value=$submission->getUser()}
			{assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
			{$submitter->getFullName()|escape} {icon name="mail" url=$url}
		</dd>


		<dt>{translate key="common.dateSubmitted"}</dt>
		<dd>{$submission->getDateSubmitted()|date_format:$dateFormatShort}</dd>

		<dt>{translate key="section.section"}</dt>
		<dd>{$submission->getSectionTitle()|escape}
				<form class="form-subrow" action="{url op="updateSection" path=$submission->getId()}" method="post">
					<label>{translate key="submission.changeSection"}</label>
				<select name="section" size="1" class="selectMenu">{html_options options=$sections selected=$submission->getSectionId()}</select>
				<input type="submit" value="{translate key="common.record"}" class="button button--small" />
				</form>
			</dd>

	{if $submission->getCommentsToEditor()}
	
		<dt>{translate key="article.commentsToEditor"}</dt>
		<dd>{$submission->getCommentsToEditor()|strip_unsafe_html|nl2br}</dd>
	</tr>
	{/if}
	{if $publishedArticle}
	<dt>{translate key="submission.abstractViews"}</dt>
		<dd>{$publishedArticle->getViews()}</dd>
	{/if}
</dl>
</section>

