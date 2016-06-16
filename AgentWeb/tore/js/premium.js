var navItemsClasses, pageBody, pageClass, urlPathname, urlSearch;

navItemsClasses = function() {
  $('#rnSiteHeaderNavMenu li').removeAttr('class');
  $('#rnSiteHeaderNavMenu a').removeAttr('class');
  return $('#rnSiteHeaderNavMenu .submenu-list').attr('class', 'dropdown').parent('li').addClass('has-dropdown');
};

urlPathname = window.location.pathname;

urlSearch = window.location.search;

pageBody = $('body');

pageClass = function() {
  if (urlSearch === '' && (urlPathname === '' || urlPathname === '/')) {
    return pageBody.addClass('rn-home-page');
  } else if (urlSearch.includes('findahome') || urlPathname.includes('Home') || urlPathname.includes('Land') || urlPathname.includes('Commercial') || urlPathname.includes('Condo') || urlPathname.includes('MultiFamily')) {
    return pageBody.addClass('rn-search-page');
  } else if (urlSearch.includes('findagentoffice') || urlSearch.includes('agentResults') || urlSearch.includes('agentresults')) {
    return pageBody.addClass('rn-agent-office-page');
  } else {
    return pageBody.addClass('rn-interior-page');
  }
};

navItemsClasses();

pageClass();
