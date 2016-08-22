{**
 * templates/submission/metadata/metadata.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission metadata table. Non-form implementation.
 *}
<section class="section" id="metadata">
<h3>{translate key="submission.metadata"}</h3>

{if $canEditMetadata}
	<p><a href="{url op="viewMetadata" path=$submission->getId()}" class="button button--small">{translate key="submission.editMetadata"}</a></p>
	{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalEditItems"}
{/if}

<section  class="section" id="authors">
<h4>{translate key="article.authors"}</h4>
	
<dl>
	{foreach name=authors from=$submission->getAuthors() item=author}
		<dt>{translate key="user.name"}</dt>
		<dd>
			{assign var=emailString value=$author->getFullName()|concat:" <":$author->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
			{$author->getFullName()|escape} {icon name="mail" url=$url}
		</dd>
	{if $author->getData('orcid')}
		<dt>{translate key="user.orcid"}</dt>
		<dd><a href="{$author->getData('orcid')|escape}" target="_blank">{$author->getData('orcid')|escape}</a></dd>
	{/if}
	{if $author->getUrl()}
		<dt>{translate key="user.url"}</dt>
		<dd><a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a></dd>
	{/if}
	<dt>{translate key="user.affiliation"}</dt>
	<dd>{$author->getLocalizedAffiliation()|escape|nl2br|default:"&mdash;"}</dd>
	
	<dt>{translate key="common.country"}</dt>
	<dd>{$author->getCountryLocalized()|escape|default:"&mdash;"}</dd>

	{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
			<dt>
				{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
				{translate key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}
			</dt>
			<dd>{$author->getLocalizedCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</dd>
	{/if}

		<dt>{translate key="user.biography"}</dt>
		<dd>{$author->getLocalizedBiography()|strip_unsafe_html|nl2br|default:"&mdash;"}
			{if $author->getPrimaryContact()}
				<p>{translate key="author.submit.selectPrincipalContact"}</p>
			{/if}
		</dd>
	</tr>

	{/foreach}
</dl>
</section>

<section class="section" id="titleAndAbstract">
<h4>{translate key="submission.titleAndAbstract"}</h4>

<dl>
	<dt>{translate key="article.title"}</dt>
	<dd>{$submission->getLocalizedTitle()|strip_unsafe_html|default:"&mdash;"}</dd>

	<dt>{translate key="article.abstract"}</dt>
	<dd>{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br|default:"&mdash;"}</dd>
</dl>

</section>

<section class="section" id="indexing">
<h4>{translate key="submission.indexing"}</h4>
	
<dl>
	{if $currentJournal->getSetting('metaDiscipline')}
		<dt>{translate key="article.discipline"}</dt>
		<dd>{$submission->getLocalizedDiscipline()|escape|default:"&mdash;"}</dd>

	{/if}
	{if $currentJournal->getSetting('metaSubjectClass')}
			<dt>{translate key="article.subjectClassification"}</dt>
			<dd>{$submission->getLocalizedSubjectClass()|escape|default:"&mdash;"}</dd>
	{/if}
	{if $currentJournal->getSetting('metaSubject')}
		<dt>{translate key="article.subject"}</dt>
		<dd>{$submission->getLocalizedSubject()|escape|default:"&mdash;"}</dd>
	{/if}
	{if $currentJournal->getSetting('metaCoverage')}
		<dt>{translate key="article.coverageGeo"}</dt>
		<dd>{$submission->getLocalizedCoverageGeo()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="article.coverageChron"}</dt>
		<dd>{$submission->getLocalizedCoverageChron()|escape|default:"&mdash;"}</dd>

		<dt>{translate key="article.coverageSample"}</dt>
		<dd>{$submission->getLocalizedCoverageSample()|escape|default:"&mdash;"}</dd>

	{/if}
	{if $currentJournal->getSetting('metaType')}
		<dt>{translate key="article.type"}</dt>
		<dd>{$submission->getLocalizedType()|escape|default:"&mdash;"}</dd>
	{/if}

		<dt>{translate key="article.language"}</dt>
		<dd>{$submission->getLanguage()|escape|default:"&mdash;"}</dd>

</dl>

</section>

<section class="section" id="supportingAgencies">
<h4>{translate key="submission.supportingAgencies"}</h4>
	

	<dt>{translate key="submission.agencies"}</dt>
	<dd>{$submission->getLocalizedSponsor()|escape|default:"&mdash;"}</dd>

</section>

{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalMetadata"}

{if $currentJournal->getSetting('metaCitations')}
	<section  id="citations">
	<h4>{translate key="submission.citations"}</h4>

	<dl>

			<dt>{translate key="submission.citations"}</dt>
			<dd>{$submission->getCitations()|strip_unsafe_html|nl2br|default:"&mdash;"}</dd>
	</dl>
	</section>
{/if}

</section><!-- metadata -->

