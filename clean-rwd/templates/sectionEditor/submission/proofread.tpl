{**
 * templates/sectionEditor/submission/proofread.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the proofreading table.
 *
 *}
{assign var=proofSignoff value=$submission->getSignoff('SIGNOFF_PROOFREADING_PROOFREADER')}
{assign var=proofreader value=$submission->getUserBySignoffType('SIGNOFF_PROOFREADING_PROOFREADER')}

<section id="proofread">
<h3>{translate key="submission.proofreading"}</h3>

{if $useProofreaders}
<div class="form-row">
	<p class="label">{translate key="user.role.proofreader"}</p> 
	{if $proofSignoff->getUserId()}{$proofreader->getFullName()|escape}{/if}
	<a href="{url op="selectProofreader" path=$submission->getId()}" class="action">{translate key="editor.article.selectProofreader"}</a>
</div>
{/if}

<table class="listing listing--wide">

	<thead>
		<tr>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>{translate key="submission.request"}</th>
			<th>{translate key="submission.underway"}</th>
			<th>{translate key="submission.complete"}</th>
			<th>{translate key="submission.acknowledge"}</th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td>1.</td>
		<td>{translate key="user.role.author"}</td>
		{assign var="authorProofreadSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')}
		<td data-title='{translate key="submission.request"}'>
			{url|assign:"url" op="notifyAuthorProofreader" articleId=$submission->getId()}
			{if $authorProofreadSignoff->getDateUnderway()}
				{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.author.confirmRenotify"}
				{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
			{else}
				{icon name="mail" url=$url}
			{/if}

			{$authorProofreadSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</td>
		<td data-title='{translate key="submission.underway"}'>
				{$authorProofreadSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
		<td data-title='{translate key="submission.complete"}'>
			{$authorProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if $authorProofreadSignoff->getDateCompleted() && !$authorProofreadSignoff->getDateAcknowledged()}
				{url|assign:"url" op="thankAuthorProofreader" articleId=$submission->getId()}
				{icon name="mail" url=$url}
			{else}
				{icon name="mail" disabled="disable"}
			{/if}
			{$authorProofreadSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
		</td>
	</tr>
	<tr>
		<td>2.</td>
		<td>{translate key="user.role.proofreader"}</td>
		{assign var="proofreaderProofreadSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_PROOFREADER')}
		<td data-title='{translate key="submission.request"}'>
			{if $useProofreaders}
				{if $proofSignoff->getUserId() && $authorProofreadSignoff->getDateCompleted()}
					{url|assign:"url" op="notifyProofreader" articleId=$submission->getId()}
					{if $proofreaderProofreadSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.proofreader.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
			{else}
				{if !$proofreaderProofreadSignoff->getDateNotified()}
					<a href="{url op="editorInitiateProofreader" articleId=$submission->getId()}" class="action">{translate key="common.initiate"}</a>
				{/if}
			{/if}
			{$proofreaderProofreadSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</td>
		<td data-title='{translate key="submission.underway"}'>
			{if $useProofreaders}
					{$proofreaderProofreadSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.complete"}'>
			{if !$useProofreaders && !$proofreaderProofreadSignoff->getDateCompleted() && $proofreaderProofreadSignoff->getDateNotified()}
				<a href="{url op="editorCompleteProofreader" articleId=$submission->getId()}" class="action">{translate key="common.complete"}</a>
			{else}
				{$proofreaderProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
			{/if}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if $useProofreaders}
				{if $proofreaderProofreadSignoff->getDateCompleted() && !$proofreaderProofreadSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankProofreader" articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$proofreaderProofreadSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
	</tr>
	<tr>
		<td>3.</td>
		<td>{translate key="user.role.layoutEditor"}</td>
		{assign var="layoutEditorProofreadSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
		{assign var="layoutSignoff" value=$submission->getSignoff('SIGNOFF_LAYOUT')}
		<td data-title='{translate key="submission.request"}'>
			{if $useLayoutEditors}
				{if $layoutSignoff->getUserId() && $proofreaderProofreadSignoff->getDateCompleted()}
					{url|assign:"url" op="notifyLayoutEditorProofreader" articleId=$submission->getId()}
					{if $layoutEditorProofreadSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.layout.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
			{else}
				{if !$layoutEditorProofreadSignoff->getDateNotified()}
					<a href="{url op="editorInitiateLayoutEditor" articleId=$submission->getId()}" class="action">{translate key="common.initiate"}</a>
				{/if}
			{/if}
				{$layoutEditorProofreadSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</td>
		<td data-title='{translate key="submission.underway"}'>
			{if $useLayoutEditors}
				{$layoutEditorProofreadSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
		<td data-title='{translate key="submission.complete"}'>
			{if $useLayoutEditors}
				{$layoutEditorProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
			{elseif $layoutEditorProofreadSignoff->getDateCompleted()}
				{$layoutEditorProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort}
			{elseif $layoutEditorProofreadSignoff->getDateNotified()}
				<a href="{url op="editorCompleteLayoutEditor" articleId=$submission->getId()}" class="action">{translate key="common.complete"}</a>
			{else}
				&mdash;
			{/if}
		</td>
		<td data-title='{translate key="submission.acknowledge"}'>
			{if $useLayoutEditors}
				{if $layoutEditorProofreadSignoff->getDateCompleted() && !$layoutEditorProofreadSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankLayoutEditorProofreader" articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$layoutEditorProofreadSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</td>
	</tr>
	</tbody>
</table>

{translate key="submission.proofread.corrections"}
{if $submission->getMostRecentProofreadComment()}
	{assign var="comment" value=$submission->getMostRecentProofreadComment()}
	<a href="javascript:openComments('{url op="viewProofreadComments" path=$submission->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>{$comment->getDatePosted()|date_format:$dateFormatShort}
{else}
	<a href="javascript:openComments('{url op="viewProofreadComments" path=$submission->getId()}');" class="icon">{icon name="comment"}</a>{translate key="common.noComments"}
{/if}

{if $currentJournal->getLocalizedSetting('proofInstructions')}
&nbsp;&nbsp;
<a href="javascript:openHelp('{url op="instructions" path="proof"}')" class="action">{translate key="submission.proofread.instructions"}</a>
{/if}

</section>

