{**
 * templates/author/submission/proofread.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's proofreading table.
 *
 *}
{assign var=proofSignoff value=$submission->getSignoff('SIGNOFF_PROOFREADING_PROOFREADER')}
{assign var=proofreader value=$submission->getUserBySignoffType('SIGNOFF_PROOFREADING_PROOFREADER')}

<section id="proofread">
<h3>{translate key="submission.proofreading"}</h3>

{if $useProofreaders}
<div class="form-row">
		<p class="label">{translate key="user.role.proofreader"}</p>
		{if $proofSignoff->getUserId()}{$proofreader->getFullName()|escape}{else}{translate key="common.none"}{/if}
</div>
{/if}

<p>
	<i class="fa fa-info-circle"></i>
	<a href="{url op="viewMetadata" path=$proofSignoff->getAssocId()}" class="action" target="_new">{translate key="submission.reviewMetadata"}</a>
</p>

<table class="listing listing--wide">
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>{translate key="submission.request"}</th>
			<th>{translate key="submission.underway"}</th>
			<th>{translate key="submission.complete"}</th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td>1.</td>
		<td>{translate key="user.role.author"}</td>
		{assign var="authorProofreadSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')}
		<td  data-title='{translate key="submission.request"}'>{$authorProofreadSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.underway"}'>{$authorProofreadSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
				<td data-title='{translate key="submission.complete"}'>
			{if not $authorProofreadSignoff->getDateNotified() or $authorProofreadSignoff->getDateCompleted()}
				{icon name="mail" disabled="disabled"}
			{else}
				{translate|assign:"confirmMessage" key="common.confirmComplete"}
				{url|assign:"url" op="authorProofreadingComplete" articleId=$submission->getId()}
				{icon name="mail" onclick="return confirm('$confirmMessage')" url=$url}
			{/if}
			{$authorProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort|default:""}
		</td>
	</tr>
	<tr>
		<td>2.</td>
		<td>{translate key="user.role.proofreader"}</td>
		{assign var="proofreaderProofreadSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_PROOFREADER')}
		<td data-title='{translate key="submission.request"}'>{$proofreaderProofreadSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.underway"}'>{$proofreaderProofreadSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.complete"}'>{$proofreaderProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</td>
	</tr>
	<tr>
		<td>3.</td>
		<td>{translate key="user.role.layoutEditor"}</td>
		{assign var="layoutEditorProofreadSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
		<td data-title='{translate key="submission.request"}'>{$layoutEditorProofreadSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.underway"}'>{$layoutEditorProofreadSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</td>
		<td data-title='{translate key="submission.complete"}'>{$layoutEditorProofreadSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</td>
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
