<%
Dim cMediaLocal
dim connDBextranetClientNav
dim dctExtranetClientInfo
dim strExecutePage, blnShowClientInfo
dim strLoginMsg, vsoHomeValuationReport
intTrackedNeighborhoodsCount = 0
intHomeValuesCount = 0
blnUseOverlays = false

cSiteDirectory = application("sitedirectory")

cMediaLocal = application("mediapath")
strExecutePage = request.queryString("p")
blnShowClientInfo = false

Sub openDBConnBrokerdata
	set connDBextranetClientNav = Server.CreateObject("ADODB.Connection")
	with connDBextranetClientNav
		.ConnectionString = application("brokerdata_connectionstring")
		.CursorLocation = 3
		.Open
	end with
End Sub

Sub closeDBconnBrokerdata
	connDBextranetClientNav.Close
	Set connDBextranetClientNav = Nothing
End Sub

Sub populateComapnySiteOption
    Set objSiteOption = Server.CreateObject("apps" & Application("appsdllversion") & ".clssiteoption")
	objSiteOption.ConnectionString = application("brokerdata_connectionstring")

	' Get company siteoptions
	strSiteOptions = soHomeValuationReport
	arrReturnOptions = objSiteOption.getSiteOptions(strSiteOptions, application("CompanyID"), 1)
	vsoHomeValuationReport = arrReturnOptions(0)

	Set objSiteOption = Nothing
End Sub

intNavClientID = clng("0" & session("clientid")) or clng("0" & request.cookies("clientid")) or clng("0" & request.cookies("sessionclientid"))

if intNavClientID > 0 then

	blnShowClientInfo = true

	Call openDBConnBrokerdata
	Call populateComapnySiteOption

	set dctExtranetClientInfo = server.createObject("scripting.dictionary")
	set dctExtranetClientInfo = populateExtranetClientInfo(intNavClientID)
	intClientMsgCount = getNumClientMessages()
	intFavoritesCount = getNumFavorites()
	if vsoHomeValuationReport then
		intHomeValuesCount = getNumHomeValuesReports()
	end if
	intSavedSearchesCount = getNumSavedSearches("search")
	intTrackedNeighborhoodsCount = getNumSavedSearches("neighborhood")

	if intClientMsgCount > 0 then
		if intClientMsgCount > 1 then
			strLoginMsg = "You have " & intClientMsgCount & " new messages on " & application("ExtranetTitle") & "<a class=""button"" href=""/" & application("sitedirectory") & "/index.asp?" & getTargetScript() & "&acc=" & session("accountid") & "&page=extranet&selected=dashboard"">Dashboard</a>"
		else
			strLoginMsg = "You have 1 new message on " & application("ExtranetTitle") & "<a class=""button"" href=""/" & application("sitedirectory") & "/index.asp?" & getTargetScript() & "&acc=" & session("accountid") & "&page=extranet&selected=dashboard"">Dashboard</a>"
		end if
	else
		strLoginMsg = "Welcome to " & application("ExtranetTitle") & "</span> <a class=""button"" href=""/" & application("sitedirectory") & "/index.asp?" & getTargetScript() & "&acc=" & session("accountid") & "&page=extranet&selected=dashboard"">Dashboard</a>"
	end if
	call closeDBconnBrokerdata()

	function getNumClientMessages()
		strSql = "select count(*) as msgcount " & vbcrlf & _
		"from 	tblclientevent with (nolock) " & vbcrlf & _
		"where 	activeflag = 1  " & vbcrlf & _
		"	and accountid = (select accountid from vewactiveclients where clientid = " & intNavClientID & ") " & vbcrlf & _
		"	and ( " & vbcrlf & _
		"		(clientid = " & intNavClientID & " and lastvieweddate is null) " & vbcrlf & _
		"		or (clientid is null and [date] between MessageStartDate and MessageEndDate and insertdate > (select lastlogindate from vewactiveclient where clientid = " & intNavClientID & ")" & vbcrlf & _
		"		) " & vbcrlf & _
		"	) " & vbcrlf
		'response.Write "<pre>" & strsql & "</pre>"

		set rsMsg = server.CreateObject("adodb.recordset")
		rsMsg.Open strSql, connDBextranetClientNav, 0, 1

		if not rsMsg.EOF then
			getNumClientMessages = rsMsg("msgcount")
		else
			getNumClientMessages = 0
		end if
		rsMsg.Close
	end function

	function getNumFavorites()
	strSql = "select count(tblfavorite.favoriteid) as favoritecount" & vbcrlf & _
	"from tblfavorite with (nolock) inner join tblfavoritefolder with (nolock) " & vbcrlf & _
	"on tblfavorite.favoritefolderid=tblfavoritefolder.favoritefolderid " & vbcrlf & _
	"where tblFavoriteFolder.FavoriteFolderType = 0 and tblfavoritefolder.clientid=" & intNavClientID
		'response.Write "<pre>" & strsql & "</pre>"

		set rsFav = server.CreateObject("adodb.recordset")
		rsFav.Open strSql, connDBextranetClientNav, 0, 1

		if not rsFav.EOF then
			getNumFavorites = rsFav("favoritecount")
		else
			getNumFavorites = 0
		end if
		rsFav.Close
	end function

	function getNumHomeValuesReports()
		strSql = "select count(s.searchid) as homeValuesCounts " & vbcrlf & _
				"from tblsearch s with (nolock) " & vbcrlf & _
				"join tblsearchsaved ss with (nolock) " & vbcrlf & _
				"on s.searchid = ss.searchid " & vbcrlf & _
				"where displayformatcode = 10 " & vbcrlf & _
				"and ss.InactiveDate is NULL " & vbcrlf & _
				"and clientid =" & intNavClientID
		'response.Write "<pre>" & strsql & "</pre>"

		set rsHomeValues = server.CreateObject("adodb.recordset")
		rsHomeValues.Open strSql, connDBextranetClientNav, 0, 1

		if not rsHomeValues.EOF then
			getNumHomeValuesReports = rsHomeValues("homeValuesCounts")
		end if
		rsHomeValues.Close
	end function

