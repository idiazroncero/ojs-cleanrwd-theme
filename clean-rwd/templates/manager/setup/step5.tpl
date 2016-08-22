{**
 * templates/manager/setup/step5.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 5 of journal setup.
 *
 *}
{assign var="pageTitle" value="manager.setup.customizingTheLook"}
{include file="manager/setup/setupHeader.tpl"}

<script type="text/javascript">
{literal}
<!--

// Swap the given entries in the select field.
function swapEntries(field, i, j) {
	var tmpLabel = field.options[j].label;
	var tmpVal = field.options[j].value;
	var tmpText = field.options[j].text;
	var tmpSel = field.options[j].selected;
	field.options[j].label = field.options[i].label;
	field.options[j].value = field.options[i].value;
	field.options[j].text = field.options[i].text;
	field.options[j].selected = field.options[i].selected;
	field.options[i].label = tmpLabel;
	field.options[i].value = tmpVal;
	field.options[i].text = tmpText;
	field.options[i].selected = tmpSel;
}

// Move selected items up in the given select list.
function moveUp(field) {
	var i;
	for (i=0; i<field.length; i++) {
		if (field.options[i].selected == true && i>0) {
			swapEntries(field, i-1, i);
		}
	}
}

// Move selected items down in the given select list.
function moveDown(field) {
	var i;
	var max = field.length - 1;
	for (i = max; i >= 0; i=i-1) {
		if(field.options[i].selected == true && i < max) {
			swapEntries(field, i+1, i);
		}
	}
}

// Move selected items from select list a to select list b.
function jumpList(a, b) {
	var i;
	for (i=0; i<a.options.length; i++) {
		if (a.options[i].selected == true) {
			bMax = b.options.length;
			b.options[bMax] = new Option(a.options[i].text);
			b.options[bMax].value = a.options[i].value;
			a.options[i] = null;
			i=i-1;
		}
	}
}

function prepBlockFields() {
	var i;
	var theForm = document.getElementById('setupForm');

	theForm.elements["blockSelectLeft"].value = "";
	for (i=0; i<theForm.blockSelectLeftWidget.options.length; i++) {
		theForm.blockSelectLeft.value += encodeURI(theForm.blockSelectLeftWidget.options[i].value) + " ";
	}

	theForm.blockSelectRight.value = "";
	for (i=0; i<theForm.blockSelectRightWidget.options.length; i++) {
		theForm.blockSelectRight.value += encodeURI(theForm.blockSelectRightWidget.options[i].value) + " ";
	}

	theForm.blockUnselected.value = "";
	for (i=0; i<theForm.blockUnselectedWidget.options.length; i++) {
		theForm.blockUnselected.value += encodeURI(theForm.blockUnselectedWidget.options[i].value) + " ";
	}
	return true;
}

// -->
{/literal}
</script>

<form id="setupForm" method="post" action="{url op="saveSetup" path="5"}" enctype="multipart/form-data">
{include file="common/formErrors.tpl"}

{if count($formLocales) > 1}

	<div class="form-row">
		{fieldLabel name="formLocale" key="form.formLanguage"}
		{url|assign:"setupFormUrl" op="setup" path="5" escape=false}
		{form_language_chooser form="setupForm" url=$setupFormUrl}
		<p class="instruct">{translate key="form.formLanguage.description"}</p>
	</div>

{/if}

<section id="journalHomepageHeader">
<h3>5.1 {translate key="manager.setup.journalHomepageHeader"}</h3>

<p>{translate key="manager.setup.journalHomepageHeaderDescription"}</p>

<section class="section" id="journalTitleAndLogo">
<h4>{translate key="manager.setup.journalTitle"}</h4>


