<%cSiteDir = Application("sitedirectory") %>
		<% if PageOn = "rn-home-page" then %>
			</div>
		<% elseif PageOn ="rn-agent-office-page" then %>
			</div>
		<% elseif PageOn ="rn-search-page" then %>
			</div>
		<% else %>
					<h3 class="uppercase">Stay Connected</h3>
					<ul class="rn-interior-links-social">
						<li><a href="https://www.facebook.com/woodsbros/" target="_blank"><i class="rn-icon-facebook"></i></a></li>
						<li><a href="https://twitter.com/woodsbros" target="_blank"><i class="rn-icon-twitter"></i></a></li>
						<li><a href="https://plus.google.com/+Woodsbros1889/posts" target="_blank"><i class="rn-icon-google-plus"></i></a></li>
						<li><a href="https://www.instagram.com/woodsbrosrealty/" target="_blank"><i class="rn-icon-instagram"></i></a></li>
						<li><a href="https://www.linkedin.com/company/woods-bros-realty" target="_blank"><i class="rn-icon-linkedin"></i></a></li>
						<li><a href="https://www.pinterest.com/woodsbros/" target="_blank"><i class="rn-icon-pinterest"></i></a></li>
						<li><a href="http://youtube.com/woodsbros" target="_blank"><i class="rn-icon-youtube"></i></a></li>
					</ul>
				</div>
			</div>
		<% end if %>

		<% if len(request.QueryString("token")) > 0 then %>
		    <!--iframe token is present-->
		    <footer></footer>
		<%else%>
			<footer class="rn-site-footer">
				<div class="rn-container">
					<nav class="rn-site-footer-nav">
						<% Response.Write ( PagesToUse.Item(13397) ) %>
					</nav>
					
					<div class="rn-site-footer-disclaimer">
						<%
							if (request.QueryString("p") = "findahome.asp") or (request.QueryString("p") = "openhouses.asp") or (request.QueryString("p") = "manuallisting") or (request.QueryString("p") = "propertyresume") or (request.QueryString("p") = "virtualtours") or (request.QueryString("p") = "featuredproperties.asp") and (request.QueryString("page") <> "extranet") then
								server.execute "/" & cSiteDir & "/modules/global/inc_listingdisclaimer.asp"
							end if
						%>
						<!-- #include file="copyright.inc"-->
						
						<a href="<%=application("intraneturl")%>">Agent Access</a>
					</div>
					
					<div class="rn-site-footer-links">
						<% Response.Write ( PagesToUse.Item(13421) ) %>
					</div>
				</div>
			</footer>
		<%end if%>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/2.1.0/js.cookie.min.js"></script>
		<script src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/js/app.min.js"></script>
		<% if PageOn = "rn-home-page" then %>
			<script src="http://cdn.jsdelivr.net/jquery.slick/1.5.9/slick.min.js"></script>
			<script src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/js/home.min.js"></script>
		<% end if %>

		<!-- #include virtual="/modules/global/adtracking.inc.asp" -->
		<%strAdTrackingCode = AdTracking("global")%>
		<%=strAdTrackingCode%>
	</body>
</html>
