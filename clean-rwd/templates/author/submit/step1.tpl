{**
 * templates/author/submit/step1.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 1 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step1"}
{include file="author/submit/submitHeader.tpl"}

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<div class="info-message">{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</div>

<form id="submit" method="post" action="{url op="saveSubmit" path=$submitStep}" onsubmit="return checkSubmissionChecklist()">
{include file="common/formErrors.tpl"}
{if $articleId}<input type="hidden" name="articleId" value="{$articleId|escape}" />{/if}

{if count($sectionOptions) <= 1}
	<p>{translate key="author.submit.notAccepting"}</p>
{else}

{if count($sectionOptions) == 2}
	{* If there's only one section, force it and skip the section parts
	   of the interface. *}
	{foreach from=$sectionOptions item=val key=key}
		<input type="hidden" name="sectionId" value="{$key|escape}" />
	{/foreach}
{else}{* if count($sectionOptions) == 2 *}
<section id="section">

<h3>{translate key="author.submit.journalSection"}</h3>

{url|assign:"url" page="about"}
<p>{translate key="author.submit.journalSectionDescription" aboutUrl=$url}</p>

<input type="hidden" name="submissionChecklist" value="1" />


	<div class="form-row">
		{fieldLabel name="sectionId" required="true" key="section.section"}
		<select name="sectionId" id="sectionId" size="1" class="selectMenu">{html_options options=$sectionOptions selected=$sectionId}</select>
	</div>


</section>{* section *}


{/if}{* if count($sectionOptions) == 2 *}

{if count($supportedSubmissionLocaleNames) == 1}
	{* There is only one supported submission locale; choose it invisibly *}
	{foreach from=$supportedSubmissionLocaleNames item=localeName key=locale}
		<input type="hidden" name="locale" value="{$locale|escape}" />
	{/foreach}
{else}
	{* There are several submission locales available; allow choice *}
	<section id="submissionLocale">

	<h3>{translate key="author.submit.submissionLocale"}</h3>
	<p>{translate key="author.submit.submissionLocaleDescription"}</p>

	<div class="form-row">
			{fieldLabel name="locale" required="true" key="article.language"}
			<select name="locale" id="locale" size="1" class="selectMenu">{html_options options=$supportedSubmissionLocaleNames selected=$locale}</select>
	</div>


	</section>{* submissionLocale *}
{/if}{* count($supportedSubmissionLocaleNames) == 1 *}

<script type="text/javascript">
{literal}
<!--
function checkSubmissionChecklist() {
	var elements = document.getElementById('submit').elements;
	for (var i=0; i < elements.length; i++) {
		if (elements[i].type == 'checkbox' && !elements[i].checked) {
			if (elements[i].name.match('^checklist')) {
				alert({/literal}'{translate|escape:"jsparam" key="author.submit.verifyChecklist"}'{literal});
				return false;
			} else if (elements[i].name == 'copyrightNoticeAgree') {
				alert({/literal}'{translate|escape:"jsparam" key="author.submit.copyrightNoticeAgreeRequired"}'{literal});
				return false;
			}
		}
	}
	return true;
}
// -->
{/literal}
</script>

{if $authorFees}
	{include file="author/submit/authorFees.tpl" showPayLinks=0}
{/if}

{if $currentJournal->getLocalizedSetting('submissionChecklist')}
{foreach name=checklist from=$currentJournal->getLocalizedSetting('submissionChecklist') key=checklistId item=checklistItem}
	{if $checklistItem.content}
		{if !$notFirstChecklistItem}
			{assign var=notFirstChecklistItem value=1}
			<section class="section" id="checklist">
			<h3>{translate key="author.submit.submissionChecklist"}</h3>
			<p>{translate key="author.submit.submissionChecklistDescription"}</p>
			<div class="form-subrow">
		{/if}
<div class="form-group">
	<input type="checkbox" id="checklist-{$smarty.foreach.checklist.iteration}" name="checklist[]" value="{$checklistId|escape}"{if $articleId || $submissionChecklist} checked="checked"{/if} />
	<label for="checklist-{$smarty.foreach.checklist.iteration}">{$checklistItem.content|nl2br}</label>
</div>

	{/if}
{/foreach}
{if $notFirstChecklistItem}
	</div>
	</section>{* checklist *}

{/if}

{/if}{* if count($sectionOptions) <= 1 *}

{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
<section class="section" id="copyrightNotice">
<h3>{translate key="about.copyrightNotice"}</h3>

<p>{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>

{if $journalSettings.copyrightNoticeAgree}

	<div class="form-row">
		<input type="checkbox" name="copyrightNoticeAgree" id="copyrightNoticeAgree" value="1"{if $articleId || $copyrightNoticeAgree} checked="checked"{/if} />
		<label for="copyrightNoticeAgree">{translate key="author.submit.copyrightNoticeAgree"}</label>
	</div>
</table>
{/if}{* $journalSettings.copyrightNoticeAgree *}
</section>{* copyrightNotice *}


{/if}{* $currentJournal->getLocalizedSetting('copyrightNotice') != '' *}

<section class="section" id="privacyStatement">
<h3>{translate key="author.submit.privacyStatement"}</h3>

{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}
</section>



<section id="commentsForEditor">
<h3>{translate key="author.submit.commentsForEditor"}</h3>

<div class="form-row">
	{fieldLabel name="commentsToEditor" key="author.submit.comments"}</td>
		<textarea name="commentsToEditor" id="commentsToEditor" rows="3" cols="40" class="textArea">{$commentsToEditor|escape}</textarea>
</div>

</section>{* commentsForEditor *}

<div class="buttons">
	<input type="submit" value="{translate key="common.saveAndContinue"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="{if $articleId}confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}'){else}document.location.href='{url page="author" escape=false}'{/if}" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{/if}{* If not accepting submissions *}

{include file="common/footer.tpl"}

