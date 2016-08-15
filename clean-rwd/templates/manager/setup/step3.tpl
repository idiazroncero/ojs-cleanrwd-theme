{**
 * templates/manager/setup/step3.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of journal setup.
 *}
{assign var="pageTitle" value="manager.setup.guidingSubmissions"}
{include file="manager/setup/setupHeader.tpl"}

<form name="setupForm" id="setupForm" method="post" action="{url op="saveSetup" path="3"}">
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<div id="locale">

	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
		{url|assign:"setupFormUrl" op="setup" path="3" escape=false}
		{form_language_chooser form="setupForm" url=$setupFormUrl}
		<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
</div>
{/if}

<div id="authorGuidelinesInfo">
<h3>3.1 {fieldLabel name="authorGuidelines" key="manager.setup.authorGuidelines"}</h3>

<p>{translate key="manager.setup.authorGuidelinesDescription"}</p>

<p>
	<textarea name="authorGuidelines[{$formLocale|escape}]" id="authorGuidelines" rows="12" cols="60" class="textArea">{$authorGuidelines[$formLocale]|escape}</textarea>
</p>

</div>

<div id="submissionPreparationChecklist">
<h4>{translate key="manager.setup.submissionPreparationChecklist"}</h4>

<p>{translate key="manager.setup.submissionPreparationChecklistDescription"}</p>

{foreach name=checklist from=$submissionChecklist[$formLocale] key=checklistId item=checklistItem}
<!-- 	{if !$notFirstChecklistItem}
		{assign var=notFirstChecklistItem value=1}
		<table width="100%" class="data">
			<tr >
				<td width="5%">{translate key="common.order"}</td>
				<td width="95%" colspan="2">&nbsp;</td>
			</tr>
	{/if} -->

		<div class="form-row">
			<div class="form-group">
				<input type="text" name="submissionChecklist[{$formLocale|escape}][{$checklistId|escape}][order]" value="{$checklistItem.order|escape}" size="3" maxlength="2" class="textField" />
			</div>
	<div class="form-group">
			<textarea name="submissionChecklist[{$formLocale|escape}][{$checklistId|escape}][content]" id="submissionChecklist-{$checklistId|escape}" rows="3" cols="40" class="textArea">{$checklistItem.content|escape}</textarea>
	</div>
	<div class="form-group">
		<input type="submit" name="delChecklist[{$checklistId|escape}]" value="{translate key="common.delete"}" class="button button--small" />
		</div>
	</div>
{/foreach}

<div class="buttons">
	<input type="submit" name="addChecklist" value="{translate key="manager.setup.addChecklistItem"}" class="button" />
	</>
</div>


<section id="permissions">
<h3>3.2 {translate key="submission.permissions"}</h3>

<h4>{fieldLabel name="copyrightNotice" key="manager.setup.authorCopyrightNotice"}</h4>
{url|assign:"sampleCopyrightWordingUrl" page="information" op="sampleCopyrightWording"}
<p class="delete-actions">{translate key="manager.setup.authorCopyrightNoticeDescription" sampleCopyrightWordingUrl=$sampleCopyrightWordingUrl}</p>

<p><textarea name="copyrightNotice[{$formLocale|escape}]" id="copyrightNotice" rows="12" cols="60" class="textArea">{$copyrightNotice[$formLocale]|escape}</textarea></p>

