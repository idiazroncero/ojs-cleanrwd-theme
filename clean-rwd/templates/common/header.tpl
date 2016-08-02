	{strip}
	{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
	{if $pageCrumbTitle}
		{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
	{elseif !$pageCrumbTitleTranslated}
		{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
	{/if}
	{/strip}

	<!DOCTYPE html>
	<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
		<title>{$pageTitleTranslated}</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
		<meta name="description" content="{$metaSearchDescription|escape}" />
		<meta name="keywords" content="{$metaSearchKeywords|escape}" />
		<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
		{$metaCustomHeaders}
		{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}
		<!-- Clean-RWD Theme Stylesheet -->
		<link rel="stylesheet" href="{$baseUrl}/plugins/themes/clean-rwd/clean-rwd.css" type="text/css" />

		<!-- Base Jquery -->
		{if $allowCDN}<script type="text/javascript" src="//www.google.com/jsapi"></script>
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

		{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
		{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}

		{foreach from=$stylesheets item=cssUrl}
			<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
		{/foreach}

		<!-- Default global locale keys for JavaScript -->
		{include file="common/jsLocaleKeys.tpl" }

		<!-- Compiled scripts -->
		{if $useMinifiedJavaScript}
			<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
		{else}
			{include file="common/minifiedScripts.tpl"}
		{/if}

		<!-- Form validation -->
		<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/validate/jquery.validate.js"></script>
		<script type="text/javascript">
			<!--
			// initialise plugins
			{literal}
			$(function(){
				jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
				{/literal}{if $validateId}{literal}
					$("form[name={/literal}{$validateId}{literal}]").validate({
						errorClass: "error",
						highlight: function(element, errorClass) {
							$(element).parent().parent().addClass(errorClass);
						},
						unhighlight: function(element, errorClass) {
							$(element).parent().parent().removeClass(errorClass);
						}
					});
				{/literal}{/if}{literal}
				$(".tagit").live('click', function() {
					$(this).find('input').focus();
				});
			});
			// -->
			{/literal}
		</script>

		{if $hasSystemNotifications}
			{url|assign:fetchNotificationUrl page='notification' op='fetchNotification' escape=false}
			<script type="text/javascript">
				$(function(){ldelim}
					$.get('{$fetchNotificationUrl}', null,
						function(data){ldelim}
							var notifications = data.content;
							var i, l;
							if (notifications && notifications.general) {ldelim}
								$.each(notifications.general, function(notificationLevel, notificationList) {ldelim}
									$.each(notificationList, function(notificationId, notification) {ldelim}
										$.pnotify(notification);
									{rdelim});
								{rdelim});
							{rdelim}
					{rdelim}, 'json');
				{rdelim});
			</script>
		{/if}{* hasSystemNotifications *}

		{$additionalHeadData}
	</head>
	<body id="page-{$pageTitle|replace:'.':'-'}" class="{if $leftSidebarCode}leftsidebar{/if}{if $rightSidebarCode}rightsidebar{/if}
	">
		<div id="main-wrapper">
			<header id="header">
				<div id="header-title">
					<h1>
						{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
							<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
						{/if}
						{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
							<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
						{elseif $displayPageHeaderTitle}
							{$displayPageHeaderTitle}
						{elseif $alternatePageHeader}
							{$alternatePageHeader}
						{elseif $siteTitle}
							{$siteTitle}
						{else}
							{$applicationName}
						{/if}
					</h1>
				</div><!-- header-title -->
			</header>
			<div id="nav">
				<nav class="main-menu">
					{include file="common/navbar.tpl"}
				</nav>
				<nav class="breadcrumbs">
					{include file="common/breadcrumbs.tpl"}
				</nav>
			</div>
			{if $leftSidebarCode}
				<aside id="left-sidebar">
					{$leftSidebarCode}
				</aside>
			{/if}
			<main id="main">
				<section id="content">

					<h2>{$pageTitleTranslated}</h2>

					{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
					{if $pageSubtitleTranslated}
						<h3>{$pageSubtitleTranslated}</h3>
					{/if}
<!-- 
{/strip} -->