<div class="form-subrow">
	
	<div class="form-group">
		<input type="radio" name="homeHeaderTitleType[{$formLocale|escape}]" id="homeHeaderTitleType-0" value="0"{if not $homeHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="homeHeaderTitleType-0" key="manager.setup.useTextTitle"}
		<input type="text" name="homeHeaderTitle[{$formLocale|escape}]" value="{$homeHeaderTitle[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
	</div>
	
	<div class="form-group">
		<div class="form-group">
			<input type="radio" name="homeHeaderTitleType[{$formLocale|escape}]" id="homeHeaderTitleType-1" value="1"{if $homeHeaderTitleType[$formLocale]} checked="checked"{/if} /> 
			{fieldLabel name="homeHeaderTitleType-1" key="manager.setup.useImageTitle"}
		</div>
		<div class="form-group">
			<input type="file" name="homeHeaderTitleImage" class="uploadField" />
			<input type="submit" name="uploadHomeHeaderTitleImage" value="{translate key="common.upload"}" class="button button--small" />
		</div>
		{if $homeHeaderTitleImage[$formLocale]}
		<div class="form-subrow">
			<img src="{$publicFilesDir}/{$homeHeaderTitleImage[$formLocale].uploadName|escape:"url"}" width="{$homeHeaderTitleImage[$formLocale].width|escape}" height="{$homeHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.homePageHeader.altText"}" />
			<div class="form-group">
				{fieldLabel name="homeHeaderTitleImageAltText" key="common.altText"}
				<input type="text" name="homeHeaderTitleImageAltText[{$formLocale|escape}]" value="{$homeHeaderTitleImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
				<p class="instruct">{translate key="common.altTextInstructions"}</p>
			</div>
			<div class="form-group">
				<span class="instruct">
				 	{translate key="common.fileName"}: {$homeHeaderTitleImage[$formLocale].name|escape}
				 	{$homeHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort}
				 </span> 
				<input type="submit" name="deleteHomeHeaderTitleImage" value="{translate key="common.delete"}" class="button button--small" />
			</div>
		</div>
		{/if}
	</div>
</div>

</section>

<section id="journalLogoImage">
<h4>{translate key="manager.setup.journalLogo"}</h4>
	

	<div class="form-row">
		<div class="form-group">
			{fieldLabel name="homeHeaderLogoImage" key="manager.setup.useImageLogo"}
			<input type="file" name="homeHeaderLogoImage" id="homeHeaderLogoImage" class="uploadField" />
			<input type="submit" name="uploadHomeHeaderLogoImage" value="{translate key="common.upload"}" class="button" />
		</div>

		{if $homeHeaderLogoImage[$formLocale]}
			<div class="form-subrow">
				<img src="{$publicFilesDir}/{$homeHeaderLogoImage[$formLocale].uploadName|escape:"url"}" width="{$homeHeaderLogoImage[$formLocale].width|escape}" height="{$homeHeaderLogoImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.homePageHeaderLogo.altText"}" />
				<div class="form-group">
					{fieldLabel name="homeHeaderLogoImageAltText" key="common.altText"}
					<input type="text" name="homeHeaderLogoImageAltText[{$formLocale|escape}]" value="{$homeHeaderLogoImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
					<p class="instruct">{translate key="common.altTextInstructions"}</p>
				</div>
				<div class="form-group">
					<span class="instruct">{translate key="common.fileName"}: {$homeHeaderLogoImage[$formLocale].name|escape} {$homeHeaderLogoImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort}</span><input type="submit" name="deleteHomeHeaderLogoImage" value="{translate key="common.delete"}" class="button button--small" />
				</div>
			</div>
		{/if}

	</div>


</section>

<section id="journalThumbnail">
<h4>{translate key="manager.setup.journalThumbnail"}</h4>


	<div class="form-row">
		<div class="form-group">
			{fieldLabel name="journalThumbnail" key="manager.setup.useThumbnail"}
			<input type="file" name="journalThumbnail" id="journalThumbnail" class="uploadField" />
			<input type="submit" name="uploadJournalThumbnail" value="{translate key="common.upload"}" class="button" />
		</div>

		
		{if $journalThumbnail[$formLocale]}
			<div class="form-subrow">
				<img src="{$publicFilesDir}/{$journalThumbnail[$formLocale].uploadName|escape:"url"}" width="{$journalThumbnail[$formLocale].width|escape}" height="{$journalThumbnail[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.journalThumbnail.altText"}" />
				<div class="form-group">
					{fieldLabel name="journalThumbnailAltText" key="common.altText"}
					<input type="text" name="journalThumbnailAltText[{$formLocale|escape}]" value="{$journalThumbnailAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
					<p class="instruct">{translate key="common.altTextInstructions"}</p>
				</div>
				<div class="form-group">
					<span class="instruct">{translate key="common.fileName"}: {$journalThumbnail[$formLocale].name|escape} {$journalThumbnail[$formLocale].dateUploaded|date_format:$datetimeFormatShort}</span> <input type="submit" name="deleteJournalThumbnail" value="{translate key="common.delete"}" class="button" />
				</div>
			</div>
		{/if}

	</div>


