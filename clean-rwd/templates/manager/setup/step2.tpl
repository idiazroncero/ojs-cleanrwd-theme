{**
 * templates/manager/setup/step2.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.journalPolicies"}
{include file="manager/setup/setupHeader.tpl"}

<form id="setupForm" method="post" action="{url op="saveSetup" path="2"}">
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}
<div id="locales">

	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
		{url|assign:"setupFormUrl" op="setup" path="2" escape=false}
		{form_language_chooser form="setupForm" url=$setupFormUrl}
		<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>

</div>

{/if}

<section id="focusAndScopeDescription">
<h3>2.1 {translate key="manager.setup.focusAndScopeOfJournal"}</h3>
<p>{fieldLabel name="focusScopeDesc" key="manager.setup.focusAndScopeDescription"}</p>
<div class="form-row">
<textarea name="focusScopeDesc[{$formLocale|escape}]" id="focusScopeDesc" class="textArea">{$focusScopeDesc[$formLocale]|escape}</textarea>
</div>
</section>


<section id="peerReviewPolicy">
<h3>2.2 {translate key="manager.setup.peerReviewPolicy"}</h3>
	<div id="peerReviewDescription" class="form-row">
		<p>{translate key="manager.setup.peerReviewDescription"}</p>		

		<p class="label">{fieldLabel name="reviewPolicy" key="manager.setup.reviewPolicy"}</p>		
		<textarea name="reviewPolicy[{$formLocale|escape}]" id="reviewPolicy" rows="12" class="textArea">{$reviewPolicy[$formLocale]|escape}</textarea>
	</div>
	<div id="reviewGuidelinesInfo" class="form-row">	

	<p class="label">{fieldLabel name="reviewGuidelines" key="manager.setup.reviewGuidelines"}</p>	

	{url|assign:"reviewFormsUrl" op="reviewForms"}
	<p>{translate key="manager.setup.reviewGuidelinesDescription" reviewFormsUrl=$reviewFormsUrl}</p>	

	<textarea name="reviewGuidelines[{$formLocale|escape}]" id="reviewGuidelines" rows="12" class="textArea">{$reviewGuidelines[$formLocale]|escape}</textarea>
	</div>

	<div id="reviewProcess" class="form-row">
	<p class="label">{translate key="manager.setup.reviewProcess"}</p>	

	<p>{translate key="manager.setup.reviewProcessDescription"}</p>	

		<div class="form-subrow">
			<div class="form-group">
				<input type="radio" name="mailSubmissionsToReviewers" id="mailSubmissionsToReviewers-0" value="0"{if not $mailSubmissionsToReviewers} checked="checked"{/if} />
				<label for="mailSubmissionsToReviewers-0"><strong>{translate key="manager.setup.reviewProcessStandard"}</strong></label>
				<p class="instruct">{translate key="manager.setup.reviewProcessStandardDescription"}</p>
			</div>
			<div class="form-group">
				<input type="radio" name="mailSubmissionsToReviewers" id="mailSubmissionsToReviewers-1" value="1"{if $mailSubmissionsToReviewers} checked="checked"{/if} />
				<label for="mailSubmissionsToReviewers-1"><strong>{translate key="manager.setup.reviewProcessEmail"}</strong></label>
				<p class="instruct">{translate key="manager.setup.reviewProcessEmailDescription"}</p>
			</div>
		</div>
	</div>
</section>

<section id="reviewOptions">
	<h4>{translate key="manager.setup.reviewOptions"}</h4>

	<script type="text/javascript">
		{literal}
		<!--
			function toggleAllowSetInviteReminder(form) {
				form.numDaysBeforeInviteReminder.disabled = !form.numDaysBeforeInviteReminder.disabled;
			}
			function toggleAllowSetSubmitReminder(form) {
				form.numDaysBeforeSubmitReminder.disabled = !form.numDaysBeforeSubmitReminder.disabled;
			}
		// -->
		{/literal}
	</script>

