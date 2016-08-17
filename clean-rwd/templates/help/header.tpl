{**
 * templates/help/header.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common header for help pages.
 *}
{strip}
{translate|assign:applicationHelpTranslated key="help.ojsHelp"}

{**
 * templates/help/header.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common header for help pages.
 *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{$applicationHelpTranslated}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	<!-- Clean-RWD Theme Stylesheet -->
		<link rel="stylesheet" href="{$baseUrl}/plugins/themes/clean-rwd/clean-rwd.css" type="text/css" />

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<!-- Base Jquery -->
	{if $allowCDN}<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script type="text/javascript">{literal}
		<!--
		// Provide a local fallback if the CDN cannot be reached
		if (typeof google == 'undefined') {
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/jquery.min.js' type='text/javascript'%3E%3C/script%3E"));
			document.write(unescape("%3Cscript src='{/literal}{$baseUrl}{literal}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js' type='text/javascript'%3E%3C/script%3E"));
		} else {
			google.load("jquery", "{/literal}{$smarty.const.CDN_JQUERY_VERSION}{literal}");
			google.load("jqueryui", "{/literal}{$smarty.const.CDN_JQUERY_UI_VERSION}{literal}");
		}
		// -->
	{/literal}</script>
	{else}
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	{/if}

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	{$additionalHeadData}
</head>
<body id="pkp-{$pageTitle|replace:'.':'-'}" class="rightsidebar">
{literal}
<script type="text/javascript">
<!--
    if (self.blur) { self.focus(); }
// -->
</script>
{/literal}

{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}

<div id="main-wrapper">

	<header>
		<div id="header-title">
		<h1>
			{$applicationHelpTranslated}
		</h1>
	</div>
	</header>

	<div id="nav">
					<nav class="breadcrumbs">
						<div id="breadcrumb">
							{if $topic->getId() == "index/topic/000000"}
								<a href="{get_help_id key="index.index" url="true"}" class="current">{translate key="navigation.home"}</a>
							{else}
								<a href="{get_help_id key="index.index" url="true"}">{translate key="navigation.home"}</a>
								{foreach name=breadcrumbs from=$breadcrumbs item=breadcrumb key=key}
									{if $breadcrumb != $topic->getId()}
									 &gt; <a href="{url op="view" path=$breadcrumb|explode:"/"}">{$key|escape}</a>
									{/if}
								{/foreach}
								&gt; <a href="{url op="view" path=$topic->getId()|explode:"/"}" class="current">{$topic->getTitle()}</a>
							{/if}
						</div>

					</nav>
				</div>

<div class="sidebars-wrapper">
	<main id="main">
		<section id="content">


{/strip}
