{**
 * templates/manager/setup/step1.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 1 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.gettingDownTheDetails"}
{include file="manager/setup/setupHeader.tpl"}

<form id="setupForm" method="post" action="{url op="saveSetup" path="1"}">
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<div id="locales">
	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
			{url|assign:"setupFormUrl" op="setup" path="1" escape=false}
			{form_language_chooser form="setupForm" url=$setupFormUrl}
			<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>
</div>
{/if}

<section id="generalInformation">
<h3>1.1 {translate key="manager.setup.generalInformation"}</h3>

<div class="form-row">
	{fieldLabel name="title" required="true" key="manager.setup.journalTitle"}
	<input type="text" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="40" maxlength="120" class="textField" />
</div>
<div class="form-row">
		{fieldLabel name="initials" required="true" key="manager.setup.journalInitials"}
		<input type="text" name="initials[{$formLocale|escape}]" id="initials" value="{$initials[$formLocale]|escape}" size="8" maxlength="16" class="textField" />
</div>
<div class="form-row">
		{fieldLabel name="abbreviation" key="manager.setup.journalAbbreviation"}
		<input type="text" name="abbreviation[{$formLocale|escape}]" id="abbreviation" value="{$abbreviation[$formLocale]|escape}" size="40" maxlength="120" class="textField" />
</div>
<div class="form-row">
		{fieldLabel name="printIssn" key="manager.setup.printIssn"}
		<input type="text" name="printIssn" id="printIssn" value="{$printIssn|escape}" size="8" maxlength="16" class="textField" />
</div>
<div class="form-row">
		{fieldLabel name="onlineIssn" key="manager.setup.onlineIssn"}
		<input type="text" name="onlineIssn" id="onlineIssn" value="{$onlineIssn|escape}" size="8" maxlength="16" class="textField" />
		<p class="instruct">{translate key="manager.setup.issnDescription"}</p>
</div>
<div class="form-row">
	{fieldLabel name="mailingAddress" key="common.mailingAddress"}
	<textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="textArea">{$mailingAddress|escape}</textarea>
	<p class="instruct">{translate key="manager.setup.mailingAddressDescription"}</p>
</div>
	{if $categoriesEnabled}
	<div class="form-row">
		{fieldLabel name=categories key="manager.setup.categories"}
		<select id="categories" name="categories[]" class="selectMenu" multiple="multiple">
			{html_options options=$allCategories selected=$categories}
		</select>
		{translate key="manager.setup.categories.description"}
	</div>
	{/if}{* $categoriesEnabled *}
</section>


<section id="principalContact">
	<h3>1.2 {translate key="manager.setup.principalContact"}</h3>

<p>{translate key="manager.setup.principalContactDescription"}</p>

	<div class="form-row">
		{fieldLabel name="contactName" key="user.name" required="true"}
		<input type="text" name="contactName" id="contactName" value="{$contactName|escape}" size="30" maxlength="60" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="contactTitle" key="user.title"}
		<input type="text" name="contactTitle[{$formLocale|escape}]" id="contactTitle" value="{$contactTitle[$formLocale]|escape}" size="30" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="contactAffiliation" key="user.affiliation"}
		<textarea name="contactAffiliation[{$formLocale|escape}]" id="contactAffiliation" rows="5" cols="40" class="textArea">{$contactAffiliation[$formLocale]|escape}</textarea>
	</div>
	<div class="form-row">
		{fieldLabel name="contactEmail" key="user.email" required="true"}
		<input type="text" name="contactEmail" id="contactEmail" value="{$contactEmail|escape}" size="30" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="contactPhone" key="user.phone"}
		<input type="text" name="contactPhone" id="contactPhone" value="{$contactPhone|escape}" size="15" maxlength="24" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="contactFax" key="user.fax"}
		<input type="text" name="contactFax" id="contactFax" value="{$contactFax|escape}" size="15" maxlength="24" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="contactMailingAddress" key="common.mailingAddress"}
		<textarea name="contactMailingAddress[{$formLocale|escape}]" id="contactMailingAddress" rows="3" cols="40" class="textArea">{$contactMailingAddress[$formLocale]|escape}</textarea>
	</div>

</section>



<section id="technicalSupportContact">
<h3>1.3 {translate key="manager.setup.technicalSupportContact"}</h3>