<div class="form-row">
	<p class="label">{translate key="submission.copyrightHolder"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" value="author" name="copyrightHolderType" {if $copyrightHolderType=="author"}checked="checked" {/if}id="copyrightHolderType-author" />&nbsp;<label for="copyrightHolderType-author">{translate key="user.role.author"}</label>
		</div>
		<div class="form-group">
			<input type="radio" value="journal" name="copyrightHolderType" {if $copyrightHolderType=="journal"}checked="checked" {/if}id="copyrightHolderType-journal" />&nbsp;<label for="copyrightHolderType-journal">{translate key="journal.journal"}</label> <p class="instruct label--inline">({$currentJournal->getLocalizedTitle()|escape})</p>
		</div>
		<div class="form-group">
			<input type="radio" value="other" name="copyrightHolderType" {if $copyrightHolderType=="other"}checked="checked" {/if}id="copyrightHolderType-other" />&nbsp;<label for="copyrightHolderType-other">{translate key="common.other"}</label>&nbsp;&nbsp;<input type="text" name="copyrightHolderOther[{$formLocale|escape}]" id="copyrightHolderOther" value="{$copyrightHolderOther[$formLocale]|escape}" />
		</div>
	</div>
	
</div>

<div class="form-row">
	<p class="label">{translate key="manager.setup.copyrightYearBasis"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" value="issue" name="copyrightYearBasis" {if $copyrightYearBasis=="issue"}checked="checked" {/if}id="copyrightYearBasis-issue" />&nbsp;<label for="copyrightYearBasis-issue">{translate key="issue.issue"}</label> <p class="instruct label--inline">({translate key="manager.setup.copyrightYearBasis.Issue"})</p>
		</div>
		<div class="form-group">
			<input type="radio" value="article" name="copyrightYearBasis" {if $copyrightYearBasis=="article"}checked="checked" {/if}id="copyrightYearBasis-article" />&nbsp;<label for="copyrightYearBasis-article">{translate key="article.article"}</label> <p class="instruct label--inline">({translate key="manager.setup.copyrightYearBasis.Article"})</p>
		</div>
	</div>
</div>


<div class="form-row">
	<p class="label">{translate key="manager.setup.permissions.priorAgreement"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="copyrightNoticeAgree" id="copyrightNoticeAgree" value="1"{if $copyrightNoticeAgree} checked="checked"{/if} />&nbsp;<label for="copyrightNoticeAgree">{translate key="manager.setup.authorCopyrightNoticeAgree"}</label>
		</div>
	</div>
</div>

<div class="form-row">
	<p class="label">{translate key="manager.setup.permissions.display"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="includeCopyrightStatement" id="includeCopyrightStatement" value="1"{if $includeCopyrightStatement} checked="checked"{/if} />&nbsp;<label for="includeCopyrightStatement">{translate key="manager.setup.includeCopyrightStatement"}</label>
		</div>
	</div>
</div>

<div class="form-row">
	<p class="label">{fieldLabel name="licenseURLSelect" key="submission.licenseURL"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<select name="licenseURLSelect" id="licenseURLSelect" onchange="document.getElementById('licenseURL').value=document.getElementById('licenseURLSelect').options[document.getElementById('licenseURLSelect').selectedIndex].value; document.getElementById('licenseURL').readOnly=(document.getElementById('licenseURL').value==''?false:true);">
				{assign var=foundCc value=0}
				{foreach from=$ccLicenseOptions key=ccUrl item=ccNameKey}
					<option {if $licenseURL == $ccUrl}selected="selected" {/if}value="{$ccUrl|escape}">{$ccNameKey|translate}</option>
					{if $licenseURL == $ccUrl}
						{assign var=foundCc value=1}
					{/if}
				{/foreach}
				<option {if !$foundCc}selected="selected" {/if}value="">Other</option>
			</select>
		</div>
		<div class="form-group">
			<input type="text" name="licenseURL" id="licenseURL" value="{$licenseURL|escape}" {if $foundCc}readonly="readonly" {/if}size="40" maxlength="255" class="textField" />
			{fieldLabel name="licenseURL" key="manager.setup.licenseURLDescription"}
		</div>
	</div>
</div>

<div class="form-row">
	<p class="label">{translate key="manager.setup.permissions.display"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="includeLicense" id="includeLicense" value="1"{if $includeLicense} checked="checked"{/if} />&nbsp;<label for="includeLicense">{translate key="manager.setup.includeLicense"}</label>
		</div>
	</div>
</div>

<p>{translate key="manager.setup.resetPermissions.description"}</p>
<div class="buttons">
	<input id="resetPermissionsButton" type="button" value="{translate key="manager.setup.resetPermissions"}" class="button" />
</div>
</section>

<section id="competingInterests">
<h3>3.3 {translate key="manager.setup.competingInterests"}</h3>

<p>{translate key="manager.setup.competingInterests.description"}</p>
	
	<div class="form-row">
		<div class="form-subrow">
			<div class="form-group">
				<input type="checkbox" name="requireAuthorCompetingInterests" id="requireAuthorCompetingInterests" value="1"{if $requireAuthorCompetingInterests} checked="checked"{/if} />
				<label for="requireAuthorCompetingInterests">{translate key="manager.setup.competingInterests.requireAuthors"}</label>
			</div>
			<div class="form-group">
				<input type="checkbox" name="requireReviewerCompetingInterests" id="requireReviewerCompetingInterests" value="1"{if $requireReviewerCompetingInterests} checked="checked"{/if} />
				<label for="requireReviewerCompetingInterests">{translate key="manager.setup.competingInterests.requireReviewers"}</label>
			</div>
		</div>
		
	</div>



<h4>{fieldLabel name="competingInterestGuidelines" key="manager.setup.competingInterests.guidelines"}</h4>
<p><textarea name="competingInterestGuidelines[{$formLocale|escape}]" id="competingInterestGuidelines" rows="12" cols="60" class="textArea">{$competingInterestGuidelines[$formLocale]|escape}</textarea></p>
</section>



<section id="forAuthorsToIndexTheirWork">
<h3>3.4 {translate key="manager.setup.forAuthorsToIndexTheirWork"}</h3>

<p>{translate key="manager.setup.forAuthorsToIndexTheirWorkDescription"}</p>


<div class="form-row">
	<div class="form-group">
		<input type="checkbox" name="metaDiscipline" id="metaDiscipline" value="1"{if $metaDiscipline} checked="checked"{/if} />
		{fieldLabel name="metaDiscipline" class="label--inline" key="manager.setup.discipline"}
	</div>
		<div class="form-subrow">
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.disciplineDescription"}</p>
				<p class="instruct">{translate key="manager.setup.disciplineProvideExamples"}:</p>
				
				<input type="text" name="metaDisciplineExamples[{$formLocale|escape}]" id="metaDisciplineExamples" value="{$metaDisciplineExamples[$formLocale]|escape}" size="60" class="textField" />
				
				<p class="instruct">{fieldLabel name="metaDisciplineExamples" key="manager.setup.disciplineExamples"}</p>
			</div>
		</div>
</div>

<div class="form-row">
	<div class="form-group">
		<input type="checkbox" name="metaSubjectClass" id="metaSubjectClass" value="1"{if $metaSubjectClass} checked="checked"{/if} />
		{fieldLabel name="metaSubjectClass" class="label--inline" key="manager.setup.subjectClassification"}
	</div>
		<div class="form-subrow">
			<div class="form-group">
				{fieldLabel name="metaSubjectClassTitle" key="common.title"}
				<input type="text" name="metaSubjectClassTitle[{$formLocale|escape}]" id="metaSubjectClassTitle" value="{$metaSubjectClassTitle[$formLocale]|escape}" size="40" class="textField" />
			</div>
			<div class="form-group">
				{fieldLabel name="metaSubjectClassUrl" key="common.url"}
				<input type="text" name="metaSubjectClassUrl[{$formLocale|escape}]" id="metaSubjectClassUrl" value="{$metaSubjectClassUrl[$formLocale]|escape}" size="40" class="textField" />
				<p class="instruct">{translate key="manager.setup.subjectClassificationExamples"}</p>

			</div>
		</div>
</div>

<div class="form-row">
	<div class="form-group">
		<input type="checkbox" name="metaSubject" id="metaSubject" value="1"{if $metaSubject} checked="checked"{/if} />
		{fieldLabel name="metaSubject" class="label--inline" key="manager.setup.subjectKeywordTopic"}
	</div>
		<div class="form-subrow">
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.subjectProvideExamples"}:</p>
				
				<input type="text" name="metaSubjectExamples[{$formLocale|escape}]" id="metaSubjectExamples" value="{$metaSubjectExamples[$formLocale]|escape}" size="60" class="textField" />
				
				<p class="instruct">{fieldLabel name="metaSubjectExamples" key="manager.setup.subjectExamples"}</p>
			</div>
		</div>
</div>

<div class="form-row">
	<div class="form-group">
		<input type="checkbox" name="metaCoverage" id="metaCoverage" value="1"{if $metaCoverage} checked="checked"{/if} />
		{fieldLabel name="metaCoverage" class="label--inline" key="manager.setup.coverage"}
	</div>
		<div class="form-subrow">
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.coverageDescription"}</p>
				<p class="instruct">{translate key="manager.setup.coverageGeoProvideExamples"}:</p>
				
				<input type="text" name="metaCoverageGeoExamples[{$formLocale|escape}]" id="metaCoverageGeoExamples" value="{$metaCoverageGeoExamples[$formLocale]|escape}" size="60" class="textField" />
				
				<p class="instruct">{fieldLabel name="metaCoverageGeoExamples" key="manager.setup.coverageGeoExamples"}</p>
			</div>
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.coverageChronProvideExamples"}:</p>
				
				<input type="text" name="metaCoverageChronExamples[{$formLocale|escape}]" id="metaCoverageChronExamples" value="{$metaCoverageChronExamples[$formLocale]|escape}" size="60" class="textField" />
				
				<p class="instruct">{fieldLabel name="metaCoverageChronExamples" key="manager.setup.coverageChronExamples"}</p>
			</div>
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.coverageResearchSampleProvideExamples"}:</p>
				
				<input type="text" name="metaCoverageResearchSampleExamples[{$formLocale|escape}]" id="metaCoverageResearchSampleExamples" value="{$metaCoverageResearchSampleExamples[$formLocale]|escape}" size="60" class="textField" />
				
				<p class="instruct">{fieldLabel name="metaCoverageResearchSampleExamples" key="manager.setup.coverageResearchSampleExamples"}</p>
			</div>
		</div>
</div>

<div class="form-row">
	<div class="form-group">
		<input type="checkbox" name="metaType" id="metaType" value="1"{if $metaType} checked="checked"{/if} />
		{fieldLabel name="metaType" class="label--inline" key="manager.setup.typeMethodApproach"}
	</div>
		<div class="form-subrow">
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.typeProvideExamples"}:</p>
				
				<input type="text" name="metaTypeExamples[{$formLocale|escape}]" id="metaTypeExamples" value="{$metaTypeExamples[$formLocale]|escape}" size="60" class="textField" />
				
				<p class="instruct">{fieldLabel name="metaTypeExamples" key="manager.setup.typeExamples"}</p>
			</div>
		</div>
</div>



</section>


<section id="registerJournalForIndexing">
<h3>3.5 {translate key="manager.setup.registerJournalForIndexing"}</h3>

{url|assign:"oaiUrl" page="oai"}
<p>{translate key="manager.setup.registerJournalForIndexingDescription" oaiUrl=$oaiUrl siteUrl=$baseUrl}</p>
</section>

<section id="notifications">
<h3>3.6 {translate key="manager.setup.notifications"}</h3>

<p>{translate key="manager.setup.notifications.description"}</p>

<div class="form-subrow">
	<div class="form-group">
		<input {if !$submissionAckEnabled}disabled="disabled" {/if}type="checkbox" name="copySubmissionAckPrimaryContact" id="copySubmissionAckPrimaryContact" value="true" {if $copySubmissionAckPrimaryContact}checked="checked"{/if}/>
		{fieldLabel name="copySubmissionAckPrimaryContact" key="manager.setup.notifications.copyPrimaryContact"}
	</div>
	
	<div class="form-group">
		<div class="form-group">
		<input {if !$submissionAckEnabled}disabled="disabled" {/if}type="checkbox" name="copySubmissionAckSpecified" id="copySubmissionAckSpecified" value="true" {if $copySubmissionAckSpecified}checked="checked"{/if}/>
		{fieldLabel name="copySubmissionAckSpecified" key="manager.setup.notifications.copySpecifiedAddress"}
	</div>
		<div class="form-subrow">
			<div class="form-group">{fieldLabel name="copySubmissionAckAddress" key="user.email"}
				<input {if !$submissionAckEnabled}disabled="disabled" {/if}type="text" class="textField" id="copySubmissionAckAddress" name="copySubmissionAckAddress" value="{$copySubmissionAckAddress|escape}"/></div>
		</div>
	</div>
</div>

	{if !$submissionAckEnabled}

		{url|assign:"preparedEmailsUrl" op="emails"}
		<p>{translate key="manager.setup.notifications.submissionAckDisabled" preparedEmailsUrl=$preparedEmailsUrl}</p>

	{/if}

</section>


<section id="citationAssistant">
<h3>3.7 {translate key="manager.setup.citationAssistant"}</h3>

<a name="metaCitationEditing"></a>
{if $citationEditorError}
	<p>{translate key=$citationEditorError}</p>
{else}
	<p>{translate key="manager.setup.metaCitationsDescription"}</p>
	<div class="form-row">
	<div class="form-subrow">
		<input type="checkbox" name="metaCitations" id="metaCitations" value="1"{if $metaCitations} checked="checked"{/if} />
		<label for="metaCitations">{translate key="manager.setup.citations"}</label>
	</div>
	</div>

	<div id="citationFilterSetupToggle" {if !$metaCitations}style="visible: none"{/if}>
		<h4>{translate key="manager.setup.citationFilterParser"}</h4>
		<p>{translate key="manager.setup.citationFilterParserDescription"}</p>
		{load_url_in_div id="parserFilterGridContainer" loadMessageId="manager.setup.filter.parser.grid.loadMessage" url="$parserFilterGridUrl"}

		<h4>{translate key="manager.setup.citationFilterLookup"}</h4>
		<p>{translate key="manager.setup.citationFilterLookupDescription"}</p>
		{load_url_in_div id="lookupFilterGridContainer" loadMessageId="manager.setup.filter.lookup.grid.loadMessage" url="$lookupFilterGridUrl"}
		<h4>{translate key="manager.setup.citationOutput"}</h4>
		<p>{translate key="manager.setup.citationOutputStyleDescription"}</p>
		{fbvElement type="select" id="metaCitationOutputFilterSelect" name="metaCitationOutputFilterId"
				from=$metaCitationOutputFilters translate=false selected=$metaCitationOutputFilterId|escape
				defaultValue="-1" defaultLabel="manager.setup.filter.pleaseSelect"|translate}
	</div>
	{literal}<script type='text/javascript'>
		$(function(){
			// jQuerify DOM elements
			$metaCitationsCheckbox = $('#metaCitations');
			$metaCitationsSetupBox = $('#citationFilterSetupToggle');

			// Set the initial state
			initialCheckboxState = $metaCitationsCheckbox.attr('checked');
			if (initialCheckboxState) {
				$metaCitationsSetupBox.css('display', 'block');
			} else {
				$metaCitationsSetupBox.css('display', 'none');
			}

			// Toggle the settings box.
			// NB: Has to be click() rather than change() to work in IE.
			$metaCitationsCheckbox.click(function(){
				checkboxState = $metaCitationsCheckbox.attr('checked');
				toggleState = ($metaCitationsSetupBox.css('display') === 'block');
				if (checkboxState !== toggleState) {
					$metaCitationsSetupBox.toggle(300);
				}
			});
		});
		
		function permissionsValues() {
			perm = ':';
			licenseNames = ["copyrightYearBasis", "copyrightHolderType"];
			for (l = 0; l < licenseNames.length; l++) {
				ele = document.getElementsByName(licenseNames[l]);
				for (i = 0; i < ele.length; i++) {
					if (ele[i].type == 'radio') {
						if (ele[i].checked) {
							perm += ele[i].value + ':';
							break;
						}
					} else {
						perm += ele[i].value + ':';
					}
				}
			};
			licenseIds = ["copyrightHolderOther", "licenseURL"];
			for (l = 0; l < licenseIds.length; l++) {
				ele = document.getElementById(licenseIds[l]);
				if (ele) {
					perm += ele.value + ':';
				}
			}
			return perm;
		}
		var resetValues;
		$(document).ready( function () {
			resetValues = permissionsValues();
			$('#resetPermissionsButton').click( function ( event ) {
				if (resetValues == permissionsValues()) {
					{/literal}
					confirmAction('{url op="resetPermissions"}', '{translate|escape:"jsparam" key="manager.setup.confirmResetLicense"}');
					{literal}
				} else {
					{/literal}
					window.alert('{translate|escape:"jsparam" key="manager.setup.confirmResetLicenseChanged"}')
					{literal}
				}
				event.preventDefault();
			});
		});
	</script>{/literal}
{/if}
</section>

<div class="buttons">
	<input type="submit" value="{translate key="common.saveAndContinue"}" class="button" /> <input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="setup" escape=false}'" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}
