<!-- #include virtual="modules/global/constants/siteoptions.inc" -->
<!-- #include virtual="modules/global/clientcookie-inc.asp" -->
<!-- #include virtual="modules/global/quicksearch-inc.asp" -->

<%
' sets db connection up
    set cnBD = server.CreateObject("adodb.connection")
    cnBD.CursorLocation = 3
    cnBD.Open application("brokerdata_connectionstring")
' db statement
    strSql = "select [companycontentpageid], [contenttext] " & _
	    "from [tblcompanycontentpage] with (NOLOCK)" & _
	    "where [companycontentpageid] in (13396, 13397, 13395, 13421, 13431, 14216) "
    set rsPage = server.CreateObject("adodb.recordset")
    rsPage.Open strSql, cnBD
    set rsPage.ActiveConnection = nothing
' This sets up the dictionary
    Set PagesToUse = CreateObject("Scripting.Dictionary")
' This will loop through and create dictionary enteries
    do while not rsPage.eof
            PagesToUse.Add rsPage("companycontentpageid").Value, rsPage("contenttext").Value
	    rsPage.MoveNext
    loop
' Close db connections
    rsPage.Close
    set rsPage = nothing
    cnBD.Close
    set cnBD = nothing
%>

<%
cMedia = Application("mediapath")
cSiteDir = Application("sitedirectory")
cDynaImages = Application("dyna_images")
cStatic = "/static"
%>


			<div class="rn-home-hero-area">
				<div class="rn-home-carousel" data-slick='{"arrows": false, "speed": 600, "autoplay": true, "autoplaySpeed": 6000, "fade": true}' id="homeCarousel">
					<div style="background-image: url('http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/slide-1.jpg')"></div>
					<div style="background-image: url('http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/slide-2.jpg')"></div>
					<div style="background-image: url('http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/slide-3.jpg')"></div>
					<div style="background-image: url('http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/slide-4.jpg')"></div>
					<div style="background-image: url('http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/slide-5.jpg')"></div>
					<div style="background-image: url('http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/slide-6.jpg')"></div>
				</div>
				
				<section class="rn-home-hero-box">
					<ul class="rn-home-hero-nav" id="homeHeroNav">
						<li class="active" id="propSearchBtn" data-content="propSearch">Property Search</li>
						<li id="homeValBtn" data-content="homeVal">Home Values</li>
					</ul>
					
					<div class="rn-home-hero-content" id="propSearch">
						<h2>Get Your Keys With Ease</h2>
						<% if request.ServerVariables("SERVER_NAME") = "devweb.summitnetworks.com" or request.ServerVariables("SERVER_NAME") = "testweb.summitnetworks.com" or request.ServerVariables("SERVER_NAME") = "www.dev1.com" or request.ServerVariables("SERVER_NAME") = "www.rnplatform2.com" then  %>
							<script src="http://reliancenetwork.com/widgets/?file=quicksearchredirect&token=N01qN29q&fields=mn[Price]|mx[to]&button=Search&placeholder=Location or MLS"></script>
						<% else %>
							<script src="/widgets/?file=quicksearchredirect&token=N01qN29q&fields=mn[Price]|mx[to]&button=Search&placeholder=Location or MLS"></script>
						<% end if %>
					</div>
					
					<div class="rn-home-hero-content" id="homeVal" style="display: none">
						<h2>What Is Your Home Worth?</h2>
						<form class="rn-home-home-values-form" id="rnHomeValuesForm" action="/?p=homevaluesreport.asp" method="post">
							<input name="formsubmit" type="hidden" value="true" />
							<input name="form" type="hidden" value="Home Values" />
							<input name="home_values_homepage" type="hidden" value="true" />
							<input class="rn-home-values-address" name="address" type="text" id="home-value-input" placeholder="Enter an Address" />
							<button class="rn-home-values-button" id="home-value-submit" type="submit">Find Out Now <i class="rn-icon-angle-right-medium"></i></button>
						</form>
					</div>

					<div class="rn-home-hero-content">
						<h3>Get Matched With Your Perfect Neighborhood</h3>
						<a href="https://www.liveby.co/woodsbros" target="_blank">Discover Now</a>
						<h6>BETA Version</h6>
					</div>
				</section>
			</div>
			
			<div class="rn-container">
				<section class="rn-home-callouts">
					<a href="http://<%=request.ServerVariables("http_host")%>/?p=findahome.asp&page=search&selected=openhouse&t=600" class="rn-home-callout">
						<img src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/open-houses-callout.png" alt="Open Houses" style="width: 120px;">
						<h3>Open Houses</h3>
						<span class="copy">Thinking about buying or building a new construction home? Get advice and ideas here.</span>
						<button>Search Now</button>
					</a>
					
					<div class="rn-divider"></div>
					
					<a href="http://<%=request.ServerVariables("http_host")%>/?p=buildsavedsearch.asp&searchid=84735759" class="rn-home-callout">
						<img src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/new-construction-callout.png" alt="New Home Construction" style="width: 119px;">
						<h3>New Construction</h3>
						<span class="copy">Thinking about buying or building a new construction home? Get advice and ideas here.</span>
						<button>Learn More</button>
					</a>
					
					<div class="rn-divider"></div>
					
					<a href="http://<%=request.ServerVariables("http_host")%>/Premier-Properties" class="rn-home-callout">
						<img src="http://<%=request.ServerVariables("http_host")%>/<%=cSiteDir %>/img/premier-properties-callout.png" alt="Premier Properties" style="width: 202px;">
						<h3>Premier Properties</h3>
						<span class="copy">View Woods Bros Realty’s Premier Properties, luxury and million-dollar homes for sale.</span>
						<button>Learn More</button>
					</a>
					
					<div class="rn-divider"></div>
					
					<div class="rn-home-callout-rows">
						<a href="http://www.careersatwoodsbros.com" class="rn-home-callout-row" target="_blank">
							<h3>Join Our Team</h3>
							<span class="copy">List. Sell. SUCCEED. End your career search today.</span>
							<span class="link">Find Out More <i class="rn-icon-angle-right-big"></i></span>
						</a>
						
						<hr>
						<a href="http://<%=request.ServerVariables("http_host")%>/?p=findahome.asp&selected=mr" class="rn-home-callout-row">
							<h3>Market Watch</h3>
							<span class="copy">Let us find you the most current prices, listings and trends in any market area.</span>
							<span class="link">Get Report <i class="rn-icon-angle-right-big"></i></span>
						</a>
					</div>
				</section>
				
				<hr>

				<section class="rn-home-copy">
					<% Response.Write ( PagesToUse.Item(13396) ) %>
				</section>

				<hr>
				
				<section class="rn-home-links">
					<div class="rn-home-link">
						<h3 class="uppercase">Visit Our Communities Outside of Lincoln</h3>
						<ul class="rn-home-links-communities">
							<li><a href="http://<%=request.ServerVariables("http_host")%>/beatrice-real-estate-for-sale-nebraska.aspx">Beatrice <i class="rn-icon-angle-right-big"></i></a></li>
							<li><a href="http://<%=request.ServerVariables("http_host")%>/grand-island-real-estate-for-sale-nebraska.aspx">Grand Island <i class="rn-icon-angle-right-big"></i></a></li>
							<li><a href="http://<%=request.ServerVariables("http_host")%>/seward-real-estate-for-sale-nebraska.aspx">Seward <i class="rn-icon-angle-right-big"></i></a></li>
							<li><a href="http://<%=request.ServerVariables("http_host")%>/wahoo-real-estate-for-sale-nebraska.aspx">Wahoo <i class="rn-icon-angle-right-big"></i></a></li>
							<li><a href="http://<%=request.ServerVariables("http_host")%>/york-real-estate-for-sale-nebraska.aspx">York <i class="rn-icon-angle-right-big"></i></a></li>
						</ul>
						
						<hr>
						
						<h3 class="uppercase">Stay Connected</h3>
						<ul class="rn-home-links-social">
							<li><a href="https://www.facebook.com/woodsbros/" target="_blank"><i class="rn-icon-facebook"></i></a></li>
							<li><a href="https://twitter.com/woodsbros" target="_blank"><i class="rn-icon-twitter"></i></a></li>
							<li><a href="https://plus.google.com/+Woodsbros1889/posts" target="_blank"><i class="rn-icon-google-plus"></i></a></li>
							<li><a href="https://www.instagram.com/woodsbrosrealty/" target="_blank"><i class="rn-icon-instagram"></i></a></li>
							<li><a href="https://www.linkedin.com/company/woods-bros-realty" target="_blank"><i class="rn-icon-linkedin"></i></a></li>
							<li><a href="https://www.pinterest.com/woodsbros/" target="_blank"><i class="rn-icon-pinterest"></i></a></li>
							<li><a href="http://youtube.com/woodsbros" target="_blank"><i class="rn-icon-youtube"></i></a></li>
						</ul>
					</div>
					
					<div class="rn-divider"></div>
					
					<div class="rn-home-link">
						<% Response.Write ( PagesToUse.Item(14216) ) %>
					</div>
				</section>
			</div>
