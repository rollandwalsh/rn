<!doctype html>
<html class="no-js" lang="en">
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	    <meta http-equiv="x-ua-compatible" content="ie=edge">
<%
set objSiteId = server.CreateObject("remoteaccessobject.clsweb")
strReturn = objSiteId.SiteAccountIdOrRedirect(request.ServerVariables("http_host"), request.ServerVariables("url"), request.QueryString, application("companyid"))
set objSiteId = nothing

if not isnumeric(strReturn) then
	response.Clear()
	response.Status = "301 Moved Permanently"
	response.AddHeader "Location", strReturn
	response.End
end if

if request.ServerVariables("script_name") <> "index.asp" then%>
<%end if%>
<!-- #include virtual="modules/global/constants/siteoptions.inc" -->
<!-- #include virtual="modules/global/clientcookie-inc.asp" -->
<!-- #include virtual="modules/global/displayListingCount.asp" -->
<!-- #include virtual="modules/global/inc_CompanyHeaderFunctions.asp" -->
<!-- #include virtual="/modules/global/adtracking.inc.asp" -->
<%
strHeadAdTrackingCode = AdTracking("companyHeader")	
session("accountid") = empty
cMedia = Application("mediapath")
cSiteDir = Application("sitedirectory")
cStatic = "/static"
'cStatic = "http://content.mediastg.net/static"

dim connHeader
dim strMiscMetaTags

set connHeader = server.CreateObject("adodb.connection")
with connHeader
	.ConnectionString = Application("brokerdata_connectionstring")
	.CursorLocation = 3
	.Open
end with

if len(request.cookies("Remax_Agent")("AccountID")) > 0 then
	response.cookies("Remax_Agent")("AccountID") = ""
end if
if len(Request.Cookies("webAccountID")) > 0 then
	Response.Cookies("webAccountID") = ""
end if
call buildCorporateMetaTags()

if instr(lcase(request.servervariables("HTTP_User_Agent")), "msie") > 0 and instr(lcase(request.servervariables("HTTP_User_Agent")), "windows") > 0 then
	vIEWin = true
elseif instr(lcase(request.servervariables("HTTP_User_Agent")), "mac") then
	vMac = true
elseif instr(lcase(request.servervariables("HTTP_User_Agent")), "firefox") then
	vFirefox = true
end if


' * Set the domain Entry Code
if len(request.QueryString("s")) > 0 then
	strDomainEntryCode = "/" & request.QueryString("s")
	response.Cookies("domainentrycode") = strDomainEntryCode
else
    strDomainEntryCode = request.Cookies("domainentrycode")
end if

if isHomePage then
	strGoogleMeta = "<meta name=""google-site-verification"" content="" "" />"
    strBingMeta = "<meta name=""msvalidate.01"" content="" "" />"
    strOtherMeta = "<meta name=""p:domain_verify"" content="" "" />"
else
	strGoogleMeta = ""
    strBingMeta = ""
    strOtherMeta = ""
end if


if Len(strTitle) > 0 then
	strPageTitle = Server.HTMLEncode(strTitle)
else
	strPageTitle = "Lincoln and Nebraska Real Estate, Homes for Sale &vert; Woods Bros Realty"
end if