<section id="journalHomepageContent">
<h3>5.2 {translate key="manager.setup.journalHomepageContent"}</h3>

<p>{translate key="manager.setup.journalHomepageContentDescription"}</p>
</section>

<section class="section" id="journalDescription">
<h4>{fieldLabel name="description" key="manager.setup.journalDescription"}</h4>

<p>{translate key="manager.setup.journalDescriptionDescription"}</p>

<p><textarea id="description" name="description[{$formLocale|escape}]" rows="3" cols="60" class="textArea">{$description[$formLocale]|escape}</textarea></p>
</section>

<section id="homepageImage">
<h4>{translate key="manager.setup.homepageImage"}</h4>

<p>{translate key="manager.setup.homepageImageDescription"}</p>


	<div class="form-row">
		<div class="form-group">
			{fieldLabel name="homepageImage" key="manager.setup.homepageImage"}
			<input type="file" name="homepageImage" id="homepageImage" class="uploadField" />
			<input type="submit" name="uploadHomepageImage" value="{translate key="common.upload"}" class="button button--small" />
		</div>
		{if $homepageImage[$formLocale]}
		<div class="form-subrow">
			<div class="form-group">
				<img src="{$publicFilesDir}/{$homepageImage[$formLocale].uploadName|escape:"url"}" width="{$homepageImage[$formLocale].width|escape}" height="{$homepageImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.journalHomepageImage.altText"}" />
			</div>

			<div class="form-group">
				{fieldLabel name="homepageImageAltText" key="common.altText"}
				<input type="text" name="homepageImageAltText[{$formLocale|escape}]" value="{$homepageImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
				<div class="instruct">{translate key="common.altTextInstructions"}</div>
			</div>
			<div class="form-group">
				<p class="instruct">{translate key="common.fileName"}: {$homepageImage[$formLocale].name|escape} {$homepageImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort}</p>
				<input type="submit" name="deleteHomepageImage" value="{translate key="common.delete"}" class="button button--small" />
			</div>
		</div>
		{/if}
		
	</div>



<section class="section" id="currentIssue">
<h4>{translate key="manager.setup.currentIssue"}</h4>


	<div class="form-subrow">
		<input type="checkbox" name="displayCurrentIssue" id="displayCurrentIssue" value="1" {if $displayCurrentIssue} checked="checked"{/if} />
		<label for="displayCurrentIssue">{translate key="manager.setup.displayCurrentIssue"}</label>
	</div>

</section>


<section class="section" id="additionalContent">

<h4>{fieldLabel name="additionalHomeContent" key="manager.setup.additionalContent"}</h4>

<p>{translate key="manager.setup.additionalContentDescription"}</p>

<p><textarea name="additionalHomeContent[{$formLocale|escape}]" id="additionalHomeContent" rows="12" cols="60" class="textArea">{$additionalHomeContent[$formLocale]|escape}</textarea></p>

</section>
</section>



<section id="journalPageHeaderInfo">
<h3>5.3 {translate key="manager.setup.journalPageHeader"}</h3>

<p>{translate key="manager.setup.journalPageHeaderDescription"}</p>