<p>{translate key="manager.setup.technicalSupportContactDescription"}</p>

	<div class="form-row">
		{fieldLabel name="supportName" key="user.name" required="true"}
		<input type="text" name="supportName" id="supportName" value="{$supportName|escape}" size="30" maxlength="60" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="supportEmail" key="user.email" required="true"}
		<input type="text" name="supportEmail" id="supportEmail" value="{$supportEmail|escape}" size="30" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="supportPhone" key="user.phone"}
		<input type="text" name="supportPhone" id="supportPhone" value="{$supportPhone|escape}" size="15" maxlength="24" class="textField" />
	</div>

</section>


<section id="setupEmails">
<h3>1.4 {translate key="manager.setup.emails"}</h3>

	<p>{translate key="manager.setup.emailHeaderDescription"}&nbsp;</p>
	
	<div class="form-row">
		{fieldLabel name="emailHeader" key="manager.setup.emailHeader"}
		<textarea name="emailHeader" id="emailHeader" rows="3" cols="60" class="textArea">{$emailHeader|escape}</textarea>
	</div>
	
	<p>{translate key="manager.setup.emailSignatureDescription"}&nbsp;</p>

	<div class="form-row">
		{fieldLabel name="emailSignature" key="manager.setup.emailSignature"}
		<textarea name="emailSignature" id="emailSignature" rows="3" cols="60" class="textArea">{$emailSignature|escape}</textarea>		
	</div>

	<p>{translate key="manager.setup.emailBounceAddressDescription"}&nbsp;</p>
	<div class="form-row">
		{fieldLabel name="envelopeSender" key="manager.setup.emailBounceAddress"}
		<input type="text" name="envelopeSender" id="envelopeSender" size="40" maxlength="255" class="textField" {if !$envelopeSenderEnabled}disabled="disabled" value=""{else}value="{$envelopeSender|escape}"{/if} />
		{if !$envelopeSenderEnabled}
			<p class="instruct">{translate key="manager.setup.emailBounceAddressDisabled"}</p>
			{/if}
	</div>
</section>

<section id="setupPublisher">
<h3>1.5 {translate key="manager.setup.publisher"}</h3>

<p>{translate key="manager.setup.publisherDescription"}</p>


	<div class="form-row">
		{fieldLabel name="publisherNote" key="manager.setup.note"}
		<textarea name="publisherNote[{$formLocale|escape}]" id="publisherNote" rows="5" cols="40" class="textArea">{$publisherNote[$formLocale]|escape}</textarea>
		<p class="instruct">{translate key="manager.setup.publisherNoteDescription"}</p>	
	</div>
	<div class="form-row">
		{fieldLabel name="publisherInstitution" key="manager.setup.institution"}
		<input type="text" name="publisherInstitution" id="publisherInstitution" value="{$publisherInstitution|escape}" size="40" maxlength="90" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="publisherUrl" key="common.url"}
		<input type="text" name="publisherUrl" id="publisherUrl" value="{$publisherUrl|escape}" size="40" maxlength="255" class="textField" />
	</div>

</section>


<section id="sponsors">
<h3>1.6 {translate key="manager.setup.sponsors"}</h3>

<p>{translate key="manager.setup.sponsorsDescription"}</p>


	<tr >
		<td width="20%" class="label">{fieldLabel name="sponsorNote" key="manager.setup.note"}
		
			<textarea name="sponsorNote[{$formLocale|escape}]" id="sponsorNote" rows="5" cols="40" class="textArea">{$sponsorNote[$formLocale]|escape}</textarea>
			
			<span class="instruct">{translate key="manager.setup.sponsorNoteDescription"}</span>
		
	</tr>
{foreach name=sponsors from=$sponsors key=sponsorId item=sponsor}
	<tr >
		<td width="20%" class="label">{fieldLabel name="sponsors-$sponsorId-institution" key="manager.setup.institution"}
		<input type="text" name="sponsors[{$sponsorId|escape}][institution]" id="sponsors-{$sponsorId|escape}-institution" value="{$sponsor.institution|escape}" size="40" maxlength="90" class="textField" />{if $smarty.foreach.sponsors.total > 1} <input type="submit" name="delSponsor[{$sponsorId|escape}]" value="{translate key="common.delete"}" class="button" />{/if}
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="sponsors-$sponsorId-url" key="common.url"}
		<input type="text" name="sponsors[{$sponsorId|escape}][url]" id="sponsors-{$sponsorId|escape}-url" value="{$sponsor.url|escape}" size="40" maxlength="255" class="textField" />
	</tr>
	{if !$smarty.foreach.sponsors.last}
	<tr >
		<td colspan="2" class="separator">&nbsp;
	</tr>
	{/if}
{foreachelse}
	<tr >
		<td width="20%" class="label">{fieldLabel name="sponsors-0-institution" key="manager.setup.institution"}
		<input type="text" name="sponsors[0][institution]" id="sponsors-0-institution" size="40" maxlength="90" class="textField" />
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="sponsors-0-url" key="common.url"}
		<input type="text" name="sponsors[0][url]" id="sponsors-0-url" size="40" maxlength="255" class="textField" />
	</tr>
{/foreach}

