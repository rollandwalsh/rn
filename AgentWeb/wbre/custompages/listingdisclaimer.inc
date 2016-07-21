<%
dim vLastUpdated, vThisYear
vLastUpdated = Date()
vThisYear = Year(Now())
%>
<span class="disclaimer">This property search is part of www.pru-nw.com. The data
relating to real estate for sale on this website come in part from the IDX
program of the Regional Multiple Listings Service (RMLS) of Portland Oregon, the 
IDX Program of the Tillamook MLS, the Multiple Listing Service of Central Oregon, Bend, Oregon 
and <%=application("companyname")%>. Real estate listings
held by other than <%=application("companyname")%> are marked with the
RMLS<SUP>™</SUP> logo for RMLS Listings, and detailed information about these properties includes the names
of the listing brokers. Listing data is copyright of <%=vThisYear%>; RMLS (Portland,
Oregon), Tillamook MLS, Central Oregon MLS and <%=application("companyname")%>. This data last
updated on <%=vLastUpdated%>. Some properties which appear for sale on this
site may subsequently have sold or may no longer be available. All
information provided is deemed reliable but is not guaranteed and should be
independently verified. IDX and listing information is provided exclusively for
consumers' personal, non-commercial use and may not be used for any purpose
other than to identify prospective properties consumers may be interested in purchasing.</span>