<section class="section" id="pageHeaderTitle">
<h4>{translate key="manager.setup.journalTitle"}</h4>


	<div class="form-subrow">
		<div class="form-group">
			<input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-0" value="0"{if not $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-0" key="manager.setup.useTextTitle"}
			<input type="text" name="pageHeaderTitle[{$formLocale|escape}]" value="{$pageHeaderTitle[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
		</div>
		<div class="form-group">
			<input type="radio" name="pageHeaderTitleType[{$formLocale|escape}]" id="pageHeaderTitleType-1" value="1"{if $pageHeaderTitleType[$formLocale]} checked="checked"{/if} /> {fieldLabel name="pageHeaderTitleType-1" key="manager.setup.useImageTitle"}
			<input type="file" name="pageHeaderTitleImage" class="uploadField" />
			<input type="submit" name="uploadPageHeaderTitleImage" value="{translate key="common.upload"}" class="button button--small" />
			{if $pageHeaderTitleImage[$formLocale]}
			<div class="form-subrow">
				<div class="form-group">
					<img src="{$publicFilesDir}/{$pageHeaderTitleImage[$formLocale].uploadName|escape:"url"}" width="{$pageHeaderTitleImage[$formLocale].width|escape}" height="{$pageHeaderTitleImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.pageHeader.altText"}" />
				</div>
				<div class="form-group">
					{fieldLabel name="pageHeaderTitleImageAltText" key="common.altText"}
					<input type="text" name="pageHeaderTitleImageAltText[{$formLocale|escape}]" value="{$pageHeaderTitleImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
					<p class="instruct">
						{translate key="common.altTextInstructions"}
					</p>
				</div>
				<div class="form-group">
					<span class="instruct">{translate key="common.fileName"}: {$pageHeaderTitleImage[$formLocale].name|escape} {$pageHeaderTitleImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort}</span>
					<input type="submit" name="deletePageHeaderTitleImage" value="{translate key="common.delete"}" class="button button--small" />
				</div>
			</div>	
			{/if}
		</div>
	</div>

</section>

<section id="journalLogo">
<h4>{translate key="manager.setup.journalLogo"}</h4>


<div class="form-row">
	<div class="form-group">
		{fieldLabel name="pageHeaderLogoImage" key="manager.setup.useImageLogo"}
		<input type="file" name="pageHeaderLogoImage" id="pageHeaderLogoImage" class="uploadField" />
		<input type="submit" name="uploadPageHeaderLogoImage" value="{translate key="common.upload"}" class="button button--small" />
	</div>
	{if $pageHeaderLogoImage[$formLocale]}
	<div class="form-subrow">
		
		<div class="form-group">
			<img src="{$publicFilesDir}/{$pageHeaderLogoImage[$formLocale].uploadName|escape:"url"}" width="{$pageHeaderLogoImage[$formLocale].width|escape}" height="{$pageHeaderLogoImage[$formLocale].height|escape}" style="border: 0;" alt="{translate key="common.pageHeaderLogo.altText"}" />
		</div>
		<div class="form-group">
			{fieldLabel name="pageHeaderLogoImageAltText" key="common.altText"}
			<input type="text" name="pageHeaderLogoImageAltText[{$formLocale|escape}]" value="{$pageHeaderLogoImageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" />
			<div class="instruct">{translate key="common.altTextInstructions"}</div>
		</div>
		<div class="form-group">
			<p class="instruct">{translate key="common.fileName"}: {$pageHeaderLogoImage[$formLocale].name|escape} {$pageHeaderLogoImage[$formLocale].dateUploaded|date_format:$datetimeFormatShort} </p>
			<input type="submit" name="deletePageHeaderLogoImage" value="{translate key="common.delete"}" class="button button--small" />
		</div>
	</div>
	{/if}
</div>
</section>

<section id="journalFavicon">
<h4>{translate key="manager.setup.journalFavicon"}</h4>

<p>{translate key="manager.setup.journalFaviconDescription"}</p>


<div class="form-row">
	<div class="form-group">
		{fieldLabel name="journalFavicon" key="manager.setup.useImageLogo"}
		<input type="file" name="journalFavicon" id="journalFavicon" class="uploadField" />
		<input type="submit" name="uploadJournalFavicon" value="{translate key="common.upload"}" class="button button--small" />
	</div>
	{if $journalFavicon[$formLocale]}
	<div class="form-subrow">
		<div class="form-group">
			<img src="{$publicFilesDir}/{$journalFavicon[$formLocale].uploadName|escape:"url"}" width="16px" height="16px" style="border: 0;" alt="favicon" />
		</div>
		<div class="form-group">
			<p class="instruct">{translate key="common.fileName"}: {$journalFavicon[$formLocale].name|escape} {$journalFavicon[$formLocale].dateUploaded|date_format:$datetimeFormatShort} </p>
			<input type="submit" name="deleteJournalFavicon" value="{translate key="common.delete"}" class="button button--small" />
		</div>
	</div>
	{/if}