Function getNumSavedSearches(pType)
	strSql = "select count(*) as numSearches " & vbcrlf & _
		"from vewClientSearch_savedsearch4 " & vbcrlf & _
		"where clientid = " & intNavClientID

	If pType = "neighborhood"  Then
		strSql = strSql & " and DisplayFormatCode = 8"
	Else
		strSql = strSql & " and DisplayFormatCode between 0 and 7"
	End If

	set rsSearches = server.CreateObject("adodb.recordset")
	rsSearches.Open strSql, connDBextranetClientNav, 0, 1

	if not rsSearches.EOF then
		getNumSavedSearches = rsSearches("numSearches")
	else
		getNumSavedSearches = 0
	end if
	rsSearches.Close
End Function

	function populateExtranetClientInfo (pClientID)
		dim strSqlLocal
		dim rsClientInfo
		dim dctReturn
		dim iCount

		set dctReturn = server.createObject("scripting.dictionary")

		strSqlLocal = 	"select	vewactiveclient.firstname, " & vbcrlf & _
						"	vewactiveclient.lastname, " & vbcrlf & _
						"	vewactiveclient.emailaddr "& vbcrlf & _
						"from	vewactiveclient " & vbcrlf & _
						"where	clientid = " & clng(pClientID)

		set rsClientInfo = Server.CreateObject("ADODB.Recordset")
		rsClientInfo.Open strSqlLocal, connDBextranetClientNav, 0, 1
		set rsClientInfo.ActiveConnection = nothing

		if not rsClientInfo.EOF then
			for iCount=0 to (rsClientInfo.fields.count-1)
				dctReturn.add rsClientInfo.fields(iCount).name, rsClientInfo.fields(iCount).value
			next

			dctReturn.add "clientname", dctReturn.item("firstname")
			'dctReturn.add "clientfullname", dctReturn.item("firstname") & " " & dctReturn.item("lastname")

		end if

		rsClientInfo.close
		set rsClientInfo = nothing

		set populateExtranetClientInfo = dctReturn
	end function
end if
if blnUseOverlays then%>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> -->
<script type="text/javascript" src="/scripts/reliance.jsx?id=<%=application("Companyid")%>"></script>
<!-- #include virtual="/modules/internet/extranet/extranetoverlay-js.asp" -->

<%end if
strPrimary = ""
if len(request.Cookies("officeaccountid_searchbranding")) > 0 then

	call openDBConnBrokerdata()
	strSql = "select domainname from vewcompanydomaindata where companyid = " & application("CompanyID") & " and isprimarydomain = 1 "

	set rsDomain = Server.CreateObject("ADODB.Recordset")
	rsDomain.Open strSql, connDBextranetClientNav, 0, 1
	set rsDomain.ActiveConnection = nothing

	if not rsDomain.EOF then
		strPrimary = "http://www." & rsDomain("domainname")
	end if
	call closeDBconnBrokerdata()

end if

