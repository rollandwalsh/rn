<!--#include file="../../modules/global/constants/siteoptions.inc" -->
<% cMedia = application("mediapath") %>
<script language="javascript">
function Region(regionid) {
	instructionsid.style.display="none";
	officeviewdivid.style.display="block";
	document.all("officeiframeid").src="/<%=application("sitedirectory")%>/custompages/office.asp?regionid=" + regionid;
	document.all('vRegionID').value = regionid
}
function SortIFrame(SortBy) {
	document.all("officeiframeid").src="/<%=application("sitedirectory")%>/custompages/office.asp?OrderBy=" + SortBy + "&regionid=" + document.all('vRegionID').value;
}
</script>
<table cellpadding='0' cellspacing='0' border='0' width='100%' height='100%'>
<%if application("companyid") = 46 then%>
<tr>
<td width='135' rowspan='6' valign='top' class='sidenavbgcolor'>

	<table cellpadding='0' cellspacing='0' border='0'>
	<tr>
	<td><img src='<%=cMedia%>/global/invis.gif' width='2' height="100%"></td>
	<td><%server.execute "/" & application("sitedirectory") & "/custompages/main.inc"%></td>
	<td><img src='<%=cMedia%>/global/invis.gif' width='1' height="100%"></td>
	</tr>
	</table>
	