</div>

</section>

<section class="section" id="alternateHeader">
<h4>{fieldLabel name="journalPageHeader" key="manager.setup.alternateHeader"}</h4>

<p>{translate key="manager.setup.alternateHeaderDescription"}</p>

<p><textarea name="journalPageHeader[{$formLocale|escape}]" id="journalPageHeader" rows="12" cols="60" class="textArea">{$journalPageHeader[$formLocale]|escape}</textarea></p>
</section>
</section>


<section class="section" id="journalPageFooterInfo">
<h3>5.4 {fieldLabel name="journalPageFooter" key="manager.setup.journalPageFooter"}</h3>

<p>{translate key="manager.setup.journalPageFooterDescription"}</p>

<p><textarea name="journalPageFooter[{$formLocale|escape}]" id="journalPageFooter" rows="12" cols="60" class="textArea">{$journalPageFooter[$formLocale]|escape}</textarea></p>
</section>



<section id="navigationBar">
<h3>5.5 {translate key="manager.setup.navigationBar"}</h3>

<p>{translate key="manager.setup.itemsDescription"}</p>


{foreach name=navItems from=$navItems[$formLocale] key=navItemId item=navItem}
	<div class="form-row">
		<div class="form-subrow">
			<div class="form-group">
				<div class="form-group">
					{fieldLabel name="navItems-$navItemId-name" key="manager.setup.labelName"}
					<input type="text" name="navItems[{$formLocale|escape}][{$navItemId|escape}][name]" id="navItems-{$navItemId|escape}-name" value="{$navItem.name|escape}" size="30" maxlength="90" class="textField" />
				</div>
				<div class="form-subrow">
					<input type="checkbox" name="navItems[{$formLocale|escape}][{$navItemId|escape}][isLiteral]" id="navItems-{$navItemId|escape}-isLiteral" value="1"{if $navItem.isLiteral} checked="checked"{/if} />
					<label for="navItems-{$navItemId|escape}-isLiteral">{translate key="manager.setup.navItemIsLiteral"}</label>
				</div>
			</div>
			<div class="form-group">
				<div class="form-group">
					{fieldLabel name="navItems-$navItemId-url" key="common.url"}
					<input type="text" name="navItems[{$formLocale|escape}][{$navItemId|escape}][url]" id="navItems-{$navItemId|escape}-url" value="{$navItem.url|escape}" size="60" maxlength="255" class="textField" />
				</div>
				<div class="form-subrow">
					<input type="checkbox" name="navItems[{$formLocale|escape}][{$navItemId|escape}][isAbsolute]" id="navItems-{$navItemId|escape}-isAbsolute" value="1"{if $navItem.isAbsolute} checked="checked"{/if} />
					<label for="navItems-{$navItemId|escape}-isAbsolute">{translate key="manager.setup.navItemIsAbsolute"}</label>
				</div>
			</div>

		</div>
		<div class="buttons">
			<input type="submit" name="delNavItem[{$navItemId|escape}]" value="{translate key="common.delete"}" class="button" />
		</div>	
	</div>

{foreachelse}
	<tr >
		<td width="20%" class="label">{fieldLabel name="navItems-0-name" key="manager.setup.labelName"}</td>
		<td width="80%" class="value">
			<input type="text" name="navItems[{$formLocale|escape}][0][name]" id="navItems-0-name" size="30" maxlength="90" class="textField" />
			<table>
				<tr >
					<td width="5%"><input type="checkbox" name="navItems[{$formLocale|escape}][0][isLiteral]" id="navItems-0-isLiteral" value="1" /></td>
					<td width="95%"><label for="navItems-0-isLiteral">{translate key="manager.setup.navItemIsLiteral"}</label></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr >
		<td width="20%" class="label">{fieldLabel name="navItems-0-url" key="common.url"}</td>
		<td width="80%" class="value">
			<input type="text" name="navItems[{$formLocale|escape}][0][url]" id="navItems-0-url" size="60" maxlength="255" class="textField" />
			<table>
				<tr >
					<td width="5%"><input type="checkbox" name="navItems[{$formLocale|escape}][0][isAbsolute]" id="navItems-0-isAbsolute" value="1" /></td>
					<td width="95%"><label for="navItems-0-isAbsolute">{translate key="manager.setup.navItemIsAbsolute"}</label></td>
				</tr>
			</table>
		</td>
	</tr>
{/foreach}