<div class="form-row">
	<label for="numWeeksPerReview">{translate key="manager.setup.reviewOptions.reviewTime"}</label>
	<div>{translate key="manager.setup.reviewOptions.numWeeksPerReview"}: <input type="text" name="numWeeksPerReview" id="numWeeksPerReview" value="{$numWeeksPerReview|escape}" size="2" maxlength="8" class="textField" /> {translate key="common.weeks"}</div>
	<p class="instruct">{translate key="common.note"}: {translate key="manager.setup.reviewOptions.noteOnModification"}</p>
</div>

	<div class="form-row">
		<p class="label">{translate key="manager.setup.reviewOptions.reviewerReminders"}</p>
		<p>{translate key="manager.setup.reviewOptions.automatedReminders"}</p>
			<div class="form-subrow">
				<div class="form-group">
					<input type="checkbox" name="remindForInvite" id="remindForInvite" value="1" onclick="toggleAllowSetInviteReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled" {elseif $remindForInvite} checked="checked"{/if} />
					{fieldLabel name="remindForInvite" key="manager.setup.reviewOptions.remindForInvite1"}
					<select name="numDaysBeforeInviteReminder" id="numDaysBeforeInviteReminder" size="1" class="selectMenu"{if not $remindForInvite || !$scheduledTasksEnabled} disabled="disabled"{/if}>
						{section name="inviteDayOptions" start=3 loop=11}
						<option value="{$smarty.section.inviteDayOptions.index}"{if $numDaysBeforeInviteReminder eq $smarty.section.inviteDayOptions.index or ($smarty.section.inviteDayOptions.index eq 5 and not $remindForInvite)} selected="selected"{/if}>{$smarty.section.inviteDayOptions.index}</option>
						{/section}
					</select>
					{fieldLabel name="numDaysBeforeInviteReminder" key="manager.setup.reviewOptions.remindForInvite2"}
				</div>
				<div class="form-group">
					<input type="checkbox" name="remindForSubmit" id="remindForSubmit" value="1" onclick="toggleAllowSetSubmitReminder(this.form)"{if !$scheduledTasksEnabled} disabled="disabled"{elseif $remindForSubmit} checked="checked"{/if} />
					{fieldLabel name="remindForSubmit" key="manager.setup.reviewOptions.remindForSubmit1"}
					<select name="numDaysBeforeSubmitReminder" id="numDaysBeforeSubmitReminder" size="1" class="selectMenu"{if not $remindForSubmit || !$scheduledTasksEnabled} disabled="disabled"{/if}>
						{section name="submitDayOptions" start=0 loop=11}
							<option value="{$smarty.section.submitDayOptions.index}"{if $numDaysBeforeSubmitReminder eq $smarty.section.submitDayOptions.index} selected="selected"{/if}>{$smarty.section.submitDayOptions.index}</option>
					{/section}
					</select>
					{fieldLabel name="numDaysBeforeSubmitReminder" key="manager.setup.reviewOptions.remindForSubmit2"}
				</div>
			</div>
			{if !$scheduledTasksEnabled}
				<p>{translate key="manager.setup.reviewOptions.automatedRemindersDisabled"}</p>
			{/if}
	</div>

<div class="form-row">
	<p class="label">{translate key="manager.setup.reviewOptions.reviewerRatings"}</p>
	<input type="checkbox" name="rateReviewerOnQuality" id="rateReviewerOnQuality" value="1"{if $rateReviewerOnQuality} checked="checked"{/if} />
	<label for="rateReviewerOnQuality" class="label--inline label--normal">{translate key="manager.setup.reviewOptions.onQuality"}</label>
</div>

