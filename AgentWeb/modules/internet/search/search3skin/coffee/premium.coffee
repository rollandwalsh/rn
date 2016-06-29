navItemsClasses = ->
	$('#rnSiteHeaderNavMenu li').removeAttr 'class'
	# Remove uneccessary class from li tags
	$('#rnSiteHeaderNavMenu a').removeAttr 'class'
	# Remove uneccessary class from a tags
	$('#rnSiteHeaderNavMenu .submenu-list').attr('class', 'dropdown').parent('li').addClass 'has-dropdown'
	# Change dropdown ul tags to .dropdown and add .has-dropdown to their parent li tags

urlPathname = window.location.pathname
urlSearch = window.location.search
pageBody = $('body')

pageClass = ->
	if urlSearch is '' and (urlPathname is '' or urlPathname is '/')
		pageBody.addClass 'rn-home-page'
	else if urlSearch.includes('findahome') or urlPathname.includes('Home') or urlPathname.includes('Land') or urlPathname.includes('Commercial') or urlPathname.includes('Condo') or urlPathname.includes 'MultiFamily'
		pageBody.addClass 'rn-search-page'
		styleSheet = $('link[rel=stylesheet][href*="app"]').attr 'href'
		styleSheet = styleSheet.replace 'app', 'search'
		$('link[rel=stylesheet][href*="app"]').attr 'href', styleSheet
	else if urlSearch.includes('findagentoffice') or urlSearch.includes('agentResults') or urlSearch.includes('agentresults')
		pageBody.addClass 'rn-agent-office-page'
	else
		pageBody.addClass 'rn-interior-page'
		
navItemsClasses()
pageClass()
