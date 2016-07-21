<%
cSiteDir = application("sitedirectory")

thisYear = datePart("yyyy",Date())
if thisYear > 2004 then
	copyDate = "2004-" & thisYear
else
	copyDate = thisYear
end if
%>

<span class="main">
	&copy; 2001 - <%=thisYear%> <a href="http://www.reliancenetwork.com" target="_blank" title="Click here for Reliance Network">Reliance Network</a> and <%=application("CompanyName")%>. All rights reserved. U.S. Reg. Copyright TX-5-910-991, TX-5-910-992, TX-5-910-993, and TX-5-910-994. Equal Housing Opportunity.
</span>

<a href="http://www.reliancenetwork.com/"><img src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/reliance-network-logo.png" alt="Reliance Network"></a>

<span class="secondary">
	&copy; 2001 - <%=thisYear%> Woods Bros Realty, a Berkshire Hathaway Affiliate. Equal Housing Opportunity. 
</span>
