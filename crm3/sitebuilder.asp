<%@ Page Language="C#" AutoEventWireup="true" Debug="false" MasterPageFile="~/Intranet/Intranet.Master" Inherits="Reliance.RealEstate.Web.Intranet.IntranetBase" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<%@ Import Namespace="Reliance" %>
<%@ Import Namespace="Reliance.RealEstate" %>
<%@ Import Namespace="Reliance.RealEstate.Internet" %>
<%@ Import Namespace="Reliance.RealEstate.Intranet" %>
<%@ Import Namespace="Reliance.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>

<script type="text/javascript" runat="server">
	protected int id = 0;
	protected string selectOpts = string.Empty;
	protected string markup = string.Empty;
	protected string hdSel = string.Empty;
	protected string hpSel = string.Empty;
	protected string ppSel = string.Empty;
	protected string doSel = string.Empty;
	protected string idSel = string.Empty;
	protected string xslt = string.Empty;
	protected string dSel = "Sel";
	protected string designNumber = SessionVariables.IntranetDesignNumber;
	protected string siteDirectory = string.Empty;
	protected string accountName = string.Empty;
	protected string primaryAccountDomain = string.Empty;
	protected RealEstateBrand brand;
	protected RealEstateArchitecture architecture;
	protected int companyID;
	protected int intranetAccountID = SessionVariables.IntranetAccountID;
	protected bool accountUsesSandboxStructure;
	protected bool companyUsesSandboxStructure;
	protected bool websiteServiceProviderCompany;
	protected bool websiteServiceProviderAccount;
	protected bool adminOnlyUpgradeToPremium;
	protected bool isMicrosite;
	protected bool isAdmin;
	protected bool isOfficeAdmin;
	protected bool isOfficeGroupAdmin;
	protected bool isBCard;
	protected bool isAgentSite;
	protected bool isTeamSite;
	protected bool isOfficeSite;
	protected bool isOfficeGroupSite;
	protected bool doesNotHaveWebsite;
	protected bool doesNotHaveSiteBuilder;
	protected bool noSiteBuilderAccess;
	protected SiteManagementStatus siteManagementStatus;
	protected string disabledNav = string.Empty;
	protected string prePackagedNav = "Pre-Packaged Designs";
	protected string designCenterNav = "Design Center";
	protected string sandboxText = "website previewer";
	protected string sandboxTextProper = "Website Previewer";

	protected Reliance.Models.WebEnvironment webEnvironment;
	protected string userLink = string.Empty;
	protected string siteBuilderLink = string.Empty;
	protected string listingsLink = string.Empty;
	protected string clientsLink = string.Empty;
	protected string intranetNavMarkup = string.Empty;
	protected string adTracking = string.Empty;

	protected WebSessionCredentials cred;
	protected string mediaUrl = ContentServer.MediaContentUrl;
	protected bool isLive;
	protected bool HasCustomWebsite;
	protected int siteManagementCode;

	protected string supportUrl = string.Empty;

	void Page_Load(object sendere, EventArgs e) {
		id = CurrentUserAccountID;

		bool showXml = Convert.ToBoolean(Request.QueryString["printxml"]);
		siteDirectory = SessionVariables.SiteDirectory;

		// get the account site options for the account being viewed
		Reliance.SiteOptionList siteOptionList = new SiteOptionList();
		siteOptionList.Add(Reliance.SiteOption._UsesSandboxStructure);
		siteOptionList.Add(Reliance.SiteOption._IsMicroSite);
		siteOptionList.Add(Reliance.Models.SiteOption.IsAgentBCardSite);
		siteOptionList.Add(Reliance.Models.SiteOption.IsAgentSite);
		siteOptionList.Add(Reliance.Models.SiteOption.IsTeamSite);
		siteOptionList.Add(Reliance.Models.SiteOption.IsOfficeSite);
		siteOptionList.Add(Reliance.Models.SiteOption.IsOfficeGroupSite);
		siteOptionList.Add(Reliance.Models.SiteOption.DoesNotHaveWebsite);
		siteOptionList.Add(Reliance.Models.SiteOption.NoSiteBuilderAccess);
		SiteOptionDictionary siteOptions = SiteOptions.GetAccountSiteOptions(id, siteOptionList);
		accountUsesSandboxStructure = siteOptions[Reliance.SiteOption._UsesSandboxStructure];
		isMicrosite = siteOptions[Reliance.SiteOption._IsMicroSite];
		isBCard = siteOptions[Reliance.Models.SiteOption.IsAgentBCardSite];
		isAgentSite = siteOptions[Reliance.Models.SiteOption.IsAgentSite];
		isTeamSite = siteOptions[Reliance.Models.SiteOption.IsTeamSite];
		isOfficeSite = siteOptions[Reliance.Models.SiteOption.IsOfficeSite];
		isOfficeGroupSite = siteOptions[Reliance.Models.SiteOption.IsOfficeGroupSite];
		doesNotHaveWebsite = siteOptions[Reliance.Models.SiteOption.DoesNotHaveWebsite];
		doesNotHaveSiteBuilder = siteOptions[Reliance.Models.SiteOption.NoSiteBuilderAccess];

		// get the account site options for the one who's logged in
		Reliance.SiteOptionList siteOptionListLoggedIn = new SiteOptionList();
		siteOptionListLoggedIn.Add(Reliance.SiteOption._CanManageAllAccounts);
		siteOptionListLoggedIn.Add(Reliance.SiteOption._CanManageOfficeAccounts);
		siteOptionListLoggedIn.Add(Reliance.SiteOption._CanManageOfficeGroupAccounts);
		siteOptionListLoggedIn.Add(Reliance.SiteOption._WebsiteServiceProvider);
		SiteOptionDictionary siteOptionsLoggedIn = SiteOptions.GetAccountSiteOptions(intranetAccountID, siteOptionListLoggedIn);
		isAdmin = siteOptionsLoggedIn[Reliance.SiteOption._CanManageAllAccounts];
		isOfficeAdmin = siteOptionsLoggedIn[Reliance.SiteOption.CanManageOfficeAccounts];
		isOfficeGroupAdmin = siteOptionsLoggedIn[Reliance.SiteOption.CanManageOfficeGroupAccounts];
		websiteServiceProviderAccount = siteOptionsLoggedIn[Reliance.SiteOption._WebsiteServiceProvider];

		Reliance.RealEstate.AccountTree tree = new Reliance.RealEstate.AccountTree(id, true);
		if (tree[tree.OwnerSiteType] != null) {
			accountName = tree[tree.OwnerSiteType].Name;
		}
		cred = new WebSessionCredentials(id);
		brand = cred.Brand;
		companyID = cred.CompanyID;
		architecture = cred.Architecture;
		siteManagementStatus = cred.SiteManagementStatus;

		// get the company site options
		Reliance.SiteOptionList companySiteOptionList = new SiteOptionList();
		companySiteOptionList.Add(Reliance.SiteOption._UsesSandboxStructure);
		companySiteOptionList.Add(Reliance.SiteOption._WebsiteServiceProvider);
		companySiteOptionList.Add(Reliance.SiteOption._AdminOnlyUpgradeToPremiumSite);
		companySiteOptionList.Add(Reliance.SiteOption._UseDynamicNavigation);
		companySiteOptionList.Add(Reliance.SiteOption._HasCustomWebsite);
		SiteOptionDictionary companySiteOptions = SiteOptions.GetCompanySiteOptions(companyID, companySiteOptionList);
		companyUsesSandboxStructure = companySiteOptions[Reliance.SiteOption._UsesSandboxStructure];
		websiteServiceProviderCompany = companySiteOptions[Reliance.SiteOption._WebsiteServiceProvider];
		adminOnlyUpgradeToPremium = companySiteOptions[Reliance.SiteOption._AdminOnlyUpgradeToPremiumSite];
		HasCustomWebsite = companySiteOptions[Reliance.SiteOption._HasCustomWebsite];

		if (brand == RealEstateBrand.Remax) {
			// 6/1/13, JM: check for supportUrl.  If exists, link "Contact LeadStreet Support link to url.
			//	otherwise, open support contact popup.
			supportUrl = Reliance.Web.RemoteAccess.Intranet.GetSupportUrl(companyID);
		}

		//
		noSiteBuilderAccess = isBCard || !(isAgentSite || isTeamSite || isOfficeSite || (isOfficeGroupSite && !doesNotHaveWebsite)) || doesNotHaveSiteBuilder;
		// if this account has subscribed to premium services and somehow reached this page, we need to redirect them to the abbreviated page
		if (!websiteServiceProviderAccount && (websiteServiceProviderCompany && siteManagementStatus != SiteManagementStatus.Undefined && siteManagementStatus != SiteManagementStatus.Cancelled && siteManagementStatus != SiteManagementStatus.Pending)) {
			Response.Redirect("/modules/intranet/useredit/profilepage.asp?accountid=" + id);
		} else if (noSiteBuilderAccess) //IP-985 - redirect accounts with no sitebuilder access (may have landed here after drilling down)
		{
			Response.Redirect("/modules/intranet/sitebuilder/sitecontent.asp?accountid=" + id);
		}

		primaryAccountDomain = string.Concat(Uri.UriSchemeHttp, Uri.SchemeDelimiter, cred.PrimaryAccountDomain);

		WebsiteFramework.WebsiteConfiguration website = WebsiteFramework.WebsiteConfiguration.Get(companyID, id, ContentServer.Dynamic.TargetAccountFolder.Sandbox, cred.Architecture, cred.Brand);

		if (architecture == RealEstateArchitecture.RelianceNetwork) {
			prePackagedNav = "Preset Templates";
			designCenterNav = "Site Design";
			sandboxText = "sandbox";
			sandboxTextProper = "Sandbox";
		}
		//added on 8-31-11 to check if agent has a sandbox config file. If not, load Pre-Packaged Designs tab.	
		//also added 'tool=hp to Homepage Link and tool=d to design link.
		//*************************
		string tool = Request.QueryString["tool"];
		string selectedOption = Request.QueryString["opt"];
		FileInfo sandboxedConfig;
		Reliance.XmlTransform.XslParameters parameters = new XmlTransform.XslParameters();

		if (string.IsNullOrEmpty(tool)) // check for sandbox configuration file
		{
			sandboxedConfig = ContentServer.Dynamic.GetAccountWebsiteConfigurationFile(companyID, id, ContentServer.Dynamic.TargetAccountFolder.Sandbox, false);
			if (!sandboxedConfig.Exists) {
				//start on 'Pre-Packaged Designs' Tab
				ppSel = "Sel";
				dSel = string.Empty;
				xslt = "PrePackagedDesignTool";
			} else // start on 'Homepage Tab'
			{
				if (isMicrosite)
					xslt = "wireframeMicrositeTool";
				else
					xslt = "wireframeOutlineTool";

				hpSel = "Sel";
				dSel = string.Empty;
			}
		} else // use URL query string
		{
			switch (tool) {
				case "hp": // homepage
					hpSel = "Sel";
					dSel = string.Empty;

					if (isMicrosite)
						xslt = "wireframeMicrositeTool";
					else
						xslt = "wireframeOutlineTool";
					break;

				case "hd2":
					xslt = "websiteOutlineHeaderTool_bkp";
					hdSel = "Sel";
					dSel = string.Empty;
					break;

				case "pp":
					ppSel = "Sel";
					dSel = string.Empty;
					xslt = "PrePackagedDesignTool";
					break;

				case "hd":
					xslt = "websiteOutlineHeaderTool";
					parameters.Add("SelectedTool", "header");
					if (!string.IsNullOrEmpty(selectedOption)) {
						parameters.Add("SelectedOption", selectedOption);
					}

					doSel = "Sel";
					dSel = string.Empty;
					break;

				case "do":
					xslt = "websiteOutlineDisplayOptionsTool";
					doSel = "Sel";
					dSel = string.Empty;
					break;

				case "id":
					xslt = "websiteInfoDisplaySettingsTool";
					doSel = "Sel";
					dSel = string.Empty;
					break;

				case "d":
					xslt = "websiteOutlineDesignTool";
					parameters.Add("SelectedTool", "wallpaper");
					if (string.IsNullOrEmpty(selectedOption)) {
						if (website.WallpaperSettings.Color.Hex.ToString().Length == 0) {
							object[] atts = website.Wireframe.GetType().GetCustomAttributes(typeof(Reliance.Models.SupportedWallpaperOptionsAttribute), false);
							if (atts.Length > 0) {
								Reliance.Models.SupportedWallpaperOptionsAttribute att = (Reliance.Models.SupportedWallpaperOptionsAttribute) atts[0];
								if ((att.WallpaperOptions & Reliance.Models.WebsiteFrameworkWallpaperOption.ScenicImage) == Reliance.Models.WebsiteFrameworkWallpaperOption.ScenicImage)
									selectedOption = "scenic";
							}
						}

						if (string.IsNullOrEmpty(selectedOption))
							selectedOption = "color";
					}

					parameters.Add("SelectedOption", selectedOption);
					doSel = "Sel";
					break;

				case "nav":
					xslt = "websiteNavigation";
					parameters.Add("SelectedTool", "navigation");
					doSel = "Sel";
					break;

				default:
					xslt = "wireframeOutlineTool";
					hpSel = "Sel";
					dSel = string.Empty;
					break;
			}
		}

		//6-29-12, JM: Added isMicrosite parameter back in so that links would show/hide correctly upon load page load.
		//resolved issue where wireframetoollayout.xslt was looking for a true false value for isMicrosite but was getting nothing
		//on initial pageload.
		parameters.Add("isMicrosite", isMicrosite);

		parameters.Add("Static", ContentServer.Static.GetStaticUrl(ApplicationType.RealEstate));


		string xsltApplicationDirectory = brand == RealEstateBrand.Remax ? string.Concat("\\", architecture) : string.Empty;

		string xsltPath = string.Concat(ConfigurationManager.AppSettings["ContentServerPath"], "\\", ConfigurationManager.AppSettings["StaticContentFolder"], "\\", ConfigurationManager.AppSettings["XSLTIntranetMediaPath"], "\\", Reliance.IntranetCategory.SiteControls, xsltApplicationDirectory, "\\", xslt, ".xslt");

		try {
			markup = website.GetToolMarkup(xsltPath, parameters, showXml, siteDirectory);
		} catch (System.Xml.XmlException ex) {}

		if (HasCustomWebsite) {
			Reliance.DataAccess.BrokerData.SelectSiteManagementCode command = new Reliance.DataAccess.BrokerData.SelectSiteManagementCode(id);
			using(IDataReader reader = command.ExecuteReader()) {
				while (reader.Read()) {
					int.TryParse(reader["SiteManagementCode"].ToString(), out siteManagementCode);
				}
			}
		}
	} // Page_Load
