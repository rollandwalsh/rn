
rnAddPageClasses = null
rnIsHomePage = null
rnIsLegacySearchPage = null
rnIsSearch3Page = null
rnIsAgentPage = null
rnIsSearch3ListingPage = null


$(document).ready ->

    rnAddPageClasses = ->

        # Add page specific classes
        if rnIsHomePage()

            console.log("HOME PAGE");

            $("body").addClass("rn-home-page");
            $(".rn-main-section").addClass("rn-site-home");
            $(".rn-main-section > .rn-container").removeClass("rn-container");

        else if rnIsSearch3()

            console.log("SEARCH 3");

            $("body").addClass("rn-search-page");
            $(".rn-main-section").addClass("rn-site-search");
            $(".rn-main-section > .rn-container").removeClass("rn-container");

        else if rnIsAgentPage()

            console.log("AGENT PAGE");

            $("body").addClass("rn-agent-office-page");
            $(".rn-main-section").addClass("rn-site-agent-office");
            $(".rn-main-section > .rn-container").removeClass("rn-container");

        else if rnIsLegacySearchPage()

            console.log("LEGACY SEARCH PAGE");

            $("body").addClass("rn-search-page");
            $("body").addClass("rn-legacy-search-page");
            $(".rn-main-section").addClass("rn-site-search");

        else

            console.log("SUB PAGE");

            $("body").addClass("rn-interior-page");
            $(".rn-main-section").addClass("rn-site-interior");


        return
        

    rnIsHomePage = ->
        r = false
        if window.location.search is "" and (window.location.pathname is "" or window.location.pathname is "/")
            r = true
        r

    rnIsLegacySearchPage = ->
        r = false
        url = window.location.search
        search1 = url.search("findahome")

        if search1 > 0
            r = true
        r

    rnIsSearch3Page = ->
        r = false
        if $('#rnSearch').length
            r = true
        r

    rnIsSearch3ListingPage = ->
        r = false
        if $('.rn-search-listing').length
            r = true
        r

    # Any page that needs search.css
    rnIsSearch3 = ->
        r = false
        if $('#rnSearch').length
            r = true
        if $('.rn-search-listing').length
            r = true
        r

    rnIsAgentPage = ->
        r = false
        url = window.location.search
        search1 = url.search("findagentoffice");
        search2 = url.search("agentresults");
        search3 = url.search("agentResults");

        if search1 > 0 or search2 > 0 or search3 > 0
            r = true
        r

    rnIsSubPage = ->
        r = false
        if !rnIsHomePage() and !rnIsSearch3Page() and !rnIsAgentPage() and !rnIsLegacySearchPage()
            r = true
        r
  
    return