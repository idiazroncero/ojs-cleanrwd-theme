{**
 * templates/sectionEditor/submission/peerReview.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the peer review table.
 *
 *}
<section class="section" id="submission">
<h3>{translate key="article.submission"}</h3>

<dl>
	<dt>{translate key="article.authors"}</dt>
	<dd>
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
			{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
	<dd>

	<dt>{translate key="article.title"}</dt>
	<dd>{$submission->getLocalizedTitle()|strip_unsafe_html}</dd>

	<dt>{translate key="section.section"}</dt>
	<dd>{$submission->getSectionTitle()|escape}</dd>

	<dt>{translate key="user.role.editor"}</dt>
	<dd>
		<ul>
			{assign var=editAssignments value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}
				<li>{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
				{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
					{if $editAssignment->getCanEdit()}
						({translate key="submission.editing"})
					{else}
						({translate key="submission.review"})
					{/if}
				{/if}</li>
				
			{foreachelse}
				<li>{translate key="common.noneAssigned"}</li>
			{/foreach}
		</ul>
	<dd>

	<dt>{translate key="submission.reviewVersion"}</dt>

		{if $reviewFile}
			<dd>
				<div class="form-group"><i class="fa fa-file-o"></i> <a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$reviewFile->getDateModified()|date_format:$dateFormatShort}{if $currentJournal->getSetting('showEnsuringLink')}&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}</div>
			</dd>
		{else}
			<dd>{translate key="common.none"}</dd>
		{/if}

		<dt>{translate key="editor.article.uploadReviewVersion"}</dt>
		<dd>
			<form method="post" action="{url op="uploadReviewVersion"}" enctype="multipart/form-data">
				
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="file" name="upload" class="uploadField" />
				<input type="submit" name="submit" value="{translate key="common.upload"}" class="button button--small" />
			</form>
		</dd>

	{foreach from=$suppFiles item=suppFile}
			{if !$notFirstSuppFile}
				<dt>{translate key="article.suppFilesAbbrev"}</dt>
				{assign var=notFirstSuppFile value=1}
			{/if}
			<dd>
				<form method="post" action="{url op="setSuppFileVisibility"}">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="hidden" name="fileId" value="{$suppFile->getId()}" />

				{if $suppFile->getFileId() > 0}
					<div class="form-group">
						<i class="fa fa-file-o"></i> <a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId():$suppFile->getRevision()}" class="file">{$suppFile->getFileName()|escape}</a>
					&nbsp;&nbsp;
					{$suppFile->getDateModified()|date_format:$dateFormatShort}</div>
				{elseif $suppFile->getRemoteURL() != ''}
					<div class="form-group">
						<i class="fa fa-file-o"></i> <a href="{$suppFile->getRemoteURL()|escape}" target="_blank">{$suppFile->getRemoteURL()|truncate:20:"..."|escape}</a>
					</div>
				{/if}
				<div class="form-subrow">
					<div class="form-group">
						<label for="show">{translate key="editor.article.showSuppFile"}</label>
						<input type="checkbox" name="show" id="show" value="1"{if $suppFile->getShowReviewers()==1} checked="checked"{/if}/>
					</div>
				</div>
				<input type="submit" name="submit" value="{translate key="common.record"}" class="button" />
				</form>
			</dd>
	{foreachelse}
		<dt>{translate key="article.suppFilesAbbrev"}</dt>
		<dd class="nodata">{translate key="common.none"}</dd>
{/foreach}

</section>

<section class="section" id="peerReview">

	<h3>{translate key="submission.peerReview"}</h3>
	<h4>{translate key="submission.round" round=$round}</h4>

	<div class="buttons marginless">
		<a href="{url op="selectReviewer" path=$submission->getId()}" class="button">{translate key="editor.article.selectReviewer"}</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="{url op="submissionRegrets" path=$submission->getId()}" class="button">{translate|escape key="sectionEditor.regrets.link"}</a>
	</div>

</section>


