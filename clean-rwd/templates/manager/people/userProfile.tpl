{**
 * templates/manager/people/userProfile.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display user profile.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.people"}
{include file="common/header.tpl"}
{/strip}

<h3 id="userFullName">{$user->getFullName()|escape}</h3>
<div id="profile">
<h4>{translate key="user.profile"}</h4>

<p><a href="{url op="editUser" path=$user->getId()}" class="button button--small">{translate key="manager.people.editProfile"}</a></p>

<dl>
	<dt>{translate key="user.username"}</dt>
	<dd>{$user->getUsername()|escape}</dd>

	<dt>{translate key="user.salutation"}</dt>
	<dd>{$user->getSalutation()|escape|default:"&mdash;"}</dd>

	<dt>{translate key="user.firstName"}</dt>
		<dd>{$user->getFirstName()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.middleName"}</dt>
		<dd>{$user->getMiddleName()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.lastName"}</dt>
		<dd>{$user->getLastName()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.affiliation"}</dt>
		<dd>{$user->getLocalizedAffiliation()|escape|nl2br|default:"&mdash;"}</dd>

		<dt>{translate key="user.signature"}</dt>
		<dd>{$user->getLocalizedSignature()|escape|nl2br|default:"&mdash;"}</dd>

		<dt>{translate key="user.initials"}</dt>
		<dd>{$user->getInitials()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.gender"}</dt>
		<dd>
			{if $user->getGender() == "M"}{translate key="user.masculine"}
			{elseif $user->getGender() == "F"}{translate key="user.feminine"}
			{elseif $user->getGender() == "O"}{translate key="user.other"}
			{else}&mdash;
			{/if}
		</dd>

		<dt>{translate key="user.email"}</dt>
		<dd>
			{$user->getEmail()|escape}
			{assign var=emailString value=$user->getFullName()|concat:" <":$user->getEmail():">"}
			{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl}
			{icon name="mail" url=$url}
		</dd>

		<dt>{translate key="user.url"}</dt>
		<dd><a href="{$user->getUrl()|escape:"quotes"}">{$user->getUrl()|escape}</a></dd>

		<dt>{translate key="user.phone"}</dt>
		<dd>{$user->getPhone()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.fax"}</dt>
		<dd>{$user->getFax()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.interests"}</dt>
		<dd>{$userInterests|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.gossip"}</dt>
		<dd>{$user->getLocalizedGossip()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="common.mailingAddress"}</dt>
		<dd><div class="delete-margins">{$user->getMailingAddress()|strip_unsafe_html|nl2br|default:"&mdash;"}</div></dd>

		<dt>{translate key="common.country"}</dt>
		<dd>{$country|escape|default:"&mdash;"}</dd>

		<dt>{translate key="user.biography"}</dt>
		<dd><div class="delete-margins">{$user->getLocalizedBiography()|strip_unsafe_html|nl2br|default:"&mdash;"}</div></dd>

		<dt>{translate key="user.workingLanguages"}</dt>
		<dd>{foreach name=workingLanguages from=$user->getLocales() item=localeKey}{$localeNames.$localeKey|escape}{if !$smarty.foreach.workingLanguages.last}; {/if}{foreachelse}&mdash;{/foreach}</dd>

		<dt>{translate key="user.dateRegistered"}</dt>
		<dd>{$user->getDateRegistered()|date_format:$datetimeFormatLong}</dd>

		<dt>{translate key="user.dateLastLogin"}</dt>
		<dd>{$user->getDateLastLogin()|date_format:$datetimeFormatLong}</dd>
</dl>
</div>



<div id="enrollment>">
<h4>{translate key="manager.people.enrollment"}</h4>

{section name=role loop=$userRoles}
	{assign var=roleJournalId value=$userRoles[role]->getJournalId()}
	{if $isSiteAdmin && $lastJournalTitle != $journalTitles[$roleJournalId]}
		{if $notFirstRole}
			</ul>
		{/if}
		{assign var=lastJournalTitle value=$journalTitles[$roleJournalId]}
		<h3>{$lastJournalTitle}</h3>
		{if $notFirstRole}
			<ul>
		{/if}
	{/if}
	{if !$notFirstRole}
		<ul>
		{assign var=notFirstRole value=1}
	{/if}
	<li>
		{translate key=$userRoles[role]->getRoleName()}
		{if $userRoles[role]->getRoleId() != $smarty.const.ROLE_ID_SITE_ADMIN}&nbsp;
		<a href="{url op="unEnroll" path=$userRoles[role]->getRoleId() userId=$user->getId() journalId=$userRoles[role]->getJournalId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.people.confirmUnenroll"}')" class="action"><i class="fa fa-user-times"></i> {translate key="manager.people.unenroll"}</a>
		{/if}
	</li>
{/section}
{if $notFirstRole}
	</ul>
{/if}
</div>
{include file="common/footer.tpl"}