<div class="form-row">
	<p class="label">{translate key="manager.setup.reviewOptions.reviewerAccess"}</p>
	<div class="form-subrow">
		<div class="form-group">
			<input type="checkbox" name="reviewerAccessKeysEnabled" id="reviewerAccessKeysEnabled" value="1"{if $reviewerAccessKeysEnabled} checked="checked"{/if} />
			<label for="reviewerAccessKeysEnabled" class="label--inline">{translate key="manager.setup.reviewOptions.reviewerAccessKeysEnabled"}</label>
			<p class="instruct instruct--spaced">{translate key="manager.setup.reviewOptions.reviewerAccessKeysEnabled.description"}</p>
		</div>
		<div class="form-group">
			<input type="checkbox" name="restrictReviewerFileAccess" id="restrictReviewerFileAccess" value="1"{if $restrictReviewerFileAccess} checked="checked"{/if} />
			<label for="restrictReviewerFileAccess">{translate key="manager.setup.reviewOptions.restrictReviewerFileAccess"}</label>
		</div>
	</div>
</div>

<div class="form-row">
	<p class="label">{translate key="manager.setup.reviewOptions.blindReview"}</p>
	<input type="checkbox" name="showEnsuringLink" id="showEnsuringLink" value="1"{if $showEnsuringLink} checked="checked"{/if} />
	{get_help_id|assign:"blindReviewHelpId" key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}
	<label class="label--inline label--normal" for="showEnsuringLink">{translate key="manager.setup.reviewOptions.showEnsuringLink" blindReviewHelpId=$blindReviewHelpId}</label>
</div>

</section>


<section id="privacyStatementInfo">
<h3>2.3 {fieldLabel name="privacyStatement" key="manager.setup.privacyStatement"}</h3>

<div class="form-row">
	<textarea name="privacyStatement[{$formLocale|escape}]" id="privacyStatement" rows="12" cols="60" class="textArea">{$privacyStatement[$formLocale]|escape}</textarea>
</div>

</section>



<section id="editorDecision">
<h3>2.4 {translate key="manager.setup.editorDecision"}</h3>

<div class="form-row">
<input type="checkbox" name="notifyAllAuthorsOnDecision" id="notifyAllAuthorsOnDecision" value="1"{if $notifyAllAuthorsOnDecision} checked="checked"{/if} /> <label class="label--inline label--normal" for="notifyAllAuthorsOnDecision">{translate key="manager.setup.notifyAllAuthorsOnDecision"}</label>

</div>
</section>



<section id="addItemtoAboutJournal">
<h3>2.5 {translate key="manager.setup.addItemtoAboutJournal"}</h3>


{foreach name=customAboutItems from=$customAboutItems[$formLocale] key=aboutId item=aboutItem}
	<div class="form-row">
		{fieldLabel name="customAboutItems-$aboutId-title" key="common.title"}
		<input type="text" name="customAboutItems[{$formLocale|escape}][{$aboutId|escape}][title]" id="customAboutItems-{$aboutId|escape}-title" value="{$aboutItem.title|escape}" size="40" maxlength="255" class="textField" />{if $smarty.foreach.customAboutItems.total > 1} <input type="submit" name="delCustomAboutItem[{$aboutId|escape}]" value="{translate key="common.delete"}" class="button" />{/if}
	</div>
	<div class="form-row">
		{fieldLabel name="customAboutItems-$aboutId-content" key="manager.setup.aboutItemContent"}
		<textarea name="customAboutItems[{$formLocale|escape}][{$aboutId|escape}][content]" id="customAboutItems-{$aboutId|escape}-content" rows="12" cols="40" class="textArea">{$aboutItem.content|escape}</textarea>
	</div>
{foreachelse}
	<div class="form-row">
		{fieldLabel name="customAboutItems-0-title" key="common.title"}
		<input type="text" name="customAboutItems[{$formLocale|escape}][0][title]" id="customAboutItems-0-title" value="" size="40" maxlength="255" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="customAboutItems-0-content" key="manager.setup.aboutItemContent"}
		<textarea name="customAboutItems[{$formLocale|escape}][0][content]" id="customAboutItems-0-content" rows="12" cols="40" class="textArea"></textarea>
	</div>
{/foreach}


