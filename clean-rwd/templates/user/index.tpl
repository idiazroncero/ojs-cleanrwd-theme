{**
 * templates/user/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User index.
 *
 *}
{strip}
{assign var="pageTitle" value="user.userHome"}
{include file="common/header.tpl"}
{/strip}

{if $isSiteAdmin}
	{assign var="hasRole" value=1}
	<div class="form-row">
		<a class="button" href="{url journal="index" page=$isSiteAdmin->getRolePath()}">{translate key=$isSiteAdmin->getRoleName()}</a>
	</div>
	{call_hook name="Templates::User::Index::Site"}
{/if}

<section class="section" id="myJournals">
{if !$currentJournal}<h3>{translate key="user.myJournals"}</h3>{/if}

{foreach from=$userJournals item=journal}
	<section id="journal-{$journal->getPath()|escape}" class="journal-admin">
	{assign var="hasRole" value=1}
	{if !$currentJournal}<h4><a href="{url journal=$journal->getPath() page="user"}">{$journal->getLocalizedTitle()|escape}</a></h4>
	{else}<h3>{$journal->getLocalizedTitle()|escape}</h3>{/if}
	{assign var="journalId" value=$journal->getId()}
	{assign var="journalPath" value=$journal->getPath()}
		{if $isValid.JournalManager.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="manager"}">{translate key="user.role.manager"}</a>
				</div>
				<div class="journal-admin__actions">
					{if $setupIncomplete.$journalId}<a href="{url journal=$journalPath page="manager" op="setup" path="1"}" class="button button--small">{translate key="manager.setup"}</a>{/if}
				</div>
			</div>
		{/if}
		{if $isValid.SubscriptionManager.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="subscriptionManager"}">{translate key="user.role.subscriptionManager"}</a>
				</div>
			</div>
		{/if}
		{if $isValid.Editor.$journalId}
			<div class="journal-admin__role">
				{assign var="editorSubmissionsCount" value=$submissionsCount.Editor.$journalId}
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="editor"}">{translate key="user.role.editor"}</a>
				</div>
				<div class="journal-admin__count">
					{if $editorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsUnassigned"}">{$editorSubmissionsCount[0]} {translate key="common.queue.short.submissionsUnassigned"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsUnassigned"}</span>{/if}
				</div>
				<div class="journal-admin__count">
					{if $editorSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsInReview"}">{$editorSubmissionsCount[1]} {translate key="common.queue.short.submissionsInReview"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInReview"}</span>{/if}
				</div>
				<div class="journal-admin__count">
					{if $editorSubmissionsCount[2]}
						<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsInEditing"}">{$editorSubmissionsCount[2]} {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</div>
				<div class="journal-admin__actions">
					<a class="button button--small" href="{url journal=$journalPath page="editor" op="createIssue"}">{translate key="editor.issues.createIssue"}</a>
					<a class="button button--small" href="{url journal=$journalPath page="editor" op="notifyUsers"}">{translate key="editor.notifyUsers"}</a>
				</div>
			</div>
		{/if}
		{if $isValid.SectionEditor.$journalId}
			{assign var="sectionEditorSubmissionsCount" value=$submissionsCount.SectionEditor.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="sectionEditor"}">{translate key="user.role.sectionEditor"}</a>
				</div>
				<div class="journal-admin__count">
					{if $sectionEditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsInReview"}">{$sectionEditorSubmissionsCount[0]} {translate key="common.queue.short.submissionsInReview"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInReview"}</span>{/if}
				</div>
				<div class="journal-admin__count">
					{if $sectionEditorSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsInEditing"}">{$sectionEditorSubmissionsCount[1]} {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</div>
			</div>
		{/if}
		{if $isValid.LayoutEditor.$journalId}
			{assign var="layoutEditorSubmissionsCount" value=$submissionsCount.LayoutEditor.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="layoutEditor"}">{translate key="user.role.layoutEditor"}</a>
				</div>
				<div class="journal-admin__actions">
					{if $layoutEditorSubmissionsCount[0]}
						<a class="button button--small" href="{url journal=$journalPath page="layoutEditor" op="submissions"}">{$layoutEditorSubmissionsCount[0]} {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</div>
			</div>
		{/if}
		{if $isValid.Copyeditor.$journalId}
			{assign var="copyeditorSubmissionsCount" value=$submissionsCount.Copyeditor.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="copyeditor"}">{translate key="user.role.copyeditor"}</a>
				</div>
				<div class="journal-admin__actions">
					{if $copyeditorSubmissionsCount[0]}
						<a class="button button--small" href="{url journal=$journalPath page="copyeditor"}">{$copyeditorSubmissionsCount[0]} {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</div>
			</div>
		{/if}
		{if $isValid.Proofreader.$journalId}
			{assign var="proofreaderSubmissionsCount" value=$submissionsCount.Proofreader.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="proofreader"}">{translate key="user.role.proofreader"}</a>
				</div>
				<div class="journal-admin__actions">
					{if $proofreaderSubmissionsCount[0]}
						<a class="button button--small" href="{url journal=$journalPath page="proofreader"}">{$proofreaderSubmissionsCount[0]} {translate key="common.queue.short.submissionsInEditing"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.submissionsInEditing"}</span>{/if}
				</div>
			</div>
		{/if}
		{if $isValid.Author.$journalId}
			{assign var="authorSubmissionsCount" value=$submissionsCount.Author.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="author"}">{translate key="user.role.author"}</a>
				</div>
				<div class="journal-admin__count">
					{if $authorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="author"}">{$authorSubmissionsCount[0]} {translate key="common.queue.short.active"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.active"}</span>{/if}
				</div>
				{* This is for all non-pending items*}
				<div class="journal-admin__count">
					{if $authorSubmissionsCount[1]}
						<a href="{url journal=$journalPath path="completed" page="author"}">{$authorSubmissionsCount[1]} {translate key="common.queue.short.completed"}</a>
					{else}<span class="disabled">0 {translate key="common.queue.short.completed"}</span>{/if}
				</div>
				<div class="journal-admin__actions">
					<a class="button button--small" href="{url journal=$journalPath page="author" op="submit"}">{translate key="author.submit"}</a>
				</div>
			</div>
		{/if}
		{if $isValid.Reviewer.$journalId}
			{assign var="reviewerSubmissionsCount" value=$submissionsCount.Reviewer.$journalId}
			<div class="journal-admin__role">
				<div class="journal-admin__title">
					<a href="{url journal=$journalPath page="reviewer"}">{translate key="user.role.reviewer"}</a>
				</div>
				<div class="journal-admin__count">
					{if $reviewerSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="reviewer"}">{$reviewerSubmissionsCount[0]} {translate key="common.queue.short.active"}</a>
					{else}<span class=" disabled">0 {translate key="common.queue.short.active"}</span>{/if}
				</div>
			</div>
		{/if}
	{call_hook name="Templates::User::Index::Journal" journal=$journal}
	</section>
{/foreach}
</section>

{if !$hasRole}
	{if $currentJournal}
		<section class="section" id="noRolesForJournal">
		<p>{translate key="user.noRoles.noRolesForJournal"}</p>
		<ul>
			<li>
				{if $allowRegAuthor}
					{url|assign:"submitUrl" page="author" op="submit"}
					<a href="{url op="become" path="author" source=$submitUrl}">{translate key="user.noRoles.submitArticle"}</a>
				{else}{* $allowRegAuthor *}
					{translate key="user.noRoles.submitArticleRegClosed"}
				{/if}{* $allowRegAuthor *}
			</li>
			<li>
				{if $allowRegReviewer}
					{url|assign:"userHomeUrl" page="user" op="index"}
					<a href="{url op="become" path="reviewer" source=$userHomeUrl}">{translate key="user.noRoles.regReviewer"}</a>
				{else}{* $allowRegReviewer *}
					{translate key="user.noRoles.regReviewerClosed"}
				{/if}{* $allowRegReviewer *}
			</li>
		</ul>
		</div>
	{else}{* $currentJournal *}
		<div id="currentJournal">
		<p>{translate key="user.noRoles.chooseJournal"}</p>
		<ul>
			{foreach from=$allJournals item=thisJournal}
				<li><a href="{url journal=$thisJournal->getPath() page="user" op="index"}">{$thisJournal->getLocalizedTitle()|escape}</a></li>
			{/foreach}
		</ul>
		</section>
	{/if}{* $currentJournal *}
{/if}{* !$hasRole *}

<div section="section" id="myAccount">
<h3>{translate key="user.myAccount"}</h3>
<ul>
	{if $hasOtherJournals}
		{if !$showAllJournals}
			<li><a href="{url journal="index" page="user"}">{translate key="user.showAllJournals"}</a></li>
		{/if}
	{/if}
	{if $currentJournal}
		{if $subscriptionsEnabled}
			<li><a href="{url page="user" op="subscriptions"}">{translate key="user.manageMySubscriptions"}</a></li>
		{/if}
	{/if}
	{if $currentJournal}
		{if $acceptGiftPayments}
			<li><a href="{url page="user" op="gifts"}">{translate key="gifts.manageMyGifts"}</a></li>
		{/if}
	{/if}
	<li><a href="{url page="user" op="profile"}">{translate key="user.editMyProfile"}</a></li>

	{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
		<li><a href="{url page="user" op="changePassword"}">{translate key="user.changeMyPassword"}</a></li>
	{/if}

	{if $currentJournal}
		{if $journalPaymentsEnabled && $membershipEnabled}
			{if $dateEndMembership}
				<li><a href="{url page="user" op="payMembership"}">{translate key="payment.membership.renewMembership"}</a> ({translate key="payment.membership.ends"}: {$dateEndMembership|date_format:$dateFormatShort})</li>
			{else}
				<li><a href="{url page="user" op="payMembership"}">{translate key="payment.membership.buyMembership"}</a></li>
			{/if}
		{/if}{* $journalPaymentsEnabled && $membershipEnabled *}
	{/if}{* $userJournal *}

	<li><a href="{url page="login" op="signOut"}">{translate key="user.logOut"}</a></li>
	{call_hook name="Templates::User::Index::MyAccount"}
</ul>
</div>

{include file="common/footer.tpl"}

