{**
 * templates/about/editorialPolicies.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Editorial Policies.
 * 
 *}
{strip}
{assign var="pageTitle" value="about.editorialPolicies"}
{include file="common/header.tpl"}
{/strip}

<ul>
	{if $currentJournal->getLocalizedSetting('focusScopeDesc') != ''}<li id="linkFocusScopeDesc"><a href="{url op="editorialPolicies" anchor="focusAndScope"}">{translate key="about.focusAndScope"}</a></li>{/if}
	<li id="linkEditorialPolicies"><a href="{url op="editorialPolicies" anchor="sectionPolicies"}">{translate key="about.sectionPolicies"}</a></li>
	{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}<li id="linkReviewPolicy"><a href="{url op="editorialPolicies" anchor="peerReviewProcess"}">{translate key="about.peerReviewProcess"}</a></li>{/if}
	{if $currentJournal->getLocalizedSetting('pubFreqPolicy') != ''}<li id="linkPubFreqPolicy"><a href="{url op="editorialPolicies" anchor="publicationFrequency"}">{translate key="about.publicationFrequency"}</a></li>{/if}
	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN && $currentJournal->getLocalizedSetting('openAccessPolicy') != ''}<li id="linkOpenAccessPolicy"><a href="{url op="editorialPolicies" anchor="openAccessPolicy"}">{translate key="about.openAccessPolicy"}</a></li>{/if}
	{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
		{if $currentJournal->getSetting('enableAuthorSelfArchive')}<li id="enabledAuthorSelfArchive"><a href="{url op="editorialPolicies" anchor="authorSelfArchivePolicy"}">{translate key="about.authorSelfArchive"}</a></li>{/if}
		{if $currentJournal->getSetting('enableDelayedOpenAccess')}<li id="enabledDelayedOpenAccess"><a href="{url op="editorialPolicies" anchor="delayedOpenAccessPolicy"}">{translate key="about.delayedOpenAccess"}</a></li>{/if}
		{if $paymentConfigured && $currentJournal->getSetting('journalPaymentsEnabled') && $currentJournal->getSetting('acceptSubscriptionPayments') && $currentJournal->getSetting('purchaseIssueFeeEnabled') && $currentJournal->getSetting('purchaseIssueFee') > 0}<li id="purchaseIssue"><a href="{url op="editorialPolicies" anchor="purchaseIssue"}">{translate key="about.purchaseIssue"}</a></li>{/if}
		{if $paymentConfigured && $currentJournal->getSetting('journalPaymentsEnabled') && $currentJournal->getSetting('acceptSubscriptionPayments') && $currentJournal->getSetting('purchaseArticleFeeEnabled') && $currentJournal->getSetting('purchaseArticleFee') > 0}<li id="purchaseArticle"><a href="{url op="editorialPolicies" anchor="purchaseArticle"}">{translate key="about.purchaseArticle"}</a></li>{/if}
	{/if}
	{if $currentJournal->getSetting('enableLockss') && $currentJournal->getLocalizedSetting('lockssLicense') != ''}<li id="linkLockssLicense"><a href="{url op="editorialPolicies" anchor="archiving"}">{translate key="about.archiving"}</a></li>{/if}
	{foreach key=key from=$currentJournal->getLocalizedSetting('customAboutItems') item=customAboutItem}
		{if !empty($customAboutItem.title)}
			<li><a href="{url op="editorialPolicies" anchor=custom-$key}">{$customAboutItem.title|escape}</a></li>
		{/if}
	{/foreach}
</ul>

{if $currentJournal->getLocalizedSetting('focusScopeDesc') != ''}
<div id="focusAndScope"><h3>{translate key="about.focusAndScope"}</h3>
<p>{$currentJournal->getLocalizedSetting('focusScopeDesc')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

<div id="sectionPolicies"><h3>{translate key="about.sectionPolicies"}</h3>
{foreach from=$sections item=section}{if !$section->getHideAbout()}
	<h4>{$section->getLocalizedTitle()}</h4>
	{if strlen($section->getLocalizedPolicy()) > 0}
		<p>{$section->getLocalizedPolicy()|nl2br}</p>
	{/if}

	{assign var="hasEditors" value=0}
	{foreach from=$sectionEditorEntriesBySection item=sectionEditorEntries key=key}
		{if $key == $section->getId()}
			{foreach from=$sectionEditorEntries item=sectionEditorEntry}
				{assign var=sectionEditor value=$sectionEditorEntry.user}
				{if 0 == $hasEditors++}
				{translate key="user.role.editors"}
				<ul>
				{/if}
				<li>{$sectionEditor->getFirstName()|escape} {$sectionEditor->getLastName()|escape}{if $sectionEditor->getLocalizedAffiliation()}, {$sectionEditor->getLocalizedAffiliation()|escape}{/if}</li>
			{/foreach}
		{/if}
	{/foreach}
	{if $hasEditors}</ul>{/if}

	<table width="60%">
		<tr>
			<td width="33%">{if !$section->getEditorRestricted()}{icon name="checked"}{else}{icon name="unchecked"}{/if} {translate key="manager.sections.open"}</td>
			<td width="33%">{if $section->getMetaIndexed()}{icon name="checked"}{else}{icon name="unchecked"}{/if} {translate key="manager.sections.indexed"}</td>
			<td width="34%">{if $section->getMetaReviewed()}{icon name="checked"}{else}{icon name="unchecked"}{/if} {translate key="manager.sections.reviewed"}</td>
		</tr>
	</table>
{/if}{/foreach}
</div>

<div class="separator">&nbsp;</div>

{if $currentJournal->getLocalizedSetting('reviewPolicy') != ''}<div id="peerReviewProcess"><h3>{translate key="about.peerReviewProcess"}</h3>
<p>{$currentJournal->getLocalizedSetting('reviewPolicy')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getLocalizedSetting('pubFreqPolicy') != ''}
<div id="publicationFrequency"><h3>{translate key="about.publicationFrequency"}</h3>
<p>{$currentJournal->getLocalizedSetting('pubFreqPolicy')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_OPEN && $currentJournal->getLocalizedSetting('openAccessPolicy') != ''} 
<div id="openAccessPolicy"><h3>{translate key="about.openAccessPolicy"}</h3>
<p>{$currentJournal->getLocalizedSetting('openAccessPolicy')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $currentJournal->getSetting('enableAuthorSelfArchive')} 
<div id="authorSelfArchivePolicy"><h3>{translate key="about.authorSelfArchive"}</h3> 
<p>{$currentJournal->getLocalizedSetting('authorSelfArchivePolicy')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $currentJournal->getSetting('enableDelayedOpenAccess')}
<div id="delayedOpenAccessPolicy"><h3>{translate key="about.delayedOpenAccess"}</h3> 
<p>{translate key="about.delayedOpenAccessDescription1"} {$currentJournal->getSetting('delayedOpenAccessDuration')} {translate key="about.delayedOpenAccessDescription2"}</p>
{if $currentJournal->getLocalizedSetting('delayedOpenAccessPolicy') != ''}
	<p>{$currentJournal->getLocalizedSetting('delayedOpenAccessPolicy')|nl2br}</p>
{/if}

<div class="separator">&nbsp;</div>
</div>
{/if}

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION &&
	$paymentConfigured &&
	$currentJournal->getSetting('journalPaymentsEnabled') &&
	$currentJournal->getSetting('acceptSubscriptionPayments') &&
	$currentJournal->getSetting('purchaseIssueFeeEnabled') &&
	$currentJournal->getSetting('purchaseIssueFee') > 0}
		<div id="purchaseIssue">
			<h3>{translate key="about.purchaseIssue"}</h3>
			<p>{translate key="about.purchaseIssueDescription"}</p>
			<p>{if $currentJournal->getLocalizedSetting('purchaseIssueFeeName') != ''}{$currentJournal->getLocalizedSetting('purchaseIssueFeeName')|escape}: {/if}{$currentJournal->getSetting('purchaseIssueFee')|string_format:"%.2f"} {if $currentJournal->getSetting('currency') != ''}({$currentJournal->getSetting('currency')|escape}){/if}</p>
			{if $currentJournal->getLocalizedSetting('purchaseIssueFeeDescription') != ''}
				<p>{$currentJournal->getLocalizedSetting('purchaseIssueFeeDescription')|nl2br}</p>
			{/if}

			<div class="separator">&nbsp;</div>
		</div>
{/if}

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION &&
	$paymentConfigured &&
	$currentJournal->getSetting('journalPaymentsEnabled') &&
	$currentJournal->getSetting('acceptSubscriptionPayments') &&
	$currentJournal->getSetting('purchaseArticleFeeEnabled') &&
	$currentJournal->getSetting('purchaseArticleFee') > 0}
		<div id="purchaseArticle">
			<h3>{translate key="about.purchaseArticle"}</h3>
			<p>{translate key="about.purchaseArticleDescription"}</p>
			<p>{if $currentJournal->getLocalizedSetting('purchaseArticleFeeName') != ''}{$currentJournal->getLocalizedSetting('purchaseArticleFeeName')|escape}: {/if} {$currentJournal->getSetting('purchaseArticleFee')|string_format:"%.2f"} {if $currentJournal->getSetting('currency') != ''}({$currentJournal->getSetting('currency')|escape}){/if}</p>
			{if $currentJournal->getLocalizedSetting('purchaseArticleFeeDescription') != ''}
				<p>{$currentJournal->getLocalizedSetting('purchaseArticleFeeDescription')|nl2br}</p>
			{/if}

			<div class="separator">&nbsp;</div>
		</div>
{/if}

{if $currentJournal->getSetting('enableLockss') && $currentJournal->getLocalizedSetting('lockssLicense') != ''}
<div id="archiving"><h3>{translate key="about.archiving"}</h3>
<p>{$currentJournal->getLocalizedSetting('lockssLicense')|nl2br}</p>

<div class="separator">&nbsp;</div>
</div>
{/if}

{foreach key=key from=$currentJournal->getLocalizedSetting('customAboutItems') item=customAboutItem name=customAboutItems}
	{if !empty($customAboutItem.title)}
		<div id="custom-{$key|escape}"><h3>{$customAboutItem.title|escape}</h3>
		<p>{$customAboutItem.content|nl2br}</p>
		{if !$smarty.foreach.customAboutItems.last}<div class="separator">&nbsp;</div>{/if}
		</div>
	{/if}
{/foreach}

{include file="common/footer.tpl"}