<div class="buttons">
	<input type="submit" name="addCustomAboutItem" value="{translate key="manager.setup.addAboutItem"}" class="button" />
</div>

</section>


<section id="journalArchiving">
<h3>2.6 {translate key="manager.setup.journalArchiving"}</h3>

<p>{translate key="manager.setup.preservationDescription"}</p>

{call_hook name="Templates::Manager::Setup::JournalArchiving"}

<p>{translate key="manager.setup.lockssDescription" lockssExistingArchiveUrl=$lockssExistingArchiveUrl lockssNewArchiveUrl=$lockssNewArchiveUrl}</p>

{url|assign:"lockssUrl" page="gateway" op="lockss"}
<div class="form-row">
	<input type="checkbox" name="enableLockss" id="enableLockss" value="1"{if $enableLockss} checked="checked"{/if} /> <label class="label--inline label--normal" for="enableLockss">{translate key="manager.setup.lockssEnable" lockssUrl=$lockssUrl}</label>
	<textarea name="lockssLicense[{$formLocale|escape}]" id="lockssLicense" rows="6" cols="60" class="textArea">{$lockssLicense[$formLocale]|escape}</textarea>
	
	<p class="instruct">{fieldLabel name="lockssLicense" key="manager.setup.lockssLicenses"}</p>
</div>

</section>



<section id="reviewerDatabaseLink">
<h3>2.7 {translate key="manager.setup.reviewerDatabaseLink"}</h3>

<p>{translate key="manager.setup.reviewerDatabaseLink.desc"}</p>

{foreach name=reviewerDatabaseLinks from=$reviewerDatabaseLinks key=reviewerDatabaseLinkId item=reviewerDatabaseLink}
	<div class="form-row">
		{fieldLabel name="reviewerDatabaseLinks-$reviewerDatabaseLinkId-title" key="common.title"}
		<input type="text" name="reviewerDatabaseLinks[{$reviewerDatabaseLinkId|escape}][title]" id="reviewerDatabaseLinks-{$reviewerDatabaseLinkId|escape}-title" value="{$reviewerDatabaseLink.title|escape}" size="40" maxlength="255" class="textField" />{if $smarty.foreach.reviewerDatabaseLinks.total > 1} <input type="submit" name="delReviewerDatabaseLink[{$reviewerDatabaseLinkId|escape}]" value="{translate key="common.delete"}" class="button" />{/if}
	</div>
	<div class="form-row">
		{fieldLabel name="reviewerDatabaseLinks-$reviewerDatabaseLinkId-url" key="common.url"}
		<input type="text" name="reviewerDatabaseLinks[{$reviewerDatabaseLinkId|escape}][url]" id="reviewerDatabaseLinks-{$reviewerDatabaseLinkId|escape}-url" value="{$reviewerDatabaseLink.url|escape}" size="40" maxlength="255" class="textField" />
	</div>
{foreachelse}
	<div class="form-row">
		{fieldLabel name="reviewerDatabaseLinks-0-title" key="common.title"}
		<input type="text" name="reviewerDatabaseLinks[0][title]" id="reviewerDatabaseLinks-0-title" value="" size="40" maxlength="255" class="textField" />
	</div>
	<div class="form-row">
		{fieldLabel name="reviewerDatabaseLinks-0-url" key="common.url"}
		<input type="text" name="reviewerDatabaseLinks[0][url]" id="reviewerDatabaseLinks-0-url" value="" size="40" maxlength="255" class="textField" />
	</div>
{/foreach}


<div class="buttons">
	<input type="submit" name="addReviewerDatabaseLink" value="{translate key="manager.setup.addReviewerDatabaseLink"}" class="button" />
</div>
</section>


<div class="buttons">
	<input type="submit" value="{translate key="common.saveAndContinue"}" class="button defaultButton" /> <input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="setup" escape=false}'" />
</div>

<p>
	<span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}