<p><input type="submit" name="addSponsor" value="{translate key="manager.setup.addSponsor"}" class="button" /></p>
</section>

<div class="separator"></div>

<div id="contributors">
<h3>1.7 {translate key="manager.setup.contributors"}</h3>

<p>{translate key="manager.setup.contributorsDescription"}</p>

<table width="100%" class="data">
	<tr >
		<td width="20%" class="label">{fieldLabel name="contributorNote" key="manager.setup.note"}
		
			<textarea name="contributorNote[{$formLocale|escape}]" id="contributorNote" rows="5" cols="40" class="textArea">{$contributorNote[$formLocale]|escape}</textarea>
			
			<span class="instruct">{translate key="manager.setup.contributorNoteDescription"}</span>
		
	</tr>
{foreach name=contributors from=$contributors key=contributorId item=contributor}
	<tr >
		<td width="20%" class="label">{fieldLabel name="contributors-$contributorId-name" key="manager.setup.contributor"}
		<input type="text" name="contributors[{$contributorId|escape}][name]" id="contributors-{$contributorId|escape}-name" value="{$contributor.name|escape}" size="40" maxlength="90" class="textField" />{if $smarty.foreach.contributors.total > 1} <input type="submit" name="delContributor[{$contributorId|escape}]" value="{translate key="common.delete"}" class="button" />{/if}
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="contributors-$contributorId-url" key="common.url"}
		<input type="text" name="contributors[{$contributorId|escape}][url]" id="contributors-{$contributorId|escape}-url" value="{$contributor.url|escape}" size="40" maxlength="255" class="textField" />
	</tr>
	{if !$smarty.foreach.contributors.last}
	<tr >
		<td colspan="2" class="separator">&nbsp;
	</tr>
	{/if}
{foreachelse}
	<tr >
		<td width="20%" class="label">{fieldLabel name="contributors-0-name" key="manager.setup.contributor"}
		<input type="text" name="contributors[0][name]" id="contributors-0-name" size="40" maxlength="90" class="textField" />
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="contributors-0-url" key="common.url"}
		<input type="text" name="contributors[0][url]" id="contributors-0-url" size="40" maxlength="255" class="textField" />
	</tr>
{/foreach}
</table>

<p><input type="submit" name="addContributor" value="{translate key="manager.setup.addContributor"}" class="button" /></p>
</div>

<div class="separator"></div>

<div id="searchEngineIndexing">
<h3>1.8 {translate key="manager.setup.searchEngineIndexing"}</h3>

<p>{translate key="manager.setup.searchEngineIndexingDescription"}</p>

<table width="100%" class="data">
	<tr >
		<td width="20%" class="label">{fieldLabel name="searchDescription" key="common.description"}
		<input type="text" name="searchDescription[{$formLocale|escape}]" id="searchDescription" value="{$searchDescription[$formLocale]|escape}" size="40" class="textField" />
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="searchKeywords" key="common.keywords"}
		<input type="text" name="searchKeywords[{$formLocale|escape}]" id="searchKeywords" value="{$searchKeywords[$formLocale]|escape}" size="40" class="textField" />
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="customHeaders" key="manager.setup.customTags"}
		
			<textarea name="customHeaders[{$formLocale|escape}]" id="customHeaders" rows="3" cols="40" class="textArea">{$customHeaders[$formLocale]|escape}</textarea>
			
			<span class="instruct">{translate key="manager.setup.customTagsDescription"}</span>
		
	</tr>
</table>
</div>

<div class="separator"></div>


<h3>1.9 {translate key="manager.setup.history"}</h3>

<p>{translate key="manager.setup.historyDescription"}</p>

<table width="100%" class="data">
	<tr >
		<td width="20%" class="label">{fieldLabel name="history" key="manager.setup.history"}
		
			<textarea name="history[{$formLocale|escape}]" id="history" rows="5" cols="40" class="textArea">{$history[$formLocale]|escape}</textarea>
		
	</tr>
</table>


<div class="separator"></div>


<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="button defaultButton" /> <input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url op="setup" escape=false}'" /></p>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}

