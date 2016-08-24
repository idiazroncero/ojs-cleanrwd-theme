{**
 * templates/submission/comment/editorDecisionComment.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to enter comments.
 *
 *}
{strip}
{include file="submission/comment/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
// In case this page is the result of a comment submit, reload the parent
// so that the necessary buttons will be activated.
window.opener.location.reload();
// -->
{/literal}
</script>
<section class="comments" id="existing-comments">
{foreach from=$articleComments item=comment}
<article class="comment">
	{if $comment->getCommentTitle() neq ""}
		<h4>{translate key="submission.comments.subject"}: {$comment->getCommentTitle()|escape}</h4>
	{/if}
	<p class="comment__details">
		{translate key=$comment->getRoleName()}
		{$comment->getDatePosted()|date_format:$datetimeFormatShort}
	</p>
	<p class="comment__text">
		{$comment->getComments()|strip_unsafe_html|nl2br}
	</p>
	{if $comment->getAuthorId() eq $userId and not $isLocked}
		<div>
			<a href="{url op="deleteComment" path=$articleId|to_array:$comment->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.comments.confirmDelete"}')" class="button button--small">{translate key="common.delete"}</a>
		</div>
	{/if}
</article>

{foreachelse}
	<p class="nodata">{translate key="submission.comments.noComments"}
{/foreach}
</section>



{if not $isLocked and $isEditor}

<form method="post" action="{url op=$commentAction}">
{if $hiddenFormParams}
	{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
		<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
	{/foreach}
{/if}


<div id="new">
{include file="common/formErrors.tpl"}


<div class="form-row">
	{fieldLabel name="commentTitle" key="submission.comments.subject"}
	<input type="text" name="commentTitle" id="commentTitle" value="{$commentTitle|escape}" size="50" maxlength="255" class="textField" />
</div>
<div class="form-row">
	{fieldLabel name="comments" key="submission.comments.addComment"}
	<textarea id="comments" name="comments" rows="10" cols="50" class="textArea">{$comments|escape}</textarea>
</div>

<div class="buttons">
	<input type="submit" name="save" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.close"}" class="button button--cancel" onclick="window.close()" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>
</div>
</form>

{else}
<input type="button" value="{translate key="common.close"}" class="button defaultButton" style="width: 5em" onclick="window.close()" />
{/if}

{include file="submission/comment/footer.tpl"}

