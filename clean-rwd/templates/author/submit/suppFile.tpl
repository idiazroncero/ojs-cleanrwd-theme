{**
 * templates/author/submit/suppFile.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Add/edit a supplementary file.
 *
 *}
{assign var="pageTitle" value="author.submit.step4a"}
{include file="author/submit/submitHeader.tpl"}

<p><a class="action" href="{url op="submit" path=4 articleId=$articleId}">&lt;&lt; {translate key="author.submit.backToSupplementaryFiles"}</a></p>

<form id="submit" method="post" action="{url op="saveSubmitSuppFile" path=$suppFileId}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<div id="locale">

	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
		{url|assign:"submitFormUrl" path=$suppFileId articleId=$articleId escape=false}
		{form_language_chooser form="submit" url=$submitFormUrl}
		<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>

</div>
{/if}
<section id="supplementaryFileData">
<h3>{translate key="author.submit.supplementaryFileData"}</h3>

<p>{translate key="author.submit.supplementaryFileDataDescription"}</p>


<div class="form-row">
	{fieldLabel required="true" name="title" key="common.title"}
	<input type="text" class="textField" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" maxlength="255" />
</div>

<div class="form-row">
	{fieldLabel name="creator" key="author.submit.suppFile.createrOrOwner"}
	<input type="text" name="creator[{$formLocale|escape}]" class="textField" id="creator" value="{$creator[$formLocale]|escape}" size="60" maxlength="255" />
</div>

<div class="form-row">
	{fieldLabel name="subject" key="common.keywords"}
	<input type="text" name="subject[{$formLocale|escape}]" class="textField" id="subject" value="{$subject[$formLocale]|escape}" size="60" maxlength="255" />
</div>

<div class="form-row">
	<div class="form-group">
		{fieldLabel name="type" key="common.type"}
		<select name="type" class="selectMenu" id="type" size="1">{html_options_translate output=$typeOptionsOutput values=$typeOptionsValues translateValues="true" selected=$type}</select>
	</div>
	<div class="form-subrow">
		<label for="typeOther">{translate key="author.submit.suppFile.specifyOtherType"}</label>
		<input type="text" name="typeOther[{$formLocale|escape}]" id="typeOther" class="textField" value="{$typeOther[$formLocale]|escape}" size="45" maxlength="255" />
	</div>
</div>

<div class="form-row">
	{fieldLabel name="description" key="author.submit.suppFile.briefDescription"}
	<textarea name="description[{$formLocale|escape}]" class="textArea" id="description" rows="5" cols="60">{$description[$formLocale]|escape}</textarea>
</div>

<div class="form-row">
	{fieldLabel name="publisher" key="common.publisher"}
	<input type="text" name="publisher[{$formLocale|escape}]" class="textField" id="publisher" value="{$publisher[$formLocale]|escape}" size="60" maxlength="255" />
	<p class="instruct">{translate key="author.submit.suppFile.publisherDescription"}</p>
</div>

<div class="form-row">
	{fieldLabel name="sponsor" key="author.submit.suppFile.contributorOrSponsor"}
	<input type="text" name="sponsor[{$formLocale|escape}]" class="textField" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" />
</div>

<div class="form-row">
	{fieldLabel name="dateCreated" key="common.date"}
	<input type="text" name="dateCreated" class="textField" id="dateCreated" value="{$dateCreated|escape}" size="11" maxlength="10" />
	<p class="instruct">{translate key="submission.date.yyyymmdd"} | {translate key="author.submit.suppFile.dateDescription"}</p>
</div>

<div class="form-row">
	{fieldLabel name="source" key="common.source"}
	<input type="text" name="source[{$formLocale|escape}]" class="textField" id="source" value="{$source[$formLocale]|escape}" size="60" maxlength="255" />
	<p class="instruct">{translate key="author.submit.suppFile.sourceDescription"}</p>
</div>

<div class="form-row">
	{fieldLabel name="language" key="common.language"}
	<input type="text" name="language" class="textField" id="language" value="{$language|escape}" size="5" maxlength="10" />
	<p class="instruct">{translate key="author.submit.languageInstructions"}</p>
</div>


</section>


{call_hook name="Templates::Author::Submit::SuppFile::AdditionalMetadata"}

<section id="supplementaryFileUpload">
<h3>{translate key="author.submit.supplementaryFileUpload"}</h3>


{if $suppFile && $suppFile->getFileId()}
<div class="form-row">
	<div class="form-subrow">
		
			<div class="form-group">
				{translate key="common.fileName"} - 
				<a href="{url op="download" path=$articleId|to_array:$suppFile->getFileId()}">{$suppFile->getFileName()|escape}</a>
			</div>
		
			<div class="form-group">
				{translate key="common.originalFileName"} - 
				{$suppFile->getOriginalFileName()|escape}</div>
		
			<div class="form-group">{translate key="common.fileSize"} - 
				{$suppFile->getNiceFileSize()}</div>
		
			<div class="form-group">{translate key="common.dateUploaded"} - 
				{$suppFile->getDateUploaded()|date_format:$datetimeFormatShort}</div>
		</tr>
	</div>
</div>

<div class="form-row">
	<input type="checkbox" name="showReviewers" id="showReviewers" value="1"{if $showReviewers==1} checked="checked"{/if} />
	<label class="label--inline" for="showReviewers">{translate key="author.submit.suppFile.availableToPeers"}</label>
</div>
{else}

	<p>{translate key="author.submit.suppFile.noFile"}</p>

{/if}





	<div class="form-row">
		
			{if $suppFile && $suppFile->getFileId()}
				{fieldLabel name="uploadSuppFile" key="common.replaceFile"}
			{else}
				{fieldLabel name="uploadSuppFile" key="common.upload"}
			{/if}

		<input type="file" name="uploadSuppFile" id="uploadSuppFile" class="uploadField" />&nbsp;&nbsp;{translate key="form.saveToUpload"}
	</div>

{if not ($suppFile && $suppFile->getFileId())}

    <div class="form-row">
    	<input type="checkbox" name="showReviewers" id="showReviewers" value="1"{if $showReviewers==1} checked="checked"{/if} />&nbsp;
    		<label for="showReviewers">{translate key="author.submit.suppFile.availableToPeers"}</label>
    </div>

{/if}

</section>



<div class="buttons">
	<input type="submit" value="{translate key="common.saveAndContinue"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="submit" path="4" articleId=$articleId escape=false}'" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}

