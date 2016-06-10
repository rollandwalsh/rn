var rnAddPageClasses, rnIsAgentPage, rnIsHomePage, rnIsLegacySearchPage, rnIsSearch3ListingPage, rnIsSearch3Page;

rnAddPageClasses = null;

rnIsHomePage = null;

rnIsLegacySearchPage = null;

rnIsSearch3Page = null;

rnIsAgentPage = null;

rnIsSearch3ListingPage = null;

$(document).ready(function() {
  var rnIsSearch3, rnIsSubPage;
  rnAddPageClasses = function() {
    if (rnIsHomePage()) {
      console.log("HOME PAGE");
      $("body").addClass("rn-home-page");
      $(".rn-main-section").addClass("rn-site-home");
      $(".rn-main-section > .rn-container").removeClass("rn-container");
    } else if (rnIsSearch3()) {
      console.log("SEARCH 3");
      $("body").addClass("rn-search-page");
      $(".rn-main-section").addClass("rn-site-search");
      $(".rn-main-section > .rn-container").removeClass("rn-container");
    } else if (rnIsAgentPage()) {
      console.log("AGENT PAGE");
      $("body").addClass("rn-agent-office-page");
      $(".rn-main-section").addClass("rn-site-agent-office");
      $(".rn-main-section > .rn-container").removeClass("rn-container");
    } else if (rnIsLegacySearchPage()) {
      console.log("LEGACY SEARCH PAGE");
      $("body").addClass("rn-search-page");
      $("body").addClass("rn-legacy-search-page");
      $(".rn-main-section").addClass("rn-site-search");
    } else {
      console.log("SUB PAGE");
      $("body").addClass("rn-interior-page");
      $(".rn-main-section").addClass("rn-site-interior");
    }
  };
  rnIsHomePage = function() {
    var r;
    r = false;
    if (window.location.search === "" && (window.location.pathname === "" || window.location.pathname === "/")) {
      r = true;
    }
    return r;
  };
  rnIsLegacySearchPage = function() {
    var r, search1, url;
    r = false;
    url = window.location.search;
    search1 = url.search("findahome");
    if (search1 > 0) {
      r = true;
    }
    return r;
  };
  rnIsSearch3Page = function() {
    var r;
    r = false;
    if ($('#rnSearch').length) {
      r = true;
    }
    return r;
  };
  rnIsSearch3ListingPage = function() {
    var r;
    r = false;
    if ($('.rn-search-listing').length) {
      r = true;
    }
    return r;
  };
  rnIsSearch3 = function() {
    var r;
    r = false;
    if ($('#rnSearch').length) {
      r = true;
    }
    if ($('.rn-search-listing').length) {
      r = true;
    }
    return r;
  };
  rnIsAgentPage = function() {
    var r, search1, search2, search3, url;
    r = false;
    url = window.location.search;
    search1 = url.search("findagentoffice");
    search2 = url.search("agentresults");
    search3 = url.search("agentResults");
    if (search1 > 0 || search2 > 0 || search3 > 0) {
      r = true;
    }
    return r;
  };
  rnIsSubPage = function() {
    var r;
    r = false;
    if (!rnIsHomePage() && !rnIsSearch3Page() && !rnIsAgentPage() && !rnIsLegacySearchPage()) {
      r = true;
    }
    return r;
  };
});
