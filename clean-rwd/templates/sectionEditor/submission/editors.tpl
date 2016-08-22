{**
 * templates/sectionEditor/submission/editors.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission editors table.
 *
 *}
<section class="section" id="editors">
<h3>{translate key="user.role.editors"}</h3>
<form action="{url page="editor" op="setEditorFlags"}" method="post">
<input type="hidden" name="articleId" value="{$submission->getId()}"/>
<table class="listing">
	<thead>
		<th>&nbsp;</th>
		<th>&nbsp;</th>
		<th>{translate key="submission.review"}</th>
		<th>{translate key="submission.editing"}</th>
		<th>{translate key="submission.request"}</th>
		{if $isEditor}<th>{translate key="common.action"}</th>{/if}
	</thead>
	{assign var=editAssignments value=$submission->getEditAssignments()}
	{foreach from=$editAssignments item=editAssignment name=editAssignments}
	{if $editAssignment->getEditorId() == $userId}
		{assign var=selfAssigned value=1}
	{/if}
		<tr >
			<td>{if $editAssignment->getIsEditor()}{translate key="user.role.editor"}{else}{translate key="user.role.sectionEditor"}{/if}</td>
			<td>
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
			</td>
			<td data-title='{translate key="submission.review"}'>
				&nbsp;&nbsp;<input
					type="checkbox"
					name="canReview-{$editAssignment->getEditId()}"
					{if $editAssignment->getIsEditor()}
						checked="checked"
						disabled="disabled"
					{else}
						{if $editAssignment->getCanReview()} checked="checked"{/if}
						{if !$isEditor}disabled="disabled"{/if}
					{/if}
				/>
			</td>
			<td data-title='{translate key="submission.editing"}'>
				&nbsp;&nbsp;<input
					type="checkbox"
					name="canEdit-{$editAssignment->getEditId()}"
					{if $editAssignment->getIsEditor()}
						checked="checked"
						disabled="disabled"
					{else}
						{if $editAssignment->getCanEdit()} checked="checked"{/if}
						{if !$isEditor}disabled="disabled"{/if}
					{/if}
				/>
			</td>
			<td data-title='{translate key="submission.request"}'>{if $editAssignment->getDateNotified()}{$editAssignment->getDateNotified()|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
			{if $isEditor}
				<td><a href="{url page="editor" op="deleteEditAssignment" path=$editAssignment->getEditId()}" class="button button--small">{translate key="common.delete"}</a></td>
			{/if}
		</tr>
	{foreachelse}
		<tr><td colspan="{if $isEditor}6{else}5{/if}" class="nodata">{translate key="common.noneAssigned"}</td></tr>
	{/foreach}
</table>

{if $isEditor}
<div class="buttons">
	<input type="submit" class="button defaultButton" value="{translate key="common.record"}"/>
	<a href="{url page="editor" op="assignEditor" path="sectionEditor" articleId=$submission->getId()}" class="button">{translate key="editor.article.assignSectionEditor"}</a>
	<a href="{url page="editor" op="assignEditor" path="editor" articleId=$submission->getId()}" class="button">{translate key="editor.article.assignEditor"}</a>
	{if !$selfAssigned}<a href="{url page="editor" op="assignEditor" path="editor" editorId=$userId articleId=$submission->getId()}" class="button">{translate key="common.addSelf"}</a>{/if}
</div>
{/if}
</form>
</section>

