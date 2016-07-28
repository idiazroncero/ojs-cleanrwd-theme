{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
{strip}
{if $pageFooter==''}
	{if $currentJournal && $currentJournal->getSetting('onlineIssn')}
		{assign var=issn value=$currentJournal->getSetting('onlineIssn')}
	{elseif $currentJournal && $currentJournal->getSetting('printIssn')}
		{assign var=issn value=$currentJournal->getSetting('printIssn')}
	{/if}
	{if $issn}
		{translate|assign:"issnText" key="journal.issn"}
		{assign var=pageFooter value="$issnText: $issn"}
	{/if}
{/if}
{/strip}


{if $displayCreativeCommons}
	{translate key="common.ccLicense"}
{/if}
{call_hook name="Templates::Common::Footer::PageFooter"}

				{if $pageFooter}
					<footer id="main-footer">{$pageFooter}</footer>
				{/if}
			</section><!-- #content section -->
		</main><!-- main -->
		{if $rightSidebarCode}
			<aside id="rightSidebar">
				{$rightSidebarCode}
			</aside>
		{/if}
	</div><!-- #main-wrapper -->

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</body>
</html>
