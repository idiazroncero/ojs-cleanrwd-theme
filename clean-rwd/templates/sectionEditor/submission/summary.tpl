{**
 * templates/sectionEditor/submission/summary.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission summary table.
 *
 *}
<div id="submission">
<h3>{translate key="article.submission"}</h3>

<dl>
	<dt>{translate key="article.authors"}</dt>
	<dd>
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
			{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
	</dd>

	<dt>{translate key="article.title"}</dt>
	<dd>{$submission->getLocalizedTitle()|strip_unsafe_html}</dd>

	<dt>{translate key="section.section"}</dt>
	<dd>{$submission->getSectionTitle()|escape}</dd>

	<dt>{translate key="user.role.editor"}</dt>
		<dd>
			{assign var=editAssignments value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
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
</dl>
</div>