<div class="buttons">
	<input type="submit" name="addNavItem" value="{translate key="manager.setup.addNavItem"}" class="button" />
</div>

</section>

<section class="section" id="journalLayout">
<h3>5.6 {translate key="manager.setup.journalLayout"}</h3>

<p>{translate key="manager.setup.journalLayoutDescription"}</p>

<div class="form-row">
	<label for="journalTheme">{translate key="manager.setup.journalTheme"}</label>
	<select name="journalTheme" class="selectMenu" id="journalTheme"{if empty($journalThemes)} disabled="disabled"{/if}>
			<option value="">{translate key="common.none"}</option>
			{foreach from=$journalThemes key=path item=journalThemePlugin}
				<option value="{$path|escape}"{if $path == $journalTheme} selected="selected"{/if}>{$journalThemePlugin->getDisplayName()|escape}</option>
			{/foreach}
		</select>
</div>

<div class="form-row">
	<label for="journalStyleSheet">{translate key="manager.setup.useJournalStyleSheet"}</label>
	<input type="file" name="journalStyleSheet" id="journalStyleSheet" class="uploadField" />
	<input type="submit" name="uploadJournalStyleSheet" value="{translate key="common.upload"}" class="button" />
</div>


{if $journalStyleSheet}
{translate key="common.fileName"}: <a href="{$publicFilesDir}/{$journalStyleSheet.uploadName|escape:"url"}" class="file">{$journalStyleSheet.name|escape}</a> {$journalStyleSheet.dateUploaded|date_format:$datetimeFormatShort} <input type="submit" name="deleteJournalStyleSheet" value="{translate key="common.delete"}" class="button" />
{/if}

<table id="assignBlocksToSidebars" border="0" align="center" style="width: 100%;">
	<tr align="center">
		<td rowspan="2" id="assignBlocksToSidebarLeft" style="with: 30%;" >
			{fieldLabel name="blockSelectLeftWidget" key="manager.setup.layout.leftSidebar"}
			<input class="button defaultButton" style="width: 100%;" type="button" value="&uarr;" onclick="moveUp(this.form.elements['blockSelectLeftWidget']);" />
			<select name="blockSelectLeftWidget" id="blockSelectLeftWidget" multiple="multiple" size="10" class="selectMenu" style="width: 100%; height:200px">
				{foreach from=$leftBlockPlugins item=block}
					<option value="{$block->getName()|escape}">{$block->getDisplayName()|escape}</option>
				{foreachelse}
					<option value=""></option>
				{/foreach}
			</select>
			<input class="button defaultButton" style="width: 100%;" type="button" value="&darr;" onclick="moveDown(this.form.elements['blockSelectLeftWidget']);" />
		</td>
		<td>
			<input class="button defaultButton" style="width: 100%;" type="button" value="&larr;" onclick="jumpList(this.form.elements['blockUnselectedWidget'],this.form.elements['blockSelectLeftWidget']);" />
			<input class="button defaultButton" style="width: 100%;" type="button" value="&rarr;" onclick="jumpList(this.form.elements['blockSelectLeftWidget'],this.form.elements['blockUnselectedWidget']);" />
		</td>
		<td  id="assignBlocksToSidebarUnselected" style="width: 30%;" >
			{fieldLabel name="blockUnselectedWidget" key="manager.setup.layout.unselected"}
			<select name="blockUnselectedWidget" id="blockUnselectedWidget" multiple="multiple" size="10" class="selectMenu" style="width: 100%; height:180px;" >
				{foreach from=$disabledBlockPlugins item=block}
					<option value="{$block->getName()|escape}">{$block->getDisplayName()|escape}</option>
				{foreachelse}
					<option value=""></option>
				{/foreach}
			</select>
		</td>
		<td>
			<input class="button defaultButton" style="width: 100%;" type="button" value="&larr;" onclick="jumpList(this.form.elements['blockSelectRightWidget'],this.form.elements['blockUnselectedWidget']);" />
			<input class="button defaultButton" style="width: 100%;" type="button" value="&rarr;" onclick="jumpList(this.form.elements['blockUnselectedWidget'],this.form.elements['blockSelectRightWidget']);" />
		</td>
		<td rowspan="2" id="assignBlocksToSidebarRight" style="width: 30%;">
			{fieldLabel name="blockSelectRightWidget" key="manager.setup.layout.rightSidebar"}
			<input class="button defaultButton" style="width: 100%;" type="button" value="&uarr;" onclick="moveUp(this.form.elements['blockSelectRightWidget']);" />
			<select name="blockSelectRightWidget" id="blockSelectRightWidget" multiple="multiple" size="10" class="selectMenu" style="width: 100%; height:200px" >
				{foreach from=$rightBlockPlugins item=block}
					<option value="{$block->getName()|escape}">{$block->getDisplayName()|escape}</option>
				{foreachelse}
					<option value=""></option>
				{/foreach}
			</select>
			<input class="button defaultButton" style="width: 100%;" type="button" value="&darr;" onclick="moveDown(this.form.elements['blockSelectRightWidget']);" />
		</td>
	</tr>
	<tr align="center">
		<td colspan="3"  height="60px">
			<input class="button defaultButton" style="width: 100%;" type="button" value="&larr;" onclick="jumpList(this.form.elements['blockSelectRightWidget'],this.form.elements['blockSelectLeftWidget']);" />
			<input class="button defaultButton" style="width: 100%;" type="button" value="&rarr;" onclick="jumpList(this.form.elements['blockSelectLeftWidget'],this.form.elements['blockSelectRightWidget']);" />
		</td>
	</tr>