</script>

<asp:Content ContentPlaceHolderID="Body" runat="server">
	<style>
		fieldset.preview legend { font-weight: bold; }
		fieldset.preview div { text-align: center; }
		ul.websiteOptions { list-style-type: disc; text-indent: 5px; list-style-position: inside; margin-top: 0px; }
		#layoutsection1, #layoutsection2, #layoutsection3, #layoutsection4 { width: 375px; border: #000 2px solid; position: relative; }
		a.infolink { text-decoration: underline; color: blue; }
		.loadingContainer { height: 40px; width: 200px; position: relative; }
		.loadingBGs { height: 40px; width: 200px; filter: alpha(opacity=80); position: absolute; background-color: #CCCCCC; z-index: 100; margin: 0px; top: 0; left: 0; }
		.loadingImg { position: absolute; width: 200px; z-index: 200; padding-top: 30px; top: 0; left: 0; }
		.loadingText { font-size: 10pt; font-weight: bold; color: #404040; }
		.progressbar { width: 100px; }
		.ui-widget-content { text-align: center; }
		.ui-progressbar { height: 1em; }
		.ui-progressbar-value { background-image: url('<%=mediaUrl%>intranet/sitebuilder/pbar-ani-sunny.gif') !important; }
		.gradientToWhite { position: absolute; display: block; z-index: 101; width: 200px; height: 50px; bottom: 0; left: 0; filter: progid:DXImageTransform.Microsoft.gradient( startColorStr=#00ffffff, endColorStr=#ffffff,GradientType=0); -ms-filter: progid:DXImageTransform.Microsoft.gradient(startColorStr=#00ffffff, endColorStr=#ffffff,GradientType=0); background-image: -webkit-linear-gradient(top, rgba(255, 255, 255, 0) 0%,rgba(255, 255, 255, 1) 100%); background-image: -moz-linear-gradient(center top, rgba(255, 255, 255, 0) 0%, rgba(255, 255, 255, 1) 100%); }
		/*BREEVES - 8/12/11 - COPIED THESE STYLES OUT OF PHOTOMANAGER.XSLT BECAUSE i ALSO NEEDED STYLES FOR THE COMPANY SETUP TOOL*/
		#overlayContent { border-top: 1px solid black; border-bottom: 1px solid black; overflow-y: auto; overflow-x: hidden; width: 100%; position: relative; padding-left: 10px; width: 99%; }
		#overlayContentHeader { padding-top: 5px; height: 30px; }
		#overlayContentFooter { padding-top: 5px; height: 20px; }
		.imageOption { width: 175px; padding: inherit 0; }
		span.note { color: #fff; }
		.terms-delete { padding: 4px 0; }
		.terms { padding: 5px 0; }
		.terms-overlay { position: absolute; top: 0px; left: 20px; }
		/*END PHOTOMANAGER.XSLT STYLES*/
		.tooloption { padding: 4px; float: left; cursor: pointer; border: #ffffff 1px solid; margin: 2px 0px 6px 0; width: 102px; background-color: #C0C0C0; text-align:center; }
		.tooloptionselected { background: #f8da51 no-repeat center bottom !important; border-color: orange; }
		.tooloptionheader { padding: 1px 4px 4px 4px; font-style: italic; }
		.subOption { cursor: pointer; border-top: 1px solid #FFFFFF; padding: 4px; }
		.textoption { padding: 2px; float: left; cursor: pointer; border: #CCCCCC 1px solid; margin: 2px; min-width: 50px; text-align: center; }
		.optionhover { background: #f8eaa7; cursor: pointer; }
		.optionselected { background: #f8da51 no-repeat center bottom !important; border-color: orange !important; }
		.option { padding: 10px 6px 14px; float: left; cursor: pointer; border: #CCCCCC 1px solid; margin: 2px 8px 6px 0; min-width: 46px; white-space: nowrap; text-align: center; }
		.ui-progressbar-value { background-image: url('<%=mediaUrl%>intranet/sitebuilder/pbar-ani-sunny.gif') !important; }
		.tooloptionselected { background: #f8da51 no-repeat center bottom !important; border-color: orange; }
		.subOptionSelected { background: #f8da51 no-repeat center bottom !important; border: 1px solid orange; }
		div.note { color: #666666; font-style: italic; }
		div#layoutsection3 div { width:136px; margin:0px auto; }
	   .package {margin:4px 10px 10px 0 !important;}
	</style>
	<script type="text/javascript" src="/scripts/reliance.jsx?id=<%=companyID%>"></script>
	
	<script type="text/javascript">
	    var versionCount = 0;
	    reliance.load('utilities');
	    var tempNode;
	    var tempElement;
	    var tempValue;
	
	    $(document).ready(function () {
	        var premiumStatus = <%=siteManagementCode%>;
			checkPreStatus(premiumStatus);
		});
	
	    function checkPreStatus(status){
	        var optionList = document.getElementById('slePremium');
	        switch(status) {
	            case 6:
	                optionList.selectedIndex = 0;
	                break;
	            case 3:
	                optionList.selectedIndex = 2;
	                break;
	            case 2:
	                optionList.selectedIndex = 1;
	                break;
	        }
	    }
	
	    function pulsateButton() {
	        var $publishedPreview = $('#publishedPreview');
	        var $body = $('body');
	        var mouseInPreviewSection;
	
	        $('#divHidePreview').show();
	
	        $publishedPreview.hover(function () {
	            mouseInPreviewSection = true;
	        }, function () {
	            mouseInPreviewSection = false;
	        });
	
	        var $btnShowPreview = $('#btnShowPreview');
	        for (trip = 0; trip < 3; trip++) {
	            $btnShowPreview.parent().animate({ "opacity": .5 }, { duration: 450 });
	            $btnShowPreview.parent().animate({ "opacity": 1 }, { duration: 450 });
	        }
	    }
	
	    function editText(intTypeID) {
	        var pageTextID = 'homepagetext';
	        switch(intTypeID) {
	            case 1:
	                /* do nothing */
	                break;
	            default:
	                pageTextID += intTypeID;
	                break;
	        }
	        reliance.utilities.setCookie('accounttheme', 'notheme');
	        document.location = '/modules/intranet/sitebuilder/SiteContent.EditPage.aspx?accountid=<%=id%>&pagetextid=' + pageTextID + '&return=sitebuilder%2Easpx%3F<%=Server.UrlEncode(Request.QueryString.ToString())%>';
	    }
	
	    function convertWebsite(id, value) {
	        if (confirm('              Are you sure you want to convert your site to the new format?\nOnce your site is converted, you will not be able to revert back to the previous design.')) {
	            showWaitScreen('Please wait while your website is converted.');
	            var data = 'companyid=<%=companyID%>&accountid=<%=id%>&intranetaccountid=<%=intranetAccountID%>&topic=siteoption&siteoptionid=' + id + '&value=' + value;		
	            callAjaxProcess(data, siteConverted);
	        }
	    }
	
	    function siteConverted() {
	        alert('Your <%=sandboxText%> is now published to your live site!');
	        document.location = document.location;
	    }
	
	    function confirmSandboxPublish() {
	        var selVersions = document.getElementById('selVersions');
	        var message = 'Are you sure you want to publish your <br/><%=sandboxText%> settings to your live site?';
	        addOverlay({ html: '<div style="position:relative; width:349px; height:149px;"><div style="padding:10px; "><br/><div style="font-size:10pt;font-weight:normal;">' + message + '</div><br/><div style="position:absolute; bottom:10px; left:22%"><input type="button"  onclick="closeOverlay();publishSandbox(); return false;" value="Yes" class="button" style="width:85px;" />&nbsp;&nbsp;<input type="button" onclick="closeOverlay();" value="Cancel" class="button" style="width:100px;" /></div></div></div>', width: 350, height: 150, canClose: true }, null);
	        return false;
	    }
	
	    function publishSandbox() {
	        showWaitScreen("Publishing your website.");
	        $.ajax({ url: 'ajaxprocess.aspx', data: 'companyid=<%=companyID%>&accountid=<%=id%>&intranetaccountid=<%=intranetAccountID%>&topic=publish', success: publishSandboxCallback, type: 'POST' });
	    }
	
	    function publishSandboxCallback() {
	        getSandboxVersionsHtml();
	        closeOverlay();
	    }
	
	    function resetSandbox() {
	        if (confirm('              Are you sure you would like to reset your <%=sandboxText%>?\n\nAll previous <%=sandboxText%> settings will be reset to match your current published site.')) {
	            showWaitScreen('Please wait while your <%=sandboxText%> is reset');
	            var data = 'companyid=<%=companyID%>&accountid=<%=id%>&value=true&intranetaccountid=<%=intranetAccountID%>&topic=reset&brnd=<%=brand.ToString()%>&arch=<%=architecture.ToString()%>';
	            callAjaxProcess(data, sandboxResetSuccess);		
	        }
	    }
	
	    function resetVersionSelect() {
	        var selVersions = document.getElementById('selVersions');
	        if(selVersions.options.length == 0)
	            return;
	
	        selVersions.options[0].selected = true;
	    }
	
	    function getSandboxVersionsHtml() {
	        var data = 'companyid=<%=companyID%>&accountid=<%=id%>&intranetaccountid=<%=intranetAccountID%>';
	        $.ajax('SandboxVersions.aspx', { data: data, success: sandboxVersionsHtmlSuccess, cache: false });
	    }
	
	    function sandboxVersionsHtmlSuccess(response) {
	        response = $.parseJSON(response);
	        versionCount = response.versionCount;
	        if (versionCount > 0) {
	            $('#divVersions').show();
	            $('#lblVersion').html(' - V.' + versionCount);
	            $('#selDivVersion').html(response.bodyMarkup);
	        }
	
	    }
	
	    function getSandboxVersion(version) {
	
	        showWaitScreen('Please wait while your <%=sandboxText%> is reset to: <br/><br/><div style="text-align:center; font-weight:bold;">' + $('#selVersions option[value=\'' + version + '\']').text() + '</div>');
	
	        var data = 'companyid=<%=companyID%>&accountid=<%=id%>&value=true&intranetaccountid=<%=intranetAccountID%>&topic=version&version=' + version + '&brnd=<%=brand.ToString()%>&arch=<%=architecture.ToString()%>';
	        callAjaxProcess(data, sandboxVersionSuccess);
	    }
	
		function verifyVersion() { // SN: 95183 - added a friendly warning message if there is no published version to load to preview. If it loaded successfully, then click Preview to see the page layout
	    var version = jQuery("#selVersions :selected");
	    if (version.text() === "") {
	        var message = "Please select a published version to load to preview.";
	        addOverlay({ html: '<div style="position:relative; width:399px; height:90px;"><div style="padding:10px; "><br/><div style="font-size:10pt;font-weight:normal;">' + message + '</div><br/><div style="position:absolute; bottom:10px; left:40%"><input type="button"  onclick="closeOverlay();" value="OK" class="button" style="width:85px;" /></div></div></div>', width: 400, height: 100, canClose: true }, null);
	    } else {
	        confirmSandboxChange(version.val());
	    }
	}
		
	    function confirmSandboxChange(version) {
	        var message;
	        var selVersions = document.getElementById('selVersions');
		
	        message = '<div style="font-weight:bold;" >' + $('#selVersions option[value=\'' + version + '\']').text() + '</div> will be applied to your <%=sandboxText%> for review.  <br/>Would you like to continue?';
	
	        addOverlay({ html: '<div style="position:relative; width:399px; height:149px;"><div style="padding:10px; "><br/><div style="font-size:10pt;font-weight:normal;">' + message + '</div><br/><div style="position:absolute; bottom:10px; left:25%"><input type="button"  onclick="closeOverlay();getSandboxVersion(' + version + '); return false;" value="Yes" class="button" style="width:85px;" />&nbsp;&nbsp;<input type="button" onclick="closeOverlay();" value="Cancel" class="button" style="width:100px;" /></div></div></div>', width: 400, height: 150, canClose: true }, null);
	
	        return false;
	    }
	
	    function sandboxVersionSuccess(response) {
	        closeOverlay();
	        response = $.parseJSON(response);
	        updateWireframe($('#div' + response.wireframeType), 'wireframe', response.wireframeType, true)
	        onWireframeSuccess(response.markup);
	    }
	
	    function sandboxResetSuccess(response) {
	        alert('Your <%=sandboxText%> has been successfully reset to your published site settings.');
	        closeOverlay();
	
	        response = $.parseJSON(response);
	        updateWireframe($('#div' + response.wireframeType), 'wireframe', response.wireframeType, true)
	        onWireframeSuccess(response.markup);
	    }
	
	    function updateWireframe(node, element, value, skipAjaxProcess) {
	        tempNode = node;
	        tempElement = element;
	        tempValue = value;
	
	        if (!skipAjaxProcess) {
	            var message = 'The \"' + node.innerHTML + '\" ' + element + ' will be applied to your <%=sandboxText%> for your review. Would you like to continue?'
	            addOverlay({ html: '<div style="position:relative; width:auto; height:160px;"><div style="padding:10px; "><br/><div style="font-size:10pt;font-weight:normal;">' + message + '</div><br/><div style="position:absolute; bottom:10px; left:25%"><input id="confirmWireframeChange" type="button"  value="Yes" class="button" style="width:85px;" />&nbsp;&nbsp;<input type="button" id="processCancel" value="Cancel" class="button" style="width:100px;" /></div></div></div>', width: 400, height: 150, canClose: true }, null);
	        }
	        else {
	            $('input[name=' + element + ']').val(value);
	            var selectedOptions = $('#' + element + 's .optionselected');
	            for (var i = 0; i < selectedOptions.length; i++) {
	                $(selectedOptions[i]).toggleClass('optionselected');
	            }
	            $(node).toggleClass('optionselected');
	            if ('<%=xslt%>' == 'wireframeOutlineTool')
	                toggleWireframeTool('home');
	        }
	    }
	
	    function runWireframeAjaxFromID(id, element, value) {
	        runWireframeAjax(document.getElementById(id), element, value);
	    }
	
	    function runWireframeAjax(node, element, value) {
	        showWaitScreen('Updating <%=sandboxText%>');
	        $('input[name=' + element + ']').val(value);
	        var selectedOptions = $('#' + element + 's .optionselected');
	
	        for (var i = 0; i < selectedOptions.length; i++) {
	            $(selectedOptions[i]).toggleClass('optionselected');
	        }
	
	        $(node).toggleClass('optionselected');
	        var data = 'companyid=<%=companyID%>&accountid=<%=id%>&intranetaccountid=<%=intranetAccountID%>&topic=' + element.replace(/s$/i, '') + '&value=' + value + '&lbl=' + value + '&brnd=<%=brand.ToString()%>&arch=<%=architecture.ToString()%>';
	        $.ajax('ajaxprocess.aspx', { data: data, success: onWireframeSuccess, type: 'POST' });
	    }
	
	    function onWireframeSuccess(response) {
	        closeOverlay();
	        if ('<%=xslt%>' == 'wireframeOutlineTool') {
	            $('#customizeWireframe').html(response);
	            toggleWireframeTool('home');
	        }
	    }
	
	    function callAjaxProcess(data, onSuccess, context) {
	        var opts = { data: data, success: onSuccess, type: 'POST' };
	        if (context)
	            opts.context = context;
	        $.ajax('ajaxprocess.aspx', opts);
	    }
	    /* code for overlays --> needs to be put into a js file, likely with a bunch of other functions as well */
	    var div1;
	
	    function addOverlay(opts, adjustment) {
	        var dynamicNav = 'true';
		
	        opts.padding = 0;
	
	        var html = opts.html || '';
	        var padding = opts.padding;
	        var borderWidth = getBorderWidth();
	        var canClose = opts.canClose || false;
	
	        var z = measureWidth(opts);
	        var width = z.width;
	        var height = z.height;
	        var left = z.left;
	        var top = z.top;
	
	        div1 = $('<div/>').css({ position: 'fixed', width: '100%', height: $(document).height(), scroll: 'hidden', left: '0', top: '0', zIndex: '1000' });
	        var uiOverlay = $('<div/>').attr('class', 'ui-overlay').appendTo(div1);
	        var uiWidgetOverlay = $('<div/>').attr('class', 'ui-widget-overlay').appendTo(uiOverlay);
	        var uiWidgetShadow = $('<div/>').attr('class', 'ui-widget-shadow ui-corner-all').css({ width: (width + 15) + 'px', height: (height +15) + 'px', position: 'absolute', left: (left) + 'px', top: (top) + 'px' }).appendTo(uiOverlay); //added 15px to width/height for CRM support
	        var div2;
	        if (dynamicNav != null && dynamicNav.toLowerCase() == 'true') {
	            div2 = $('<div/>').attr('class', 'ui-widget ui-widget-content ui-corner-all').css({ background: '#e5e5e5', position: 'absolute', width: (width - (padding * 2) - borderWidth) + 'px', height: (height - (padding * 2) - borderWidth) + 'px', left: left + 'px', top: top + 'px', padding: padding + 'px', overflow: 'auto' }).appendTo(div1).html(html);
	        }
	        else {
	            div2 = $('<div/>').attr('class', 'ui-widget ui-widget-content ui-corner-all').css({ position: 'absolute', width: (width - (padding * 2) - borderWidth) + 'px', height: (height - (padding * 2) - borderWidth) + 'px', left: left + 'px', top: top + 'px', padding: padding + 'px', overflow: 'auto' }).appendTo(div1).html(html);
	        }
	        if (canClose) {
	            var close = $('<div/>').attr('class', 'ui-icon ui-icon-circle-close').css({ position: 'absolute', right: '0px', top: '0px', zIndex: 1001, width: '16px', height: '16px', cursor: 'pointer' }).appendTo(div2);
	            close.click(closeOverlay);
	        }
	
	        div1.appendTo('body');
	
	        if ($('#overlayContent').length) {
	            var headerFooterHeight = $('#overlayContentHeader').height() + $('#overlayContentFooter').height();
	            $('#overlayContent').height(div2.height() - headerFooterHeight - adjustment);
	        }
	    
	        //$('#overlayProgressBar').progressbar({
	        //    value: 100
	        //});
	
	        $('#processCancel').click(function(){
	            closeOverlay();
	        });
	    
	        $('#confirmWireframeChange').click(function(){
	            closeOverlay();
	            runWireframeAjaxFromID(tempNode.id, tempElement , tempValue);	    
	            return false;
	        });
	    } 
	
	    function getBorderWidth(includeMargin) {
	        var margin = 0;
	        if (includeMargin) {
	            var shadowDiv = $('<div/>').attr('class', 'ui-widget-shadow ui-corner-all').css({ width: '20px', height: '20px', position: 'absolute' }).appendTo('body');
	            margin = Math.abs(parseInt(shadowDiv.css('marginLeft')))
	            shadowDiv.remove();
	        }
	        var overlayDiv = $('<div/>').attr('class', 'ui-widget ui-widget-content ui-corner-all').css({ position: 'absolute', left: 0, top: 0 }).appendTo('body');
	        var borderWidth = margin + parseInt(overlayDiv.css('borderLeftWidth'));
	        overlayDiv.remove();
	        return borderWidth;
	    }
	
	    function measureWidth(opts) {
	        var html = opts.html || '';
	        var div2 = $('<div/>').attr('class', 'ui-widget ui-widget-content ui-corner-all').css({ position: 'absolute', left: 0, top: 0, padding: opts.padding + 'px' }).appendTo('body').html(html);
	
	        var borderWidth = getBorderWidth(true);
	        var buffer = 20;
	        var totalBuffer = (borderWidth + buffer) * 2;	
	        var doc = $('html');	
	
	        doc.height('100%');
	
	        /* measure width */
	        var width = opts.width || div2.innerWidth();
	        var docWidth = doc.outerWidth();
	        var maxWidth = docWidth - totalBuffer;
	        if (width > maxWidth)
	            width = maxWidth;
	
	        div2.css('width', width + 'px');
	
	        /* measure height */
	        var height = opts.height || div2.outerHeight();
	        var docHeight = doc.outerHeight();
	        var maxHeight = docHeight - totalBuffer;
	        if (height > maxHeight)
	            height = maxHeight;
	
	        /* calculate left */
	        var left = opts.left
	        if (left == undefined || width == maxWidth)
	            left = 'center';
	
	        if (left == 'center')
	            left = Math.abs((docWidth - width) / 2);
	
	        left = Math.max(borderWidth, left);
	
	        /* calculate top */
	        var top = opts.top;
	        if (top == undefined || height == maxHeight)
	            top = 'middle';
	
	        if (top == 'middle')
	            top = Math.abs((height - docHeight) / 2);
	
	        top = Math.max(borderWidth, top);
	
	        div2.remove();
	
	        return { width: width, height: height, left: left, top: top };
	    }
	
	    function closeOverlay() {
	        /* fix for IE8 bug when removing divSavedContent (in div1) containing iframe (i.e. youtube).
		must hide iframe first, then remove (#53852) */
	        var divSavedContent = $('#divSavedContent');
	        if (divSavedContent.length > 0) {
	            try {
	                divSavedContent.find($('iframe')).hide();
	            } catch (e) { }
	        }
	
	        if ($('#editor').length > 0) {
	            try {
	                $('#editor').empty();
	                tinymce.EditorManager.execCommand('mceRemoveControl', true, 'markup');
	            } catch (e) { }
	        }
	
	        if (div1) 
	            div1.remove();
		
	    }
	
	    function showWaitScreen(msg) {
	        addOverlay({ html: '<div><br/><br/><span style="font-size:10pt;font-weight:bold;color:#404040;">' + msg + '</span><br/><br/><div align="center"><div id="overlayProgressBar" class="progressbar"></div></div></div>', width: 350, height: 150 }, null);
	    }
	
	    function showErrorScreen(msg) {
	        addOverlay({ html: '<div><br/><br/><span style="font-size:10pt;font-weight:bold;color:#FF0000;">' + msg + '</span><br/><br/><div style="position:absolute; bottom:10px; left:149px;"><input type="button" value="Close" onclick="closeOverlay()" /></div></div>', width: 350, height: 150, canClose: true }, null);
	    }
	
	    function subToggleHover(node) {
	        $(node).toggleClass('optionhover');
	    }
	
	    function signUp() {
	        window.open('/intranet/sitebuilder/RealLeadsSSO.aspx?acc=<%=id%>&iacc=<%=intranetAccountID%>', 'realleads', 'resizable=1,scrollbars=1');
	    }
	
	    function confirmPremiumOption() {
	        var _option = document.getElementById('slePremium');
	        if (_option != null && _option.selectedIndex > -1) {
	            var preSelected = _option[_option.selectedIndex].value.trim();
	            if (preSelected.length > 0 || preSelected != "") {
	                setPremiumOption(preSelected);
	            }
	        }
	    }
	
	    function reloadSandboxPreview() {
	        /*TEMPORARY: COMMENT OUT ALL SCREENSHOT CODE TO REMEDY CPU ISSUES - 4/18/12
		document.getElementById('sandboxLoaderBg').style.display = 'block';
		document.getElementById('sandboxLoader').style.display = 'block';
		$("#sandboxPreview").attr("src", "/modules/intranet/sitebuilder/screenshot.aspx?id=<%=id%>&view=Sandbox&w=200&h=140&d=" + (new Date())).load(sandboxPreviewLoaded);
		*/
	    }
	
	    function sandboxPreviewLoaded() {
	        document.getElementById('sandboxLoaderBg').style.display = 'none';
	        document.getElementById('sandboxLoader').style.display = 'none';
	    }
	
	    function setPremiumOption(option) {
	        if (option != null && option.length > 0) {
	            var data = 'premiumoption=' + option + '&accountid=' + '<%=id%>';
	            $.ajax({
	                url: 'updatePremiumOption.aspx',
	                data: data,
	                success: function (response) {
	                    alert('Premium Site Tools for ' + '<%=accountName.Replace("'", "\\'")%>' + ' is now ' + response);
	                },
	                error: function () {
	                    alert('There was an error updating the account');
	                }
	            });
	            }
	        }
	</script>

	<style>
	    div#spinner{
			background: #ffffff;
			text-align: center;
	
			height: 100%;
			padding-top: 33%;
	        width:100%;
	
	        position: fixed;
	        top: 0;
	        left: 0;
	        z-index:2;
	        overflow: auto;
	    }
	</style>
	<div id="spinner">
	    <img src="../images/ajax-loader.gif" alt="Loading..."/>
	</div>
	<script src="/crm3/js/reset.min.js"></script>
	<script src ="http://cdnjs.cloudflare.com/ajax/libs/foundation/6.2.3/foundation.min.js"></script>
	<script>$(document).foundation();</script>

	<section class="crm-site-content" id="sitebuilderContent">
		<div class="crm-page-content">
			<div id="divShowPreview" class="hide">
				<input id='btnShowPreview' class='button' type='button' onclick='javscript:togglePreview("publishedPreview");' value='Show Preview'>
			</div>
			
            <section class="crm-page-section" id="divMarkup">
				<div class="crm-page-section-main">
					<%=markup%>
				</div>
				
				<aside class="crm-page-section-sidebar thin" id="publishedPreview">
					<div class="crm-page-section-sidebar-content">
						<% if (websiteServiceProviderCompany && (siteManagementStatus == SiteManagementStatus.Undefined || siteManagementStatus == SiteManagementStatus.Cancelled) && (!adminOnlyUpgradeToPremium || (adminOnlyUpgradeToPremium && isAdmin))) {%>
							<p>Do you want to enhance your online presence with a custom design, an SEO strategy, full-service support, and more?  Check out Premier Service by real.leads by clicking the “Learn More” button below.”</p>
							<input class="button" type="button" onclick="signUp();" value="Learn More About Premier Service">
							<hr>
						<% } else if (websiteServiceProviderCompany && (!adminOnlyUpgradeToPremium || (adminOnlyUpgradeToPremium && isAdmin))) { %>
							<p>Sign in here to manage your real.leads Premier Service Account</p>
							<input class="button" type="button" onclick="signUp();" value="Manage Premier Service Account">
							<hr>
						<% } else if (HasCustomWebsite && isAdmin ) { %>
                            <label>Enable Custom Website
                                <select id="slePremium" style="font-size:12px;">
                                    <option value="inactive">Custom Site Not Enabled</option>
                                    <option value="inprocess">In Preview</option>
                                    <option value="active"> Custom Site Enabled</option>                                          
                                </select>
                            </label>
                            <input type="button" onclick="confirmPremiumOption(); return false;" value="Submit" class="button">
                            <hr>
                        <% } %>
                        
						<% if (!accountUsesSandboxStructure) {%>
							<h4>Convert from Old to New Website</h4>
							<p>Within the allowed limit, you pick when you wish to convert from your current (old) website to the new website.</p>
							<p>Using the "Sandbox" you can customize the new website prior to "publishing" (going live).</p>
							<input type="button" onclick="javascript:convertWebsite(239, true);" value="Convert to New Website Now" class="button">
							<hr>
						<% } else { %>
							<p>My Published Website</p>
							<span id="lblVersion"></span>
							<hr>
						<% } %>
						
						<% if (accountUsesSandboxStructure) { %>
							<input type="button" onclick="window.open('<%=primaryAccountDomain%>');" value="View Live Website" class="button">
							<hr>
						<% } %>
							<p><%=sandboxTextProper%></p>
							<input type="button" onclick="window.open('/modules/intranet/sitebuilder/sandbox.aspx?id=<%=id%>');" value="Preview" class="button"> <input type="button" onclick="confirmSandboxPublish();return false;" value="Publish" class="button">
							<hr>
							<div id="divVersions" style="display: none;">
								<h4>Previously Published Versions</h4>
								<div id="selDivVersion">
									<script type="text/javascript">getSandboxVersionsHtml();</script>
								</div>
								<input type="button" class="button" value="Load to Preview" onclick="verifyVersion();">
								<p><small>Up to seven previous versions are saved</small></p>
							</div>
							<hr>
						<% if (brand==RealEstateBrand.Remax) { %>
							<ul class="crm-page-section-sidebar-content-icon-list">
								<li class="attention">	
									<%if (!string.IsNullOrEmpty(supportUrl)) { %>
										<a href="<%=supportUrl%>" target="_blank">Contact LeadStreet Support</a>
									<%} else {%>
										<a href="javascript:void(0);" onclick="javascript:window.open('/intranet/SupportEmail.aspx?accountid=<%=id%>&subject=My Published Website', 'ContactSupport', 'toolbar=no,width=800,height=300,status=no,scrollbars=no,resizable=yes,menubar=no');">Contact LeadStreet Support</a>
									<%} %>
								</li>
							</ul>
						<% } %>
					</div>
				</aside>
            </section>
		</div>
	</section>
	
	<%
	string onlineAgreement = "onlineagreement_text.asp";
	if (companyID == 62)
		onlineAgreement = "onlineagreement_text_company62.asp";
	%>
</asp:Content>

