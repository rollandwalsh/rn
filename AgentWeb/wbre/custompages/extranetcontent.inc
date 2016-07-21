<!-- #include virtual="modules/global/constants/siteoptions.inc" -->
<%
cMedia = application("mediapath")

set objRemoteAccess = server.CreateObject("RemoteAccessObject.UtilityFunctionCall")
arrSiteOption = objRemoteAccess.CallFunction("Reliance.Web.RemoteAccess.SiteOption.GetCompanySiteOptions", Array(clng(application("companyid")), Array(clng(soNARlogin))))
set objRemoteAccess = nothing

vsoHasPasswordLogin = cbool(arrSiteOption(0))
%>

<style type="text/css">
	.ExtranetDescrip-features li:first-child { list-style-image:url(<%=cMedia%>/global/search/icon_marker_single.gif); }
	.ExtranetDescrip-features li:first-child + li { list-style-image:url(<%=cMedia%>/global/search/icon_info_sm.gif); }
	.ExtranetDescrip-features li:first-child + li + li { list-style-image:url(<%=cMedia%>/global/search/icon_directions.gif); }
	.ExtranetDescrip-features li:first-child + li + li + li { list-style-image:url(<%=cMedia%>/global/search/icon_savedsearches.gif); }
	.ExtranetDescrip-features li:first-child + li + li + li + li { list-style-image:url(<%=cMedia%>/global/search/icon_addfavorite_sm.gif); }
	.ExtranetDescrip-password-retrievebutton { background-image:url(<%=cMedia%>/global/search/buttons/retrievepass_button.gif); }
</style>

<section id="ExtranetDescrip">
	<h3>Sign up for your FREE <%=application("extranettitle")%> account today!</h3>
	<ul class="ExtranetDescrip-features">
		<li>Access <strong>property addresses</strong> for all listings!</li>
		<li>Receive <strong>emails</strong> of newly listed properties.</li>
		<li>Access <strong>listing flyers</strong>, <strong>area maps</strong> and <strong>street maps</strong> when available.</li>
		<li><strong>Save Searches</strong> with detailed criteria to re-search at later dates.</li>
		<li><strong>Save your favorite properties</strong> to folders.</li>
	</ul>

	<%if vsoHasPasswordLogin and len(session("clientid")) = 0 then%>
		<aside class="ExtranetDescrip-password">
			<h3> Need Your Password?</h3>
			<p>If you do not know  your 
			<strong><%=application("extranettitle")%></strong> 
			password, simply click the button below 
			to have your password sent directly to the email address that you registered with.</p>

			<script language=javascript>
				function submitlostpasswordrequest() {
					var x
					var username = document.Members.username.value;
						x=window.open('/BrokerConnect/modules/search/lostpassword.asp?email=' + username,'lostpassword','width=313,height=245')
						x.focus();
					return true;
				}
			</script>
			<a class="ExtranetDescrip-password-retrievebutton" onclick="submitlostpasswordrequest()" title="Retrieve Your Password"></a>
		</aside>
	<%end if%>
</section>
