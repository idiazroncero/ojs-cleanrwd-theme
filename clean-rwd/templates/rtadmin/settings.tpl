{**
 * templates/rtadmin/settings.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RT Administration settings.
 *
 *}
{strip}
{assign var="pageTitle" value="rt.admin.settings"}
{include file="common/header.tpl"}
{/strip}

<form method="post" action="{url op="saveSettings"}">

<p>{translate key="rt.admin.settings.description"}</p>

<div class="form-row" id="enableRT">
	<input type="checkbox" {if $enabled}checked="checked" {/if}name="enabled" value="1" id="enabled"/>
	<label class="label--inline"for="enabled">{translate key="rt.admin.settings.enableReadingTools"}</label>
</div>


<div id="rtAdminOptions">
<h3>{translate key="rt.admin.options"}</h3>
<div class="form-subrow">
	<div class="form-group">
			<input type="checkbox" name="abstract" id="abstract" {if $abstract}checked="checked" {/if}/>
			<label for="abstract">{translate key="rt.admin.settings.abstract"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="captureCite" id="captureCite" {if $captureCite}checked="checked" {/if}/>
		<label for="captureCite">{translate key="rt.admin.settings.captureCite"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="viewMetadata" id="viewMetadata" {if $viewMetadata}checked="checked" {/if}/>
		<label for="viewMetadata">{translate key="rt.admin.settings.viewMetadata"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="supplementaryFiles" id="supplementaryFiles" {if $supplementaryFiles}checked="checked" {/if}/>
		<label for="supplementaryFiles">{translate key="rt.admin.settings.supplementaryFiles"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="printerFriendly" id="printerFriendly" {if $printerFriendly}checked="checked" {/if}/>
		<label for="printerFriendly">{translate key="rt.admin.settings.printerFriendly"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="defineTerms" id="defineTerms" {if $defineTerms}checked="checked" {/if}/>
		<label for="defineTerms">{translate key="rt.admin.settings.defineTerms"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="emailOthers" id="emailOthers" {if $emailOthers}checked="checked" {/if}/>
		<label for="emailOthers">{translate key="rt.admin.settings.emailOthers"}</label>
	</tr>
	<div class="form-group">
		<input type="checkbox" name="emailAuthor" id="emailAuthor" {if $emailAuthor}checked="checked" {/if}/>
		<label for="emailAuthor">{translate key="rt.admin.settings.emailAuthor"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="findingReferences" id="findingReferences" value="1"{if $findingReferences} checked="checked"{/if} />
		<label for="findingReferences">{translate key="rt.admin.settings.findingReferences"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="viewReviewPolicy" id="viewReviewPolicy" value="1"{if $viewReviewPolicy} checked="checked"{/if} />
		<label for="viewReviewPolicy">{translate key="rt.admin.settings.viewReviewPolicy"}</label>
	</div>
	<div class="form-group">
		<input type="checkbox" name="enableComments" id="enableComments" value="1"{if $enableComments} checked="checked"{/if} />
		<label for="enableComments">{translate key="rt.admin.settings.addComment"}</label>
	</div>
	<div class="form-subrow">
			<div class="form-group">
				<input type="radio" name="enableCommentsMode" id="enableCommentsMode-authenticated" value="{$commentsOptions.COMMENTS_AUTHENTICATED|escape}"{if $enableComments==$commentsOptions.COMMENTS_AUTHENTICATED} checked="checked"{/if} /><label for="enableCommentsMode-authenticated">{translate key="rt.admin.settings.addComment.authenticated"}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="enableCommentsMode" id="enableCommentsMode-anonymous" value="{$commentsOptions.COMMENTS_ANONYMOUS|escape}"{if $enableComments==$commentsOptions.COMMENTS_ANONYMOUS} checked="checked"{/if} />
				<label for="enableCommentsMode-anonymous">{translate key="rt.admin.settings.addComment.anonymous"}</label>
			</div>
			<div class="form-group">
				<input type="radio" name="enableCommentsMode" id="enableCommentsMode-unauthenticated" value="{$commentsOptions.COMMENTS_UNAUTHENTICATED|escape}"{if $enableComments==$commentsOptions.COMMENTS_UNAUTHENTICATED} checked="checked"{/if} /><label for="enableCommentsMode-unauthenticated">{translate key="rt.admin.settings.addComment.unauthenticated"}</label>
			</div>
	</div>
</div>
</div>


<div id="rtAdminRelatedItems">
<h3>{translate key="rt.admin.relatedItems"}</h3>

<div class="form-row">
	<label for="version">{translate key="rt.admin.settings.relatedItems"}</label>
	<select name="version" id="version" class="selectMenu">
	<option value="">{translate key="rt.admin.settings.disableRelatedItems"}</option>
	{html_options options=$versionOptions selected=$version}
	</select>
</div>

{url|assign:"relatedItemsLink" op="versions"}
<p class="delete-actions">{translate key="rt.admin.settings.relatedItemsLink" relatedItemsLink=$relatedItemsLink}</p>

</div>

<div class="buttons">
	<input type="submit" value="{translate key="common.save"}" class="button defaultButton" />
	<input type="button" value="{translate key="common.cancel"}" class="button" onclick="document.location.href='{url page="rtadmin" escape=false}'" />
</div>

</form>

{include file="common/footer.tpl"}