{assign var="start" value="A"|ord}
{foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
{assign var="reviewId" value=$reviewAssignment->getId()}

{if not $reviewAssignment->getCancelled() and not $reviewAssignment->getDeclined()}
	{assign var="reviewIndex" value=$reviewIndexes[$reviewId]}


<div class="reviewer">
	<p class="reviewer__id">{translate key="user.role.reviewer"} - {$reviewIndex+$start|chr}</p>
	<h4>{$reviewAssignment->getReviewerFullName()|escape}</h4>

	
	<div class="form-row">
	<p class="label">{translate key="submission.reviewForm"}</p>
		{if $reviewAssignment->getReviewFormId()}
			{assign var="reviewFormId" value=$reviewAssignment->getReviewFormId()}
			{$reviewFormTitles[$reviewFormId]}
		{else}
			{translate key="manager.reviewForms.noneChosen"}
		{/if}
		{if !$reviewAssignment->getDateCompleted()}
			<br><a class="button button--small" href="{url op="selectReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.selectReviewForm"}</a>{if $reviewAssignment->getReviewFormId()}&nbsp;&nbsp;&nbsp;&nbsp;<a class="button button--cancel button--small" href="{url op="clearReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.clearReviewForm"}</a>{/if}
		{/if}
	</div>

<div class="form-row">
<table class="listing">
	<thead>
		<tr>
			<th>{translate key="submission.request"}</th>
			<th>{translate key="submission.underway"}</th>
			<th>{translate key="submission.due"}</th>
			<th>{translate key="submission.acknowledge"}</th>
		</tr>
	</thead>
	<tbody>
		<tr >
			<td data-title='{translate key="submission.request"}'>
				{url|assign:"reviewUrl" op="notifyReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
				{if $reviewAssignment->getDateNotified()}
					{$reviewAssignment->getDateNotified()|date_format:$dateFormatShort}
					{if !$reviewAssignment->getDateCompleted()}
						{icon name="mail" url=$reviewUrl}
					{/if}
				{elseif $reviewAssignment->getReviewFileId()}
					{icon name="mail" url=$reviewUrl}
				{else}
					{icon name="mail" disabled="disabled" url=$reviewUrl}
					{assign var=needsReviewFileNote value=1}
				{/if}
			</td>
			<td data-title='{translate key="submission.underway"}'>
				{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatShort|default:"&mdash;"}
			</td>
			<td data-title='{translate key="submission.due"}'>
				{if $reviewAssignment->getDeclined()}
					{translate key="sectionEditor.regrets"}
				{else}
					<a href="{url op="setDueDate" path=$reviewAssignment->getSubmissionId()|to_array:$reviewAssignment->getId()}">{if $reviewAssignment->getDateDue()}{$reviewAssignment->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</a>
				{/if}
			</td>
			<td data-title='{translate key="submission.acknowledge"}'>
				{url|assign:"thankUrl" op="thankReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
				{if $reviewAssignment->getDateAcknowledged()}
					{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatShort}
				{elseif $reviewAssignment->getDateCompleted()}
					{icon name="mail" url=$thankUrl}
				{else}
					{icon name="mail" disabled="disabled" url=$thankUrl}
				{/if}
			</td>
		</tr>
	</tbody>
</table>
</div>


	{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
		<div class="form-row">
			<p class="label">{translate key="reviewer.article.recommendation"}</p>
				{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
					{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
					{translate key=$reviewerRecommendationOptions.$recommendation}
					&nbsp;&nbsp;{$reviewAssignment->getDateCompleted()|date_format:$dateFormatShort}
				{else}
					{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="{url op="remindReviewer" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="button button--small">{translate key="reviewer.article.sendReminder"}</a>
					{if $reviewAssignment->getDateReminded()}
						&nbsp;&nbsp;{$reviewAssignment->getDateReminded()|date_format:$dateFormatShort}
						{if $reviewAssignment->getReminderWasAutomatic()}
							&nbsp;&nbsp;{translate key="reviewer.article.automatic"}
						{/if}
					{/if}
				{/if}
		</div>

		{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
			<div class="form-row">
				<p class="label">{translate key="reviewer.competingInterests"}</p>
				{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
			</div>
		{/if}{* requireReviewerCompetingInterests *}

		{if $reviewFormResponses[$reviewId]}
			<div class="form-row">
				<p class="label">{translate key="submission.reviewFormResponse"}</p>
				<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>
			</div>
		{/if}
		{if !$reviewAssignment->getReviewFormId() || $reviewAssignment->getMostRecentPeerReviewComment()}{* Only display comments link if a comment is entered or this is a non-review form review *}
			<div class="form-row">
				<p class="label">{translate key="submission.review"}</p>
					{if $reviewAssignment->getMostRecentPeerReviewComment()}
						{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
						<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatShort}
					{else}
						<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{translate key="submission.comments.noComments"}
					{/if}
			</div>
		{/if}
		<div class="form-row">
			<p class="label">{translate key="reviewer.article.uploadedFile"}</p>
				<table class="data">
					{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
					<tr >
						<td valign="middle">
							<form id="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
								<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
								<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
								<input type="hidden" name="articleId" value="{$submission->getId()}" />
								<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
								<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
								{translate key="editor.article.showAuthor"} <input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} />
								<input type="submit" value="{translate key="common.record"}" class="button" />
							</form>
						</td>
					</tr>
					{foreachelse}
					<tr >
						<td>{translate key="common.none"}</td>
					</tr>
					{/foreach}
				</table>
		</div>
	{/if}

	{if (($reviewAssignment->getRecommendation() === null || $reviewAssignment->getRecommendation() === '') || !$reviewAssignment->getDateConfirmed()) && $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined()}
	
	<div class="form-row">
		<p class="label">{translate key="reviewer.article.editorToEnter"}</p>
				{if !$reviewAssignment->getDateConfirmed()}
					<div class="form-group">
					<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=1}" class="button button--small">{translate key="reviewer.article.canDoReview"}</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=0}" class="button button--small button--cancel">{translate key="reviewer.article.cannotDoReview"}</a>
					</div>
				{/if}
				
				<div class="form-group">
				<form method="post" action="{url op="uploadReviewForReviewer"}" enctype="multipart/form-data">
					{translate key="editor.article.uploadReviewForReviewer"}
					<input type="hidden" name="articleId" value="{$submission->getId()}" />
					<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}"/>
					<input type="file" name="upload" class="uploadField" />
					<input type="submit" name="submit" value="{translate key="common.upload"}" class="button button--small" />
				</form>
				</div>
				{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
				<div class="form-group">
					<a class="button button--small" href="{url op="enterReviewerRecommendation" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}">{translate key="editor.article.recommendation"}</a>
				</div>
				{/if}
	{/if}
	</div>

	{if $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined() && $rateReviewerOnQuality}
		<div class="form-row">
			<p class="label">{translate key="editor.article.rateReviewer"}</p>
			<div class="form-group">
			<form method="post" action="{url op="rateReviewer"}">
				<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<select name="quality" size="1" class="selectMenu">
					{html_options_translate options=$reviewerRatingOptions selected=$reviewAssignment->getQuality()}
				</select>&nbsp;&nbsp;
				<input type="submit" value="{translate key="common.record"}" class="button button--small" />
				{if $reviewAssignment->getDateRated()}
					&nbsp;&nbsp;{$reviewAssignment->getDateRated()|date_format:$dateFormatShort}
				{/if}
			</form>
			</div>
		</div>
	{/if}
	{if $needsReviewFileNote}
		<tr >
			<td>&nbsp;</td>
			<td>
				{translate key="submission.review.mustUploadFileForReview"}
			</td>
		</tr>
	{/if}
	</table>
{/if}

	{if not $reviewAssignment->getDateNotified()}
		<a href="{url op="clearReview" path=$submission->getId()|to_array:$reviewAssignment->getId()}" class="button button--cancel">{translate key="editor.article.clearReview"}</a>
	{elseif $reviewAssignment->getDeclined() or not $reviewAssignment->getDateCompleted()}
		<a href="{url op="cancelReview" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="button button--cancel">{translate key="editor.article.cancelReview"}</a>
	{/if}

</div>

{/foreach}



</section>