if Len(strDescr) > 0 then
	strMetaDescription = "<META NAME=""Description"" CONTENT=""" & server.HTMLEncode(strDescr) & """ />" & vbcrlf
else
	strMetaDescription = "<meta name=""description"" content=""Search homes for sale in Lincoln and SE Nebraska. Find a real estate agent, get advice, home values, and neighborhood info from Woods Bros Realty."" />" & vbcrlf
end if

if Len(strKeywords) > 0 then
    strMetaKeywords = "<META NAME=""Keywords"" CONTENT=""" & server.HTMLEncode(strKeywords) & """ />" & vbcrlf
else
	strMetaKeywords = "<meta name=""keywords"" content=""lincoln nebraska homes for sale, real estate lincoln ne, houses for sale in lincoln ne, lincoln ne homes, homes lincoln nebraska, lincoln ne realtors"" />" & vbcrlf
end if


%>
	    <title><%=strPageTitle%></title>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="MobileOptimized" content="width">
	    <meta name="HandheldFriendly" content="true">
	    <meta name="apple-mobile-web-app-capable" content="no">

		<link rel="apple-touch-icon" sizes="57x57" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-57x57.png">
		<link rel="apple-touch-icon" sizes="60x60" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-60x60.png">
		<link rel="apple-touch-icon" sizes="72x72" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-72x72.png">
		<link rel="apple-touch-icon" sizes="76x76" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-76x76.png">
		<link rel="apple-touch-icon" sizes="114x114" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-114x114.png">
		<link rel="apple-touch-icon" sizes="120x120" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-120x120.png">
		<link rel="apple-touch-icon" sizes="144x144" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-144x144.png">
		<link rel="apple-touch-icon" sizes="152x152" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-152x152.png">
		<link rel="apple-touch-icon" sizes="180x180" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/apple-icon-180x180.png">
		<link rel="icon" type="image/png" sizes="192x192"  href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/android-icon-192x192.png">
		<link rel="icon" type="image/png" sizes="32x32" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="96x96" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/favicon-96x96.png">
		<link rel="icon" type="image/png" sizes="16x16" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/favicon-16x16.png">
		<link rel="manifest" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/manifest.json">
		<meta name="msapplication-TileColor" content="#ffffff">
		<meta name="msapplication-TileImage" content="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/icons/ms-icon-144x144.png">
		<meta name="theme-color" content="#ffffff">

	    <meta http-equiv="cleartype" content="on">
	    <meta http-equiv="Content-Language" content="EN">
	    <%=strMetaKeywords%>
	    <%=strMetaDescription%>
	    <%=strGoogleMeta%>
	    <%=strBingMeta%>
	    <%=strOtherMeta%>
	    <%=strMiscMetaTags%>
	    <meta name="MSSmartTagsPreventParsing" content="TRUE">
	    <meta name="rating" content="General">
	    <meta name="MS.LOCALE" content="EN-US">
	    <meta name="robots" content="index,follow">
	    <meta name="URL" content="http://<%=request.ServerVariables("http_host")%>">
	    <meta name="revisit-after" content="31 days">
	    <meta name="DC.Coverage.PlaceName" content="Global">
	    <meta name="author" content="<%=application("CompanyName")%>">
	    <meta name="distribution" content="Global">
	    <% if  isHomePage then %>
			<meta property="og:title" content="<%=application("CompanyName")%>">
			<meta property="og:url" content="http://<%=request.ServerVariables("http_host")%>">
			<meta property="og:description" content="Search all homes for sale in Lincoln and most of Nebraska at Woods Bros Realty.  Backed by 125 years of experience, we&#39;re here to serve you." />
		<% end if %>

		<% if Instr(Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("URL"), "sitemap") > 1  then
			PageOn = "rn-interior-page"
			elseif request.QueryString("p")="custompageseo.asp" or request.QueryString("p")="featuredproperties.asp" then
			PageOn = "rn-interior-page"
			elseif request.QueryString("p")="findagentoffice.asp" or request.QueryString("p")="findoffice.asp" or request.QueryString("p")="findagent.asp" or request.QueryString("p")="agentResults.asp"  or request.QueryString("p")="agentresults.asp"then
			PageOn = "rn-agent-office-page"
			elseif request.QueryString("p")="newconstruction.asp" or request.QueryString("p")="subdivisionmain.asp" or request.QueryString("p")="builderDetails.asp" then
			PageOn = "rn-new-construction-page"
			elseif isHomePage then
			PageOn = "rn-home-page"
			elseif request.QueryString("p")="findahome.asp" and request.QueryString("page")="extranet" then
			PageOn = "rn-extranet-page"
			elseif request.QueryString("p")="findahome.asp" then
			PageOn = "rn-search-page"
			else
			PageOn = "rn-interior-page"
			end if
		%>

	<!-- Styles -->
		<% if PageOn = "rn-search-page" then %>
			<link rel="stylesheet" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/css/search.css">
		<% else %>
			<link rel="stylesheet" href="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/css/app.css">
		<% end if %>

		<% if PageOn = "rn-home-page" then %>
			<link rel="stylesheet" href="http://cdn.jsdelivr.net/jquery.slick/1.5.9/slick.css">
            <link rel="stylesheet" href="http://<%=request.ServerVariables("http_host")%>/hmre/css/addtohomescreen.css">

            <script src="http://<%=request.ServerVariables("http_host")%>/hmre/js/addtohomescreen.js"></script>

            <script>
                addToHomescreen();
            </script>
		<% end if %>

	<!-- Scripts -->
		<script>
			var ShowClientInfo = '<%=request.Cookies("sessionclientid") %>';
			var mediaPath = '<%=cStatic%>/RealEstate/Company/<%=Application("CompanyID")%>/';
			var PageType = '<%=PageOn %>';
			var PageIsOn = '<%=Request.ServerVariables("QUERY_STRING")%>';
		</script>
		<script src="/scripts/reliance.jsx?id=<%=application("companyid")%>"></script>
		<script>
			function clearText(a) {
				if (a.value == "<Email Address>") {a.value = ""; a.style.color = "#000000"}
			}

			function checkValidlogin() {
				if (!validEmail(document.getElementById("username").value)) {
					alert("Invalid E-mail Address.");
					document.getElementById("username").focus();
					return false
				}
				return true
			}

			function validEmail(a) {
				invalidChars = "/:,;";
				atPos = a.indexOf("@", 1);
				periodPos = a.indexOf(".", atPos);

				for (i = 0; i < invalidChars.length; i++) {
					badChar = invalidChars.charAt(i);
					if (a.indexOf(badChar, 0) > -1) { return false }
				}

				if (atPos == -1) { return false }
				if (a.indexOf("@", atPos + 1) > -1) { return false }
				if (periodPos == -1) { return false }
				if (periodPos + 3 > a.length) { return false }
				return true
			};
		</script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

       	<%=strHeadAdTrackingCode%>

	</head>

	<body class="<%=PageOn%>" role="document">

	<% if len(request.QueryString("token")) > 0 then %>
	    <!--iframe token is present-->
	<%else%>
		<header class="rn-site-header">
			<div class="rn-container">
				<div class="rn-site-header-logo">
					<a href="/" title="Click here for our Home Page"><img src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/logo.png" alt="Home Real Estate Logo"></a>
				</div>

				<!-- #include virtual="wbre/custompages/property-watch.inc"-->

				<nav class="rn-site-header-nav" role="navigation">
					<% Response.Write ( PagesToUse.Item(13395) ) %>

					<a href="#" class="rn-site-header-nav-button rn-site-navigation-toggle" id="rnSiteHeaderNavButton"><span class="rn-site-header-nav-burger"></span><span class="text">Menu</span></a>
<% if len(request.Cookies("sessionclientid")) > 0 then %>
	<a href="/?p=findahome.asp&page=extranet&selected=dashboard" class="rn-site-header-nav-button rn-search-user-toggle"><i class="rn-icon-user-solid"></i></a>
<% else %>
	<a href="/?p=findahome.asp&page=extranet&selected=dashboard" class="rn-site-header-nav-button rn-search-user-toggle"><i class="rn-icon-user"></i></a>
<% end if %>
					<a href="#" class="rn-site-header-nav-button rn-search-criteria-toggle" id="rnSearchCriteriaButton"><i class="rn-icon-search"></i></a>
				</nav>
			</div>
		</header>
	<%end if%>
	
		<% if PageOn = "rn-home-page" then %>
			<div class="rn-site-home">
		<% elseif PageOn ="rn-agent-office-page" then %>
			<div class="rn-site-agent-office">
		<% elseif PageOn ="rn-search-page" then %>
			<div class="rn-site-search">
		<% elseif PageOn ="rn-new-construction-page" then %>
			<div class="rn-site-new-construction">
				<div class="rn-container">
		<% else %>
			<div class="rn-site-interior">
				<div class="rn-container">
		<% end if %>