</td>
<td width='20' rowspan='6' valign='top'><img src='<%=cMedia%>/global/invis.gif' width='20' height="100%"></td>
<td><img src='<%=cMedia%>/global/invis.gif' width="100%" height='16'></td>
<td width='20' rowspan='6' valign='top'><img src='<%=cMedia%>/global/invis.gif' width='20' height="100%"></td>
</tr>
<%end if%>
<tr>
<td><img src='<%=cMedia%>/pageheadings/<%=application("pageheading")%>/findanagent.gif'></td>
</tr>
<tr>
<td><img src='<%=cMedia%>/global/invis.gif' width="100%" height='15'></td>
</tr>
<tr>
<td valign=top height='100%' width='100%' align='center'>

	<%'//-----------------------------------------------------------------------------------------------------------------------------Begin Content Area------//%>
		
			<table cellpadding='0' cellspacing='0' border='0'>
			<td align='center'>
				
				<table border='0' cellpadding='0' cellspacing='0'>
				<form method='post' action='/<%=application("sitedirectory")%>/default.asp?p=agentsearchresults.asp&action=FromAgent' name='form2'>
				<tr>
				<td rowspan='4'><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchagentname1.gif'></td>
				<td rowspan='2' valign='bottom'><input name='AgentName' size='32' class='input' style='border-color:#244471;color:#244471;'></td>
				<td colspan='3'><img src='<%=cMedia%>/global/invis.gif' width='100%' height='12'></td>
				<td><img src='<%=cMedia%>/global/invis.gif' width='1' height='12'></td>
				</tr>
				<tr>
				<td rowspan='3'><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchagentname5.gif'></td>
				<td rowspan='2'><input type='image' src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchagentname3.gif' name='submit' value='Search' border='0'></td>
				<td rowspan='3'><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchagentname5.gif'></td>
				<td><img src='<%=cMedia%>/global/invis.gif' width='1' height='18'></td>
				</tr>
				<tr>
				<td rowspan='2'><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchagentname2.gif'></td>
				<td><img src='<%=cMedia%>/global/invis.gif' width='1' height='8'></td>
				</tr>
				<tr>
				<td><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchagentname4.gif'></td>
				<td><img src='<%=cMedia%>/global/invis.gif' width='1' height='11'></td>
				</tr>
				</form>
				</table>
			
			</td>
			</tr>
			<tr>
			<td><img src='<%=cMedia%>/global/invis.gif' width='100%' height='15'></td>
			</tr>
			<tr>
			<td bgcolor='#2e5b89'><img src='<%=cMedia%>/global/invis.gif' width='100%' height='2'></td>
			</tr>
			<tr>
			<td><img src='<%=cMedia%>/global/invis.gif' width='100%' height='10'></td>
			</tr>
			<%if not (instr(lcase(Request.ServerVariables("http_user_agent")),"netscape") > 0) then%>
			<tr>
			<td><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchbycounty.gif' border="0"></td>
			<tr>
			<tr>
			<td align='center'>
			
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
				<td rowspan="4">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<td><img src="<%=cMedia%>/CompanySet/<%=application("sitedirectory")%>/officemap.gif" usemap="#officemap" border="0">
						
						<%'server.Execute "/" & application("sitedirectory") & "/custompages/officemap.inc"%>
						
					</td>
					</tr>
					</table>
						
				</td>
				<td rowspan="4"><img src="<%=cMedia%>/global/invis.gif" width="10" height="100%"></td>
				<td><img src="<%=cMedia%>/global/invis.gif" width="100%" height="1"></td>
				</tr>
				<tr>
				<td>
				<div id="instructionsid" style="display:block;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<td><img src="<%=cMedia%>/global/invis.gif" width="100%" height="28"></td>
					</tr>
					<td><img src="<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchbycountyinstructions.gif" width="329" height="220"></td>
					</tr>
					</table>
				
				</div>
				
				<div id="officeviewdivid" style="display:none;">
				
					<table cellpadding="0" cellspacing="0" border="0">
					<tr>
					<td height="18" align="center"><span id="officecountspanid" style="color:#a53700; font-weight:bold; font-size:11;"></span></td>
					</tr>
					<tr>
					<td><img src="<%=cMedia%>/global/invis.gif" width="100%" height="10"></td>
					</tr>
					<td>
					
						<table cellpadding="0" cellspacing="0" border="0" width="330">
						<form>
						<input name="vRegionID" type="hidden" value="">
						<tr height='18'>
						<td width="219" align='center' class='linebottom' bgcolor='#2e5b89'><a style="cursor:hand" onClick="javascript:SortIFrame('OfficeName')"><font color='white'><b><u>Office Name</u></b></font></a></td>
						<td width='106' align='center' class='linebottomleftwhite' bgcolor='#2e5b89' align='center'><a style="cursor:hand" onClick="javascript:SortIFrame('City')"><font color='white'><b><u>City</u></b></font></td>
						<td width="1"><img src="<%=cMedia%>/global/invis.gif" width="1" height="100%"></td>
						<td width="16"><img src="<%=cMedia%>/companyset/<%=application("sitedirectory")%>/officesearchscrolltop.gif" width="16" height="18"></td>
						</tr>
						<tr>
						<td colspan="5"><iframe id="officeiframeid" src="/<%=application("sitedirectory")%>/custompages/office.asp" frameborder="no" style="width:330;height:199;" scrolling="yes"></iframe></td>
						</tr>
						<tr height='3'>
						<td width="209" align='center' bgcolor='#2e5b89'></td>
						<td width='110' align='center' style="border-left:#ffffff 1px solid;" bgcolor='#2e5b89' align='center'></td>
						<td width="1"><img src="<%=cMedia%>/global/invis.gif" width="1" height="100%"></td>
						<td width="16"><img src="<%=cMedia%>/companyset/<%=application("sitedirectory")%>/officesearchscrollbottom.gif" width="16" height="3"></td>
						</tr>
						</form>
						</table>
						
					
					</td>
					</tr>
					</table>
				
				</div>
				</td>
				</tr>
				</table>
			
			</td>
			</tr>
			<tr>
			<td><img src='<%=cMedia%>/global/invis.gif' width='100%' height='10'></td>
			</tr>
			<tr>
			<td>
			<div id="officedivid" style="display:none;">
			
				<table cellpadding='10' cellspacing='0' border='0' class='lineall'>
				<tr>
				<td>
					
					<table cellpadding="0" cellspacing="0" border="0" width="548">
					<tr>
					<td colspan="5"><span style='font-weight:900;font-size:17px;' id="officenameid"></span></td>
					<td rowspan="7" width="15"><img src="<%=cMedia%>/global/invis.gif" width="15" height="100%"></td>
					<td rowspan="7" width="96"><span id="photoid"></span></td>
					</tr>
					<tr>
					<td rowspan="6"><img src="<%=cMedia%>/global/invis.gif" width="3" height="100%"></td>
					<td colspan="4"><img src="<%=cMedia%>/global/invis.gif" width="100%" height="10"></td>
					</tr>
					<tr>
					<td colspan="4">
					
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<td rowspan="2"><span id="directions2id"></span></td>
						<td rowspan="2"><img src="<%=cMedia%>/global/invis.gif" width="4" height="100%"></td>
						<td><span id="addressid"></span></td>
						</tr>
						<tr>
						<td><span id="cityid"></span></td>
						</tr>
						<tr>
						<td colspan="3"><span id="directionsid"></span></td>
						</tr>
						</table>
					
					</td>
					</tr>
					<tr>
					<td colspan="4"><img src="<%=cMedia%>/global/invis.gif" width="100%" height="10"></td>
					</tr>
					<tr>
					<td width="21"><img src="<%=cMedia%>/global/general/emailicon.gif" width="21" height="17"></td>
					<td width="4"><img src="<%=cMedia%>/global/invis.gif" width="4" height="100%"></td>
					<td width="323"><span id="emailid"></span></td>
					<td width="107" rowspan="3">
					
						<table cellpadding="0" cellspacing="0" border="0">
						<tr>
						<td><span id="viewsiteid"></span></td>
						</tr>
						<tr>
						<td><img src="<%=cMedia%>/global/invis.gif" width="107" height="5"></td>
						</tr>
						<tr>
						<td><span id="agentrosterid"></span></td>
						</tr>
						</table>
					
					</td>
					</tr>
					<tr>
					<td width="21"><img src="<%=cMedia%>/global/general/phoneicon.gif" width="21" height="17"></td>
					<td width="4"><img src="<%=cMedia%>/global/invis.gif" width="4" height="100%"></td>
					<td width="323">Phone: <span id="phoneid"></span></td>
					</tr>
					<tr>
					<td width="21"><img src="<%=cMedia%>/global/general/faxicon.gif" width="21" height="17"></td>
					<td width="4"><img src="<%=cMedia%>/global/invis.gif" width="4" height="100%"></td>
					<td width="323">Fax: <span id="faxid"></span></td>
					</tr>
					</table>
										
				</td>
				</tr>
				</table>
			
			</div>
			
			<div id="loadingdivid" style="display:none;">
			
				<table cellpadding="10" cellspacing="0" border="0" class="lineall" width="568" height="136">
				<tr>
				<td align="center">- Loading -</td>
				</tr>
				</table>
				
			</div>
			</td>
			</tr>
			<tr>
			<td><img src='<%=cMedia%>/global/invis.gif' width='100%' height='15'></td>
			</tr>
			<tr>
			<td bgcolor='#2e5b89'><img src='<%=cMedia%>/global/invis.gif' width='100%' height='2'></td>
			</tr>
			<tr>
			<td><img src='<%=cMedia%>/global/invis.gif' width='100%' height='10'></td>
			</tr>
			<tr>
			<td><a href="/<%=application("sitedirectory")%>/default.asp?p=alloffice.asp"><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchbyoffice.gif' border="0"></a></td>
			<tr>
			</table>
			<%else
				set BD=server.CreateObject("ADODB.Connection")
				BD.CommandTimeout=Application("Brokerdata_CommandTimeout")
				BD.ConnectionTimeout= Application("Brokerdata_ConnectionTimeout")
				BD.Open Application("Brokerdata_ConnectionString")%>

				<table cellpadding='0' cellspacing='0' border='0'>
				<tr>
				<td><img src='<%=cMedia%>/companyset/<%=application("sitedirectory")%>/searchbyoffice2.gif'></td>
				<tr>
				<tr>
				<td align='center'>
					
					<table border='0' cellpadding='0' cellspacing='0' width='570'>
					<tr height='18' bgcolor='#2e5b89'>
					<td align='center' class='linebottom'><font color='white'><b>&nbsp;Office Name</b></font></td>
					<td width='120' align='center' class='linebottomleftwhite' align='center'><font color='white'><b>Phone Number</b></font></td>
					<td align='center' class='linebottomleftwhite' width='115'><font color='white'><b>View Office Site</b></font></td>
					<td width='105' align='center' class='linebottomleftwhite'><font color='white'><b>View Agents</b></font></td>
					</tr>
					<!--<tr>
					<td colspan='2' align='center'>--><%i= false
				sql = "SELECT vewActiveOffices.OfficeID, vewActiveOffices.OfficeName,vewActiveOffices.OfficePhone, tblaccount.accountid FROM vewActiveOffices inner join tblaccount " & _
				" on vewActiveOffices.officeid=tblaccount.officeid WHERE vewActiveOffices.CompanyID=" & Application("CompanyID") & _ 
				" AND dbo.fn_hassiteoption(" & soAccount & ", accountid, " & soOfficeSite & ") =" & soHasSiteOption & _
				" ORDER BY OfficeName"
			
					
					set rsOffice=BD.Execute(sql)
					              
					while not rsOffice.eof  
					Response.Write "<tr  height='20'>"
					Response.Write "<td class='linebottomleft'>" &  "&nbsp;" & rsOffice("OfficeName") & "</td>"
					Response.Write "<td align='center' width='120' class='linebottomleft'>&nbsp;" &  rsOffice("OfficePhone") & "</td>"
					Response.Write "<td onMouseOver=""this.style.backgroundColor='#f5f9fc'; this.style.cursor='default';"" onMouseOut=""this.style.backgroundColor='#ffffff';"" class='linebottomleft' width='115' align='center'><a href='/" & application("sitedirectory") & "/index.asp?acc=" & rsoffice("accountid") & "' target=_parent>Office Web Site</a></td>"
					Response.Write "<td onMouseOver=""this.style.backgroundColor='#f5f9fc'; this.style.cursor='default';"" onMouseOut=""this.style.backgroundColor='#ffffff';""  class='linebottomleftright' width='100' align='center'><a href='default.asp?p=agentsearchresults.asp&action=FromOffice&OfficeID=" & rsOffice("OfficeID") & "'>Agent Roster</a></td>"
					Response.Write "</tr>"
					' vPhoneFormatted=0
					' vAreaCode=0
					'  vPrexfix=0
					'  vLastFour=0
					rsOffice.MoveNext
					               
					wend
					rsoffice.close
					set BD = nothing
					%>
					<tr height='4' bgcolor='#2e5b89'>
					<td></td>
					<td></td>
					<td width='120'></td>
					<td></td>
					</tr>
					</td>
					</tr>
					</table>
					
				</td>
				</tr>
				</table>
			
			<%end if%>
			
		<%'//-------------------------------------------------------------------------------------------------------------------------------End Content Area------//%>
	
</td>
</tr>
<%if application("companyid") = 46 then%>
<tr>
<td height='40'><img src='<%=cMedia%>/global/invis.gif' width="100%" height='40'></td>
</tr>
<tr>
<td><%server.execute "/" & application("sitedirectory") & "/custompages/copyright.inc"%></td>
</tr>
<%end if%>
</table>