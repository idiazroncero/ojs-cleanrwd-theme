{**
 * templates/author/submission/authorFees.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display of author fees and payment information
 *
 *}
<section class="section" id="authorFees">
<h3>{translate key="payment.authorFees"}</h3>
<dl>
	{if $currentJournal->getSetting('submissionFeeEnabled')}
		
			<dt>{$currentJournal->getLocalizedSetting('submissionFeeName')|escape}</dt>
		{if $submissionPayment}
			<dd>{translate key="payment.paid"} {$submissionPayment->getTimestamp()|date_format:$datetimeFormatLong}</dd>
		{else}
			<dd>{$currentJournal->getSetting('submissionFee')|string_format:"%.2f"} {$currentJournal->getSetting('currency')}
			<a class="button button--small" href="{url op="paySubmissionFee" path=$submission->getId()}">{translate key="payment.payNow"}</a></dd>
		{/if}
	{/if}
	{if $currentJournal->getSetting('fastTrackFeeEnabled')}
		
			<dt>{$currentJournal->getLocalizedSetting('fastTrackFeeName')|escape}:</dt> 
		{if $fastTrackPayment}
			<dd>{translate key="payment.paid"} {$fastTrackPayment->getTimestamp()|date_format:$datetimeFormatLong}</dd>
		{else}
			<dd>{$currentJournal->getSetting('fastTrackFee')|string_format:"%.2f"} {$currentJournal->getSetting('currency')}
			<a class="action" href="{url op="payFastTrackFee" path=$submission->getId()}">{translate key="payment.payNow"}</a></dd>
		{/if}
		
	{/if}
	{if $currentJournal->getSetting('publicationFeeEnabled')}
			<dt>{$currentJournal->getLocalizedSetting('publicationFeeName')|escape}</dt>
		{if $publicationPayment}
			<dd{translate key="payment.paid"} {$publicationPayment->getTimestamp()|date_format:$datetimeFormatLong}</dd>
		{else}
			<dd>{$currentJournal->getSetting('publicationFee')|string_format:"%.2f"} {$currentJournal->getSetting('currency')}
			<a class="action" href="{url op="payPublicationFee" path=$submission->getId()}">{translate key="payment.payNow"}</a></dd>
		{/if}	
	{/if}
</dl>
</section>