</table>
<input type="hidden" name="blockSelectLeft" value="" />
<input type="hidden" name="blockSelectRight" value="" />
<input type="hidden" name="blockUnselected" value="" />
</section>


<section id="setupInfo">
<h3>5.7 {translate key="manager.setup.information"}</h3>

<p>{translate key="manager.setup.information.description"}</p>

<section class="section" id="infoForReaders"><h4>{fieldLabel name="readerInformation" key="manager.setup.information.forReaders"}</h4>

<p><textarea name="readerInformation[{$formLocale|escape}]" id="readerInformation" rows="12" cols="60" class="textArea">{$readerInformation[$formLocale]|escape}</textarea></p>
</section>

<section class="section" id="infoForAuth"><h4>{fieldLabel name="authorInformation" key="manager.setup.information.forAuthors"}</h4>

<p><textarea name="authorInformation[{$formLocale|escape}]" id="authorInformation" rows="12" cols="60" class="textArea">{$authorInformation[$formLocale]|escape}</textarea></p>
</section>

<section class="section" id="infoForLibs"><h4>{fieldLabel name="librarianInformation" key="manager.setup.information.forLibrarians"}</h4>

<p><textarea name="librarianInformation[{$formLocale|escape}]" id="librarianInformation" rows="12" cols="60" class="textArea">{$librarianInformation[$formLocale]|escape}</textarea></p>
</section>
</section>



<section id="lists">
<h3>5.8 {translate key="manager.setup.lists"}</h3>
<p>{translate key="manager.setup.listsDescription"}</p>

	<div class="form-row">
		{fieldLabel name="itemsPerPage" key="manager.setup.itemsPerPage"}
		<input type="text" size="3" name="itemsPerPage" id="itemsPerPage" class="textField" value="{$itemsPerPage|escape}" />
	</div>

	<div class="form-row">
		{fieldLabel name="numPageLinks" key="manager.setup.numPageLinks"}
		<td width="80%" class="value"><input type="text" size="3" name="numPageLinks" id="numPageLinks" class="textField" value="{$numPageLinks|escape}" />
	</div>

</section>




<div class="buttons">
	<input type="submit" onclick="prepBlockFields()" value="{translate key="common.saveAndContinue"}" class="button" />
	<input type="button" value="{translate key="common.cancel"}" class="button button--cancel" onclick="document.location.href='{url op="setup" escape=false}'" />
</div>

<p><span class="form-required">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}