'// this is to support the microsite so that the extranet links load the correct page
function getTargetScript()
	strReturn = "p=findahome.asp"
	if request("p") = "microsite.asp" or request("p") = "micrositesearch.asp" then
		strReturn = "p=micrositesearch.asp&accountid=" & request("accountid")
	end if
	getTargetScript = strReturn
end function
%>

<div class="rn-site-header-property-watch" id="containertext">
<%if not blnShowClientInfo then
	if blnUseOverlays then
		strLoginLink = "javascript:getLoginPage('clientlogin');"
	else
		strLoginLink = strPrimary & "/" & application("sitedirectory") & "/index.asp?" & getTargetScript() & "&page=extranet&selected=login&acc=" & session("accountid")
	end if%>

	<span>Save Properties, Get Notified</span>
	<a href="<%=strLoginLink%>" class="button">Log In | Create Account</a>
	<a href="contact-us.aspx" class="button"><i class="rn-icon-bubble"></i> Ask a Question</a>

<%elseif len(strExecutePage) > 0 then
	if blnUseOverlays then
		strLoginLink = "javascript:getLoginPage('clientlogout');"
	else
		strLoginLink = strPrimary & "/" & application("sitedirectory") & "/index.asp?" & getTargetScript() & "&page=extranet&selected=clientlogout&acc=" & session("accountid")
	end if %>

	<span title="<%=dctExtranetClientInfo.item("firstname")%><%=dctExtranetClientInfo.item("lastname")%>"><%if len(session("intranet_accountid")) = 0 then%>Hello, <%=Left(dctExtranetClientInfo.item("clientname"), 17)%>.</span>
	<a class="button" href="javascript://Log Out;" onclick="javascript:deleteCookies();">Log Out</a><%end if%>
	<a class="button" href="/<%=application("sitedirectory")%>/index.asp?<%=getTargetScript()%>&acc=<%=session("accountid")%>&page=extranet&selected=dashboard">Dashboard</a>
	<a class="button hide-for-mobile" href="/<%=application("sitedirectory")%>/index.asp?<%=getTargetScript()%>&acc=<%=session("accountid")%>&page=extranet&selected=searches">Searches (<%=intSavedSearchesCount%>)</a>
	<%If blnNeighborhoodCount Then%>
		<a class="button" href="/<%=application("sitedirectory")%>/index.asp?<%=getTargetScript()%>&acc=<%=session("accountid")%>&page=extranet&selected=tracker">Neighborhoods (<%=intTrackedNeighborhoodsCount%>)</a>
	<%End If%>
	<a class="button hide-for-mobile" href="/<%=application("sitedirectory")%>/index.asp?<%=getTargetScript()%>&acc=<%=session("accountid")%>&page=extranet&selected=favorites">Favorites (<%=intFavoritesCount%>)</a>
	<%If vsoHomeValuationReport Then%>
		<a class="button hide-for-mobile" href="/<%=application("sitedirectory")%>/index.asp?<%=getTargetScript()%>&acc=<%=session("accountid")%>&page=extranet&selected=dashboard">Home Values (<%=intHomeValuesCount%>)</a>
	<%End If%>
	<a class="button hide-for-mobile" href="/<%=application("sitedirectory")%>/index.asp?<%=getTargetScript()%>&acc=<%=session("accountid")%>&page=extranet&selected=messages">Messages (<%=intClientMsgCount%>)	</a>
<% else
	if blnUseOverlays then
		strLoginLink = "javascript:getLoginPage('clientlogout');"
	else
		strLoginLink = strPrimary & "/" & application("sitedirectory") & "/index.asp?" & getTargetScript() & "&page=extranet&selected=clientlogout&acc=" & session("accountid")
	end if %>

	<span><%if len(session("intranet_accountid")) = 0 then%>Hello, <%=dctExtranetClientInfo.item("clientname")%>. <%end if%><%=strLoginMsg%> <a class="button" href="<%=strLoginLink%>">Log Out</a>
<%end if%>
</div>

<script>
function deleteCookies() {
	if (typeof amplify === "object") {
		amplify.store("ldp", null);
	}
	document.cookie = "client = ; expires=" + new Date + "; path=/";
	document.location = "<%=strLoginLink%>";
}

$(document).ready(function() {
	$(window).on('clientnavlogincomplete', function(evnt) {
		$.ajax({url:'/<%=cSiteDirectory%>/modules/internet/extranet/extranetclientnav.inc.asp?<%=request.querystring%>', success:function(response) {
				$('#containertext').replaceWith(response);
			}
		});
	});
});
</script>