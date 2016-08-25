{**
 * templates/sectionEditor/submissionNotes.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show submission notes page.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="submission.notes"}
{assign var="pageCrumbTitle" value="submission.notes.breadcrumb"}
{include file="common/header.tpl"}
{/strip}

{literal}
<script type="text/javascript">
<!--
	var toggleAll = 0;
	var noteArray = new Array();
	function toggleNote(divNoteId) {
		var domStyle = getBrowserObject("note" + divNoteId,1);
		domStyle.display = (domStyle.display == "block") ? "none" : "block";
	}

	function toggleNoteAll() {
		for(var i = 0; i < noteArray.length; i++) {
			var domStyle = getBrowserObject("note" + noteArray[i],1);
			domStyle.display = toggleAll ? "none" : "block";
		}
		toggleAll = toggleAll ? 0 : 1;

		var collapse = getBrowserObject("collapseNotes",1);
		var expand = getBrowserObject("expandNotes",1);
		if (collapse.display == "inline") {
			collapse.display = "none";
			expand.display = "inline";
		} else {
			collapse.display = "inline";
			expand.display = "none";
		}
	}
// -->
</script>
{/literal}

<ul class="menu">
	<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	{if $canReview}<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>{/if}
	{if $canEdit}<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>{/if}
	<li><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
</ul>

<ul class="menu">
	<li><a href="{url op="submissionEventLog" path=$submission->getId()}">{translate key="submission.history.submissionEventLog"}</a></li>
	<li><a href="{url op="submissionEmailLog" path=$submission->getId()}">{translate key="submission.history.submissionEmailLog"}</a></li>
	<li class="current"><a href="{url op="submissionNotes" path=$submission->getId()}">{translate key="submission.history.submissionNotes"}</a></li>
</ul>

{include file="sectionEditor/submission/summary.tpl"}


<div id="submissionNotes">
{if $noteViewType == "edit"}
<h3>{translate key="submission.notes"}</h3>
<form name="editNote" method="post" action="{url op="updateSubmissionNote"}" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="{$articleNote->getArticleId()}" />
	<input type="hidden" name="noteId" value="{$articleNote->getId()}" />
	<input type="hidden" name="fileId" value="{$articleNote->getFileId()}" />

<table class="data">
	<tr >
		<td class="label" width="20%">{translate key="common.dateModified"}</td>
		<td class="value" width="80%">{$articleNote->getDateModified()|date_format:$datetimeFormatShort}</td>
	</tr>
	<tr >
		<td class="label" width="20%">{translate key="common.title"}</td>
		<td class="value" width="80%"><input type="text" name="title" id="title" value="{$articleNote->getTitle()|escape}" size="50" maxlength="120" class="textField" /></td>
	</tr>
	<tr >
		<td class="label" width="20%">{translate key="common.note"}</td>
		<td class="value" width="80%"><textarea name="note" id="note" rows="10" cols="50" class="textArea">{$articleNote->getNote()|strip_unsafe_html|escape}</textarea></td>
	</tr>
	<tr >
		<td class="label" width="20%">{translate key="common.file"}</td>
		<td class="value" width="80%"><input type="file" id="upload" name="upload" class="uploadField" /></td>
	</tr>
	<tr >
		<td class="label" width="20%">{translate key="common.uploadedFile"}</td>
		<td class="value" width="80%">{if $articleNote->getFileId()}<a href="{url op="downloadFile" path=$articleId|to_array:$articleNote->getFileId()}">{$articleNote->getOriginalFileName()|escape}</a><input type="checkbox" name="removeUploadedFile" value="1" />&nbsp;{translate key="submission.notes.removeUploadedFile"}{else}&mdash;{/if}</td>
	</tr>
</table>

<input type="button" class="button" value="{translate key="submission.notes.deleteNote"}" onclick="confirmAction('{url op="removeSubmissionNote" articleId=$articleNote->getArticleId() noteId=$articleNote->getId() fileId=$articleNote->getFileId()}', '{translate|escape:"jsparam" key="submission.notes.confirmDelete"}')" />&nbsp;<input type="submit" class="button defaultButton" value="{translate key="submission.notes.updateNote"}" />
</form>

{elseif $noteViewType == "add"}
	<h3>{translate key="submission.notes.addNewNote"}</h3>
	<form name="addNote" method="post" action="{url op="addSubmissionNote"}" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	
	<div class="form-row">
		<p class="label">{translate key="common.title"}</p>
		<input type="text" id="title" name="title" size="50" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		<p class="label">{translate key="common.note"}</p>
		<textarea name="note" id="note" rows="10" cols="50" class="textArea"></textarea>
	</div>
	<div class="form-row">
		<p class="label">{translate key="common.file"}</p>
		<input type="file" name="upload" class="uploadField" />
	</div>
	
	<div class="buttons">
		<input type="submit" class="button defaultButton" value="{translate key="submission.notes.createNewNote"}" />
	</div>
	</form>
{else}

<h3>{translate key="submission.notes"}</h3>

<table class="listing listing--wide">
	<thead>
		<tr class="heading" >
			<th>{translate key="common.date"}</th>
			<th>{translate key="common.title"}</th>
			<th>{translate key="submission.notes.attachedFile"}</th>
			<th>{translate key="common.action"}</th>
		</tr>
	</thead>
	<tbody>
{iterate from=submissionNotes item=note}
	<tr >
		<td>
			<script type="text/javascript">
			<!--
				noteArray.push({$note->getId()});
			// -->
			</script>
			{$note->getDateCreated()|date_format:$dateFormatTrunc}
		</td>
		<td><a class="action" href="javascript:toggleNote({$note->getId()})">{$note->getTitle()|escape}</a><div style="display: none" id="note{$note->getId()}">{$note->getNote()|strip_unsafe_html|nl2br}</div></td>
		<td>{if $note->getFileId()}<a class="action" href="{url op="downloadFile" path=$submission->getId()|to_array:$note->getFileId()}">{$note->getOriginalFileName()|escape}</a>{else}&mdash;{/if}</td>
		<td align="right"><a href="{url op="submissionNotes" path=$submission->getId()|to_array:"edit":$note->getId()}" class="action">{translate key="common.view"}</a>&nbsp;|&nbsp;<a href="{url op="removeSubmissionNote" articleId=$submission->getId() noteId=$note->getId() fileId=$note->getFileId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.notes.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
{if $submissionNotes->wasEmpty()}
	<tr >
		<td colspan="6" class="nodata">{translate key="submission.notes.noSubmissionNotes"}</td>
	</tr>
{else}
	<tr class="listing-pager">
		<td colspan="3">{page_info iterator=$submissionNotes}</td>
		<td colspan="3" >{page_links anchor="submissionNotes" name="submissionNotes" iterator=$submissionNotes}</td>
	</tr>
{/if}
	</tbody>
</table>


<div class="buttons">
	<a class="button" href="javascript:toggleNoteAll()"><div style="display:inline" id="expandNotes" name="expandNotes">{translate key="submission.notes.expandNotes"}</div><div style="display: none" id="collapseNotes" name="collapseNotes">{translate key="submission.notes.collapseNotes"}</div></a>
	<a class="button" href="{url op="submissionNotes" path=$submission->getId()|to_array:"add"}">{translate key="submission.notes.addNewNote"}</a>
	<a class="button button--cancel" href="{url op="clearAllSubmissionNotes" articleId=$submission->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.notes.confirmDeleteAll"}')">{translate key="submission.notes.clearAllNotes"}</a>
</div>
{/if}
</div>
{include file="common/footer.tpl"}

