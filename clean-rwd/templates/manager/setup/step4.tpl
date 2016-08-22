{**
 * templates/manager/setup/step4.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 4 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.managingTheJournal"}
{include file="manager/setup/setupHeader.tpl"}

<form id="setupForm" method="post" action="{url op="saveSetup" path="4"}" enctype="multipart/form-data">
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<div id="locales">

	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
		{url|assign:"setupFormUrl" op="setup" path="4" escape=false}
		{form_language_chooser form="setupForm" url=$setupFormUrl}
		<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>

</div><!-- locales -->
{/if}

<section id="securitySettings">
<h3>4.1 {translate key="manager.setup.securitySettings"}</h3>
<section id="onlineAccessManagement" class="section">
<h4>{translate key="manager.setup.onlineAccessManagement"}</h4>
<script type="text/javascript">
	{literal}
	<!--
		function togglePublishingMode(form) {
			if (form.publishingMode[0].checked) {
				// PUBLISHING_MODE_OPEN
				form.openAccessPolicy.disabled = false;
				form.showGalleyLinks.disabled = true;
			} else if (form.publishingMode[1].checked) {
				// PUBLISHING_MODE_SUBSCRIPTION
				form.openAccessPolicy.disabled = true;
				form.showGalleyLinks.disabled = false;
			} else {
				// PUBLISHING_MODE_NONE
				form.openAccessPolicy.disabled = true;
				form.showGalleyLinks.disabled = true;
			}
		}
	// -->
	{/literal}
</script>

<div class="form-subrow">
<div class="form-row">
	<div class="form-group">
		<div class="form-group">
			<input type="radio" name="publishingMode" id="publishingMode-0" value="{$smarty.const.PUBLISHING_MODE_OPEN}" onclick="togglePublishingMode(this.form)"{if $publishingMode == $smarty.const.PUBLISHING_MODE_OPEN} checked="checked"{/if} />
			<label for="publishingMode-0">{translate key="manager.setup.openAccess"}</label>
		</div>
		<div class="form-subrow">
			{fieldLabel name="openAccessPolicy" key="manager.setup.openAccessPolicy"}
			<p><span class="instruct">{translate key="manager.setup.openAccessPolicyDescription"}</span></p>
			<p><textarea name="openAccessPolicy[{$formLocale|escape}]" id="openAccessPolicy" rows="12" cols="60" class="textArea"{if $publishingMode != $smarty.const.PUBLISHING_MODE_OPEN} disabled="disabled"{/if}>{$openAccessPolicy[$formLocale]|escape}</textarea></p>
		</div>
	</div>
</div>

<div class="form-row">
	<div class="form-group">
		<div class="form-group">
			<input type="radio" name="publishingMode" id="publishingMode-1" value="{$smarty.const.PUBLISHING_MODE_SUBSCRIPTION}" onclick="togglePublishingMode(this.form)"{if $publishingMode == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION} checked="checked"{/if} />
			<label for="publishingMode-1">{translate key="manager.setup.subscription"}</label>
		</div>
		<div class="form-subrow">
			<div class="form-group">
				<p class="instruct">{translate key="manager.setup.subscriptionDescription"}</p>
			</div>
			<div class="form-group">
				<input type="checkbox" name="showGalleyLinks" id="showGalleyLinks" {if $showGalleyLinks} checked="checked"{/if} />&nbsp;<label  class="label--inline" for="showGalleyLinks">{translate key="manager.setup.showGalleyLinksDescription"}</label>
			</div>
			</table>
		</div>
	</div>
</div>

<div class="form-row">
	<div class="form-group">
		<div class="form-group">
			<input type="radio" name="publishingMode" id="publishingMode-2" value="{$smarty.const.PUBLISHING_MODE_NONE}" onclick="togglePublishingMode(this.form)"{if $publishingMode == $smarty.const.PUBLISHING_MODE_NONE} checked="checked"{/if} />
			<label for="publishingMode-2">{translate key="manager.setup.noPublishing"}</label>
		</div>
	</div>
</div>
</div>

<p>{translate key="manager.setup.securitySettingsDescription"}</p>
</section><!-- onlineAccessManagement -->

<script type="text/javascript">
{literal}
<!--
function setRegAllowOpts(form) {
	if(form.disableUserReg[0].checked) {
		form.allowRegReader.disabled=false;
		form.allowRegAuthor.disabled=false;
		form.allowRegReviewer.disabled=false;
	} else {
		form.allowRegReader.disabled=true;
		form.allowRegAuthor.disabled=true;
		form.allowRegReviewer.disabled=true;
	}
}
// -->
{/literal}
</script>

<section id="siteAccess" class="section">
<h4>{translate key="manager.setup.siteAccess"}</h4>


	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="restrictSiteAccess" id="restrictSiteAccess" value="1"{if $restrictSiteAccess} checked="checked"{/if} />&nbsp;<label for="restrictSiteAccess">{translate key="manager.setup.restrictSiteAccess"}</label>
		</div>
		<div class="form-group">
			<input type="checkbox" name="restrictArticleAccess" id="restrictArticleAccess" value="1"{if $restrictArticleAccess} checked="checked"{/if} />&nbsp;<label for="restrictArticleAccess">{translate key="manager.setup.restrictArticleAccess"}</label>
		</div>
	</div>

</section><!-- siteAccess -->

<section id="userRegistration" class="section">
<h4>{translate key="manager.setup.userRegistration"}</h4>

<div class="form-subrow">
	<div class="form-row">
		<div class="form-group">
			<input type="radio" name="disableUserReg" id="disableUserReg-0" value="0" onclick="setRegAllowOpts(this.form)"{if !$disableUserReg} checked="checked"{/if} />&nbsp;<label for="disableUserReg-0">{translate key="manager.setup.enableUserRegistration"}</label>
		</div>
		<div class="form-subrow">
			<div class="form-group">
				<input type="checkbox" name="allowRegReader" id="allowRegReader" value="1"{if $allowRegReader} checked="checked"{/if}{if $disableUserReg} disabled="disabled"{/if} /><label for="allowRegReader">{translate key="manager.setup.enableUserRegistration.reader"}</label>
			</div>
			<div class="form-group">
				<input type="checkbox" name="allowRegAuthor" id="allowRegAuthor" value="1"{if $allowRegAuthor} checked="checked"{/if}{if $disableUserReg} disabled="disabled"{/if} /><label for="allowRegAuthor">{translate key="manager.setup.enableUserRegistration.author"}</label>
			</div>
			<div class="form-group">
				<input type="checkbox" name="allowRegReviewer" id="allowRegReviewer" value="1"{if $allowRegReviewer} checked="checked"{/if}{if $disableUserReg} disabled="disabled"{/if} /><label for="allowRegReviewer">{translate key="manager.setup.enableUserRegistration.reviewer"}</label>
			</div>
		</div>

	</div>
	<div class="form-row">
		<input type="radio" name="disableUserReg" id="disableUserReg-1" value="1" onclick="setRegAllowOpts(this.form)"{if $disableUserReg} checked="checked"{/if} />&nbsp;<label for="disableUserReg-1">{translate key="manager.setup.disableUserRegistration"}</label>
	</div>
</div>

</section><!-- userRegistration -->

</section><!-- securitySettings -->


<section id="publicationScheduling">
<h3>4.2 {translate key="manager.setup.publicationScheduling"}</h3>
<section class="section" id="publicationSchedule">
<h4>{fieldLabel name="pubFreqPolicy" key="manager.setup.publicationSchedule"}</h4>

<p>{translate key="manager.setup.publicationScheduleDescription"}</p>

<p><textarea name="pubFreqPolicy[{$formLocale|escape}]" id="pubFreqPolicy" rows="12" cols="60" class="textArea">{$pubFreqPolicy[$formLocale]|escape}</textarea></p>
</section>

<section class="section" id="publicationFormat">
<h4>{translate key="manager.setup.publicationFormat"}</h4>

<p>{translate key="manager.setup.publicationFormatDescription"}</p>


<div class="form-subrow">
	<div class="form-group">
		<input type="checkbox" name="publicationFormatVolume" id="publicationFormatVolume" value="1"{if ($publicationFormatVolume)} checked="checked"{/if} />
		<label for="publicationFormatVolume">{translate key="manager.setup.publicationFormatVolume"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="publicationFormatNumber" id="publicationFormatNumber" value="1"{if ($publicationFormatNumber)} checked="checked"{/if} />
		<label for="publicationFormatNumber">{translate key="manager.setup.publicationFormatNumber"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="publicationFormatYear" id="publicationFormatYear" value="1"{if ($publicationFormatYear)} checked="checked"{/if} />
		<label for="publicationFormatYear">{translate key="manager.setup.publicationFormatYear"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="publicationFormatTitle" id="publicationFormatTitle" value="1"{if ($publicationFormatTitle)} checked="checked"{/if} />
		<label for="publicationFormatTitle">{translate key="manager.setup.publicationFormatTitle"}</label>
	</div>
</div>

</section>

<section class="section" id="frequencyOfPublication">
<h4>{translate key="manager.setup.frequencyOfPublication"}</h4>

<p>{translate key="manager.setup.frequencyOfPublicationDescription"}</p>


<div class="form-subrow">
	<div class="form-group">
		{fieldLabel name="initialNumber" key="issue.number"}
		<input type="text" name="initialNumber" id="initialNumber" value="{$initialNumber|escape}" size="5" maxlength="8" class="textField" />
	</div>
	<div class="form-group">
		{fieldLabel name="initialVolume" key="issue.volume"}
		<input type="text" name="initialVolume" id="initialVolume" value="{$initialVolume|escape}" size="5" maxlength="8" class="textField" />
	</div>
	<div class="form-group">
		{fieldLabel name="initialYear" key="issue.year"}
		<input type="text" name="initialYear" id="initialYear" value="{$initialYear|escape}" size="5" maxlength="8" class="textField" />
	</div>
	<div class="form-group">
		{fieldLabel name="issuePerVolume" key="manager.setup.issuePerVolume"}
		<input type="text" name="issuePerVolume" id="issuePerVolume" value="{if $issuePerVolume}{$issuePerVolume|escape}{/if}" size="5" maxlength="8" class="textField" />
	</div>
	<div class="form-group">
		{fieldLabel name="volumePerYear" key="manager.setup.volumePerYear"}
		<input type="text" name="volumePerYear" id="volumePerYear" value="{if $volumePerYear}{$volumePerYear|escape}{/if}" size="5" maxlength="8" class="textField" />
	</div>
</div>


<p class="instruct">{translate key="manager.setup.frequencyOfPublicationNote"}</p>
</section>
</section>

<section id="publicIdentifier">
<h3>4.3 {translate key="manager.setup.publicIdentifier"}</h3>
<section class="section" id="uniqueIdentifier">
<h4>{translate key="manager.setup.uniqueIdentifier"}</h4>

<p>{translate key="manager.setup.uniqueIdentifierDescription"}</p>


<div class="form-subrow">
	<div class="form-group">
		<input type="checkbox" name="enablePublicIssueId" id="enablePublicIssueId" value="1"{if $enablePublicIssueId} checked="checked"{/if} />
		<label for="enablePublicIssueId">{translate key="manager.setup.enablePublicIssueId"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="enablePublicArticleId" id="enablePublicArticleId" value="1"{if $enablePublicArticleId} checked="checked"{/if} />
		<label for="enablePublicArticleId">{translate key="manager.setup.enablePublicArticleId"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="enablePublicGalleyId" id="enablePublicGalleyId" value="1"{if $enablePublicGalleyId} checked="checked"{/if} />
		<label for="enablePublicGalleyId">{translate key="manager.setup.enablePublicGalleyId"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="enablePublicSuppFileId" id="enablePublicSuppFileId" value="1"{if $enablePublicSuppFileId} checked="checked"{/if} />
		<label for="enablePublicSuppFileId">{translate key="manager.setup.enablePublicSuppFileId"}</label>
	</div>
</div>

</section><!-- uniqueIdentifier -->

<section class="section" id="pageNumberIdentifier">
<h4>{translate key="manager.setup.pageNumberIdentifier"}</h4>

<div class="form-subrow">
	<input type="checkbox" name="enablePageNumber" id="enablePageNumber" value="1"{if $enablePageNumber} checked="checked"{/if} />
	<label for="enablePageNumber">{translate key="manager.setup.enablePageNumber"}</label>
</div>

</section><!-- pageNumberIdentifier -->
</section><!-- publicIdentifier -->


<section class="section" id="announcementsSection">
<h3>4.4 {translate key="manager.setup.announcements"}</h3>

<p>{translate key="manager.setup.announcementsDescription"}</p>

	<script type="text/javascript">
		{literal}
		<!--
			function toggleEnableAnnouncementsHomepage(form) {
				form.numAnnouncementsHomepage.disabled = !form.numAnnouncementsHomepage.disabled;
			}
		// -->
		{/literal}
	</script>

<div class="form-subrow">
	<div class="form-group">
		<input type="checkbox" name="enableAnnouncements" id="enableAnnouncements" value="1" {if $enableAnnouncements} checked="checked"{/if} />&nbsp;
		<label for="enableAnnouncements">{translate key="manager.setup.enableAnnouncements"}</label>
	</div>
	
	
	<div class="form-group">
		<input type="checkbox" name="enableAnnouncementsHomepage" id="enableAnnouncementsHomepage" value="1" onclick="toggleEnableAnnouncementsHomepage(this.form)"{if $enableAnnouncementsHomepage} checked="checked"{/if} />&nbsp;
		<label for="enableAnnouncementsHomepage">{translate key="manager.setup.enableAnnouncementsHomepage1"}</label>
		<select name="numAnnouncementsHomepage" id="numAnnouncementsHomepage" size="1" class="selectMenu" {if not $enableAnnouncementsHomepage}disabled="disabled"{/if}>
			{section name="numAnnouncementsHomepageOptions" start=1 loop=11}
			<option value="{$smarty.section.numAnnouncementsHomepageOptions.index}"{if $numAnnouncementsHomepage eq $smarty.section.numAnnouncementsHomepageOptions.index or ($smarty.section.numAnnouncementsHomepageOptions.index eq 1 and not $numAnnouncementsHomepage)} selected="selected"{/if}>{$smarty.section.numAnnouncementsHomepageOptions.index}</option>
			{/section}
		</select>
		{fieldLabel name="numAnnouncementsHomepage" key="manager.setup.enableAnnouncementsHomepage2"}
	</div>
</div>

<section id="announcementsIntroductionSection">
<h4>{fieldLabel name="announcementsIntroduction" key="manager.setup.announcementsIntroduction"}</h4>

<p>{translate key="manager.setup.announcementsIntroductionDescription"}</p>

<p><textarea name="announcementsIntroduction[{$formLocale|escape}]" id="announcementsIntroduction" rows="12" cols="60" class="textArea">{$announcementsIntroduction[$formLocale]|escape}</textarea></p>
</section><!-- announcementsIntroductionSection -->
</section><!-- announcementsSection -->



<section class="section" id="copyediting">
	<h3>4.5 {translate key="manager.setup.copyediting"}</h3>	

	<p>{translate key="manager.setup.selectOne"}:</p>	

	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" name="useCopyeditors" id="useCopyeditors-1" value="1"{if $useCopyeditors} checked="checked"{/if} />
			<label for="useCopyeditors-1">{translate key="manager.setup.useCopyeditors"}</label>
		</div>
		<div class="form-group">
			<input type="radio" name="useCopyeditors" id="useCopyeditors-0" value="0"{if !$useCopyeditors} checked="checked"{/if} />
			<label for="useCopyeditors-0">{translate key="manager.setup.noUseCopyeditors"}</label>
		</div>
	</div>

</section><!-- copyediting -->

<section class="section" id="copyeditInstructionsSection">
<h4>{fieldLabel name="copyeditInstructions" key="manager.setup.copyeditInstructions"}</h4>

<p>{translate key="manager.setup.copyeditInstructionsDescription"}</p>

<p>
	<textarea name="copyeditInstructions[{$formLocale|escape}]" id="copyeditInstructions" rows="12" cols="60" class="textArea">{$copyeditInstructions[$formLocale]|escape}</textarea>
</p>
</section><!-- copyeditInstructionsSection -->



<section id="layoutAndGalleys">
<h3>4.6 {translate key="manager.setup.layoutAndGalleys"}</h3>

<p>{translate key="manager.setup.selectOne"}:</p>


<div class="form-row">
	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" name="useLayoutEditors" id="useLayoutEditors-1" value="1"{if $useLayoutEditors} checked="checked"{/if} />
			<label for="useLayoutEditors-1">{translate key="manager.setup.useLayoutEditors"}</label>
		</div>
		<div class="form-group">
			<input type="radio" name="useLayoutEditors" id="useLayoutEditors-0" value="0"{if !$useLayoutEditors} checked="checked"{/if} />
			<label for="useLayoutEditors-0">{translate key="manager.setup.noUseLayoutEditors"}</label>
		</div>
	</div>
</div>


<section class="section" id="layoutInstructionsSection">
<h4>{fieldLabel name="layoutInstructions" key="manager.setup.layoutInstructions"}</h4>

<p>{translate key="manager.setup.layoutInstructionsDescription"}</p>

<p>
	<textarea name="layoutInstructions[{$formLocale|escape}]" id="layoutInstructions" rows="12" cols="60" class="textArea">{$layoutInstructions[$formLocale]|escape}</textarea>
</p>
</section><!-- layoutInstructionsSection -->

<section class="section" id="layoutTemplates">
<h4>{translate key="manager.setup.layoutTemplates"}</h4>

<p>{translate key="manager.setup.layoutTemplatesDescription"}</p>

<div class="form-subrow">
	
	{foreach name=templates from=$templates key=templateId item=template}
		<div class="form-group">
			<a href="{url op="downloadLayoutTemplate" path=$templateId}" class="action">{$template.filename|escape}</a>
			{$template.title|escape}
			<input type="submit" name="delTemplate[{$templateId|escape}]" value="{translate key="common.delete"}" class="button" />
		</div>
	{/foreach}
	
		<div class="form-group">
			{fieldLabel name="template-title" key="manager.setup.layoutTemplates.title"}
			<input type="text" name="template-title" id="template-title" size="40" maxlength="90" class="textField" />
		</div>
		<div class="form-group">
			{fieldLabel name="template-file" key="manager.setup.layoutTemplates.file"}
			<input type="file" name="template-file" id="template-file" class="uploadField" />
			<input type="submit" name="addTemplate" value="{translate key="common.upload"}" class="button" />
		</div>
</div>


</section><!-- layoutTemplates -->

<section class="section" id="referenceLinking">
<h4>{translate key="manager.setup.referenceLinking"}</h4>

{translate key="manager.setup.referenceLinkingDescription"}


	<div class="form-subrow">
		<input type="checkbox" name="provideRefLinkInstructions" id="provideRefLinkInstructions" value="1"{if $provideRefLinkInstructions} checked="checked"{/if} />
		<label for="provideRefLinkInstructions">{translate key="manager.setup.provideRefLinkInstructions"}</label>
	</div>

</section><!-- referenceLinking -->

<section class="section" id="refLinkInstructionsSection">
	<h4>{fieldLabel name="refLinkInstructions" key="manager.setup.refLinkInstructions.description"}</h4>
	<textarea name="refLinkInstructions[{$formLocale|escape}]" id="refLinkInstructions" rows="12" cols="60" class="textArea">{$refLinkInstructions[$formLocale]|escape}</textarea>
</section><!-- refLinkInstructionsSection -->

</section>


<section id="proofreading">
<h3>4.7 {translate key="manager.setup.proofreading"}</h3>

<p>{translate key="manager.setup.selectOne"}:</p>


	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" name="useProofreaders" id="useProofreaders-1" value="1"{if $useProofreaders} checked="checked"{/if} />
			<label for="useProofreaders-1">{translate key="manager.setup.useProofreaders"}</label>
		</div>
		<div class="form-group">
			<input type="radio" name="useProofreaders" id="useProofreaders-0" value="0"{if !$useProofreaders} checked="checked"{/if} />
			<label for="useProofreaders-0">{translate key="manager.setup.noUseProofreaders"}</label>
		</div>
	</div>


<section  class="section" id="proofingInstructions">
	<h4>{fieldLabel name="proofInstructions" key="manager.setup.proofingInstructions"}</h4>	

	<p>{translate key="manager.setup.proofingInstructionsDescription"}</p>	

	<p>
		<textarea name="proofInstructions[{$formLocale|escape}]" id="proofInstructions" rows="12" cols="60" class="textArea">{$proofInstructions[$formLocale]|escape}</textarea>
	</p>
</section>

</section>



<div class="buttons">
	<input type="submit" value="{translate key="common.saveAndContinue"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="setup" escape=false}'" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}

