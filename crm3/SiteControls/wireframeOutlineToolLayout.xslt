<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	<xsl:output method="html" indent="yes"/>

	<xsl:param name="IntranetAccountID"/>
	<xsl:param name="StaticUrl" />
    <xsl:param name="Static" />

	<xsl:include href="wireframeOutlineToolLayout.xslt"/>
	<xsl:include href="skinLayoutOptions.xslt"/>
	
	<xsl:template match="xml">
		<xsl:variable name="SkinSectionTitle">
			<xsl:choose>
				<xsl:when test="websiteConfiguration/contentID = 311">
					<xsl:value-of select="'Homepage Wireframes'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Skin Layouts'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="LayoutOrWireframe">
			<xsl:choose>
				<xsl:when test="websiteConfiguration/contentID = 311">
					<xsl:value-of select="'Wireframe'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Layout'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<style>
			.ui-widget {font-family:inherit; font-size:inherit;}
			.ui-widget input, .ui-widget select, .ui-widget textarea, .ui-widget button {font-family:inherit; }
			#section1, #section2, #section3, #section4 { float:left; clear:both; margin-top:2px }
			#container { width:700px; margin:0 auto }
			#layoutsection1 { overflow:hidden }
			#wrapper { border:#000 2px solid; margin-right:10px; float:left; width:375px; position:relative; }
			.option { padding:10px 6px 14px; float:left; cursor:pointer; border:#CCCCCC 1px solid; margin:2px 8px 6px 0; min-width:46px; white-space:nowrap; text-align:center }
			.optionhover { background:#f8eaa7 }
			.optionselected { background: #f8da51 no-repeat center bottom !important; border-color:orange }
			.rules{color: #777777; font-style: italic;}
			.section { border:#000 2px solid; position:relative; background-color:#fff }

			.quickSearchPhoto, .quickSearchMap, .fpCarosel, .text, .callout, .profile { position:relative }

			.quickSearchPhoto { height:140px }
			.quickSearchPhoto > div { height:49px; background:url(<xsl:value-of select="$StaticUrl" />realestate/website/intranet/sitebuilder/wireframesprite.png) no-repeat center -133px; position:absolute; width:100%; bottom:0 }
			.quickSearchPhotoOption { height:144px }

			.quickSearchMap {height:100px}
			.quickSearchMap > div { height:87px;  }
			.quickSearchMapOption { height:104px }

			.fpCarosel { height:80px }
			.fpCarosel > div { height:66px; background:url(<xsl:value-of select="$StaticUrl" />realestate/website/intranet/sitebuilder/wireframesprite.png) no-repeat; position:relative; top:7px }
			.fpCaroselOption { height:84px }

			.text { height:65px }
			.text > div { height:40px; background:url(<xsl:value-of select="$StaticUrl" />realestate/website/intranet/sitebuilder/wireframesprite.png) no-repeat center -182px; position:relative; top:13px }
			.textOption { height:69px }
			#divWarning { font-weight: bold; padding-bottom:10px;}

			.callout { height:80px }
			.callout > div { height:67px; background:url(<xsl:value-of select="$StaticUrl" />realestate/website/intranet/sitebuilder/wireframesprite.png) no-repeat center -66px; position:relative; top:7px }
			.calloutOption { height:84px }

			.profile { height:125px }
			.profile > div { height:112px;  }
			.profileOption { height:129px }

			#customizeWireframe input[type=radio] { position:absolute; left:0; top:-.4em; }
			.moduleTypeOption { padding-left:2em; position:relative; margin:.3em 0 }
			.section {width:375px; float:left }
			.col0 > div > div:first-child, .col1 > div > div:first-child { width:220px; float:left }

			.Wireframe04 .col0, .Wireframe04 .col1 { width:315px !important; float:left }
			.Wireframe04 .col1 > div > div:first-child { float:right }
			.Wireframe04 .col0 > div > div:first-child { width:130px; }
			.Wireframe04 .col1 > div > div:first-child { width:170px; }
			.Wireframe04 .col0 .section { width:170px !important;}
			.Wireframe04 .col1 .section { width:130px !important;}
			.Wireframe04 .col0 .section { float:right; }
			.Wireframe04 #layoutsection5 { height:154px; }
		</style>
		
		<script type="text/javascript" src="/scripts/reliance.jsx?id={websiteConfiguration/contentID}"></script>
    <script type="text/javascript" src="/modules/intranet/global/RTE/tinymce_update/js/tinymce/tinymce.min.js"></script>
		<script>
			reliance.load('xDomainHttpRequest');
			reliance.load('googleMapsForEnterprise');
			reliance.load('mapping', {mode:'Localization'});
			
			var savedMessagePageID = 0;
			var origOverlayHeight;
			var origOverlayShadowHeight;
			var layoutOrWireframe = '<xsl:value-of select="$LayoutOrWireframe"/>';
			layoutOrWireframe = layoutOrWireframe.toLowerCase()
			
			function ajaxProcessComplete() {
			document.getElementById('wireframeOverlayDiv').style.display = 'none';
			}
							
			function activateEditor(pageID, markup) {
				var id = "markup";

				if ($('#' + id).length > 0)
					return;

				$('<textarea/>').attr('id', id).css({ width: '100%', height: '325px'}).val(markup).appendTo('#editor');

      applyEditor(id, pageID, markup);
      }

      function applyEditor(textAreaID, pageID, markup) {
        var plugins = ["advlist autolink lists link image charmap print preview hr anchor pagebreak spellchecker searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking save table contextmenu directionality emoticons template paste textcolor versionselector imagelibrary colorpicker"];

        var tinyMCEopts = {
          selector: 'textarea',
          theme: "modern",
          menubar: false,
          statusbar: false,
          height: 300,
          width: 950,
          toolbar_items_size: "small",
          force_br_newlines: true,
          force_p_newlines: false,
          plugins: plugins,
          paste_text_sticky : true,
          paste_text_sticky_default: true,
          valid_children: "+body[style|script]",
          extended_valid_elements : "a[title|onclick|href|hreflang|media|rel|target|type|id|class|fb|pi|style],input[name|value|type|onclick|alt|src|onClick],param[name|value],embed[src|type|wmode|width|height],object[classid|codebase|width|height],img[id|class|src|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|style|usemap|orgWidth|orgHeight],div[align|onclick|id|class|style|script|param_vanity_key|param_config],script[charset|defer|language|src|type|async],area[alt|title|target|onclick|coords|shape|href|style|download|media|rel|hreflang|type|onmouseover|onmouseout]",
          toolbar1: "bold italic underline strikethrough superscript subscript | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent  | forecolor | backcolor | fontselect | fontsizeselect",
          toolbar2: "preview | insertfile undo redo | cut copy paste | hr pagebreak searchreplace | blockquote charmap visualchars anchor nonbreaking media | link | code | styleselect paragraph",
          toolbar3: "versionselector | imagelibrary",
          browser_spellcheck : true,
          convert_urls: false
        }

        tinymce.init(tinyMCEopts);
      }

      function setMap(map, pMapType, pLat, pLng, pZoom) {
      map.addMapType(G_HYBRID_MAP);
      map.addMapType(G_PHYSICAL_MAP);

      if(pLat !=0 &amp;&amp; pLng != 0) {
					var g_MapType;
					
					switch(pMapType) {			
						case 'roadmap':
						case 'map':
							g_MapType = G_NORMAL_MAP;
						break;
						case 'satellite':
							g_MapType = G_SATELLITE_MAP;
						break;
						case 'hybrid':
							g_MapType = G_HYBRID_MAP;
						break;
						case 'terrain':
							g_MapType = G_PHYSICAL_MAP;
						break;	
					}
			
				map.setCenter(new GLatLng(pLat, pLng), pZoom);
				map.setMapType(g_MapType);
				}
			}

			function saveMap(module, pageID, index, type, lat, lng, zoom, nlat, slat, elng, wlng) {
						
				var data = 'companyID=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountID=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;pageID=' + pageID + '&amp;index=' + index + '&amp;intranetAccountID=<xsl:value-of select="$IntranetAccountID"/>&amp;type='+ type + '&amp;lat=' + lat + '&amp;lng=' + lng + '&amp;zoom=' + zoom + '&amp;nlat=' + nlat + '&amp;slat=' + slat + '&amp;elng=' + elng + '&amp;wlng=' + wlng;
				$.ajax({url:'/modules/intranet/SiteBuilder/MapManagerSave.aspx', data:data, type:'POST', success:function(xml){onSubmitSuccess(xml, module);}, error:function(xml){onSubmitFail(xml, index, module);}});				
			}
			
			function addHighlight(node) {
				$('#layout' + node.id).css({borderColor:'orange', backgroundColor:'#f8da51'});
			}

			function removeHighlight(node) {
				$('#layout' + node.id).css({borderColor:'', backgroundColor:''});
			}

		

			function updateSection(node, key, section, className, element, value) {
			//alert('node: ' + node + ', key: ' + key + ', section: '+ section + ', className: ' + className + ', element: ' + element + ', value: ' + value);

				var jnode = $(node);
				jnode.nextAll('a').css({visibility:'visible'})
				if(className != 'hidden')
					jnode.parent().parent().parent().parent().parent().attr('class', className + 'Option');
						
				var inputs = jnode.parent().parent().children('div').children('input');
				for (var i = 0; i &lt; inputs.length; i++) {
					if (inputs[i] == node)
					continue;
					$(inputs[i]).nextAll('a').css({visibility:'hidden'});
				}
				
			
				if(className != 'hidden')
					$('#layoutsection' + section).attr('class', 'section ' + className);

				topic = element.replace(/s$/i, '')
				var data; 
								
				if(key == 'WireframeFeaturedPropertiesCarouselModule'){
					showWaitScreen("Loading \'Featured Property\' settings.");
					data = 'companyid=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountID=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;index=' +  (section - 1) +  '&amp;intranetAccountID=<xsl:value-of select="$IntranetAccountID"/>';
					$.ajax({url:'/modules/intranet/SiteBuilder/FeaturedPropertiesToolProcessingPage.aspx', data:data, success:onFPCarouselSuccess, type:'GET'});
					}
				else {
					data = 'companyid=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountid=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;intranetaccountid=<xsl:value-of select="$IntranetAccountID"/>&amp;topic=' + topic + '&amp;value=' + value + '&amp;index=' +  (section - 1) + '&amp;moduleType=' + key;
					$.ajax('ajaxprocess.aspx', {data:data, error:updateSectionError, success:onSuccess, type:'POST'});
					}
			}
			

			function updateSectionError(response){
				if(response == 'wireframeModule'){
					var keyValuePairs = this.data.split('&amp;');
					var index;
					var moduleType;
					for (var i = 0; i &lt; keyValuePairs.length; i++) {
						var parts = keyValuePairs[i].split('=');
						if (parts[0] == 'index') {
							index = parts[1];
							continue;
						} else if(parts[0].toLowerCase() == 'moduletype') {
							moduleType = parts[1];
							continue;
						}
					}
				}else if(response == 'wireframeHideSection') {
					//need to add code to undo the 'hidden' check because there was an error
				}
				alert('There was an error processing the request, ' + index + ' -- ' + response.responseText);
				//showErrorScreen('There was an error processing the request.  Please try again.');
			}

			function updateOption(node, element, value) {
				if (arguments[0].data){
					var data = arguments[0].data;
					node = data.node;
					element = data.element;
					value = data.value;
				}

				if (!confirmChange(element))
					return;

				$('input[name=' + element + ']').val(value);
				var selectedOptions = $('#' + element + 's .optionselected');

				for (var i = 0; i &lt; selectedOptions.length; i++) {
					$(selectedOptions[i]).toggleClass('optionselected');
				}
				$(node).toggleClass('optionselected');
				if(element == 'skin') {
					updateSkin(element.replace(/s$/i, ''), value);
				}else{
					submitChange(element.replace(/s$/i, ''), value);
				//	submitChange(element.replace(/s$/i, ''), value);
				}

				if (element != 'skin')
					return;
			}

			function submitChange(topic, value) {
				var data = 'companyid=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountid=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;intranetaccountid=<xsl:value-of select="$IntranetAccountID"/>&amp;topic=' + topic + '&amp;value=' + value + '&amp;lbl=' + value + '&amp;brnd=Prudential&amp;arch=RelianceNetwork';
				//_alert(topic + '\n' + value);
				$.ajax('ajaxprocess.aspx', {data:data, success:onSuccess, type:'POST'});
			}

			function updateSkin(topic, value) {
				var data = 'companyid=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountid=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;intranetaccountid=<xsl:value-of select="$IntranetAccountID"/>&amp;topic=' + topic + '&amp;value=' + value + '&amp;lbl=' + value + '&amp;brnd=Prudential&amp;arch=RelianceNetwork';
				//_alert(topic + '\n' + value);
				$.ajax('ajaxprocess.aspx', {data:data, success:onSkinUpdateSuccess, type:'POST'});
			}

			function onSkinUpdateSuccess(response) {
				closeOverlay();
				response = $.parseJSON(response);
				$('#wireframes').html(response.html);
				runWireframeAjax(document.getElementById('div' + response.primaryWireframe), 'wireframe', response.primaryWireframe);
			}

			function confirmChange(element) {
				if (element == 'skin')
					if (!confirm('By changing your skin selection, your current skin and ' + layoutOrWireframe + ' website previewer settings will be cleared.\n\nWould you like to continue?')) 
						return false;

				if ($($('#recommended').children('label')).children('.optionselected').length > 0 &amp;&amp; !confirm('This action will remove your current header image selection'))
					return false;

				return true;
			}

			function getSavedMsg(pageTextID, version, obj) {			
				if(pageTextID != savedMessagePageID || $('#divSavedContentOpts').length > 0) {
					if(pageTextID != savedMessagePageID) {
						savedMessagePageID = pageTextID;
					}
													
					if(pageTextID != '0' &amp;&amp; pageTextID !== undefined) {
						var data = 'pageTextID=' + pageTextID + '&amp;accountID=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;companyID=<xsl:value-of select="websiteConfiguration/contentID"/>';
						
						//if($('#selCompanyContentLinks').length > 0) {
										
						if($('#divCompanyContent').length > 0) {
							data += '&amp;type=company';
							
							if(version > 0)
								data += '&amp;version=' + version;
						}
						else if($('#divCustomContent').length > 0) {
							data += '&amp;type=customSaved';
						}
						else {
							data += '&amp;type=custom';
							var iframe=document.getElementById('markup_ifr');
							$(iframe.contentWindow.document.body).empty();
						}
						
						var noCache = Math.random();
						data +='&amp;noCache=' + noCache;
						
						$.ajax({url:'/modules/intranet/SiteBuilder/TextEditorContent.aspx', data:data, dataType:'html', success:function(xml){getSavedMsgSuccess(xml, obj);}, error:function(xml){onFail(xml, id, module);}});
					}
					else{
						//if($('#selCompanyContentLinks').length > 0)
						if($('#divCompanyContent').length > 0 &amp;&amp; $('#divSavedContentOpts').length > 0) 
							$('#selCompanyContentVersions').html('&lt;option value=\'10\'>----------&lt;/option>');
						
						$('#selCompanyContentVersions').attr('disabled', true);
						$('#divSavedContent').html('');					
					}
				}
			}

			function getSavedMsgSuccess(response, obj) {
				response = $.parseJSON(response);
															
			if($('#divSavedContentOpts').length > 0) {
										
					if(response.versions !== undefined) {
					
					$('#selCompanyContentVersions').prop('onchange', null);
						$('#selCompanyContentVersions').html(response.versions);
						//$('#selCompanyContentLinks option:selected').text(response.title);						
						$('#selCompanyContentVersions option[value=\'' + response.version + '\']').attr('selected', true);
						$('#selCompanyContentVersions').attr('disabled', false);
						document.getElementById('selCompanyContentVersions').onchange = function(){getSavedMsg(response.pageTextID, parseInt(this.options[this.selectedIndex].value), obj); };											
					}
					else {						
						$('#selCompanyContentVersions').html('&lt;option value=\'1\'>Version 1&lt;/option>');
						$('#selCompanyContentVersions').attr('disabled', true);
					}
					
					
					$('#divSavedContent').html(response.bodyMarkup);
				}
				else {
					var titleText;
			
					if(response.title != '')		
						titleText = response.title;
					else
					titleText = $('input[name=savedPagesContent]:checked + label').text();
						//titleText = $('#selRteLinks option:selected').text();
			
					$('#txtTextTitle').val(titleText);
					tinymce.activeEditor.setContent(response.bodyMarkup);
				}
			}

			/*function closeOverlay() {
			div1.remove();
			}*/

			function onFPCarouselSuccess(response) {
				closeOverlay();
				addOverlay({html:'&lt;div>' + response + '&lt;/div>', width:350, height:150, canClose:true}, null);
				resetVersionSelect();
			}

			function onSuccess(response, pageID, index, module, obj) {
				//_alert('closing overlay - onSuccess - ' + response + '\n' + pageID  + '\n' + index + '\n' + module);
				closeOverlay();
				switch(module) {
					case 'WireframeQuickSearchWithLargePhotoModule':
						addOverlay({html:response.replace("'", "\'"), width:960, height:510, canClose:true}, 25);
					break;
					
					case 'WireframeFeaturedPropertiesCarouselModule':
						addOverlay({html:'&lt;div>' + response + '&lt;/div>', width:350, height:150, canClose:true}, null);
					break;
					
					case 'WireframeTextModule':
						response = $.parseJSON(response);
						var overlayHeight;
						
						if(response.textType == 'custom') {
							overlayWidth = 970;
							overlayHeight = 550;
						}
						else if(response.textType=='company' || response.textType == 'customSaved') {
							overlayWidth = 765;
							overlayHeight = 285;
						}
							//overlayHeight = 425;
												
						addOverlay({html:'&lt;div>' + response.bodyContent + '&lt;/div>', width:overlayWidth, height:overlayHeight, canClose:true}, null);
							if(response.textType == 'custom' ) {
								activateEditor(pageID, response.bodyMarkup);
								$('#txtTextTitle').val(response.title);
								$('#divWarning').html('&lt;img src=\'<xsl:value-of select="$Static"/>/intranet/icons/icon_warning.gif\'  border=\'0\'/>Any changes to this content will be immediately updated once you submit (and display on your website if this text area is currently displaying live).');
								
							}
							
							else if(response.textType =='company' || response.textType =='customSaved') {	
								if(response.textType == 'company') {
									$('#selCompanyContentVersions').html('&lt;option value=\'10\'>----------&lt;/option>');
									$('#selCompanyContentVersions').attr('disabled', true);
								}
								
								var savedContentID = response.savedContentID;
								if(savedContentID != ''){	
									if($('input:radio[value=' + savedContentID + ']').length > 0) {
										$('input:radio[value=' + savedContentID + ']').attr('checked', true);
										if(savedContentID.length > 0 &amp;&amp; response.textType =='company' ) {	
											getSavedMsg(savedContentID, response.companyContentVersion, obj);											
										}
										else {	
											getSavedMsg(savedContentID, obj);
										}
									}
									else {
										var $firstOpt = $('input:radio[name=savedContent][disabled=false]:first');
										$firstOpt.attr('checked', true);
										getSavedMsg($firstOpt.val(), obj);
										//alert('The company content previously used has been removed.  Please choose again.');
									}
									}
							else { //not previously saved from company content selection, so select first option as default
								var $firstOpt = $('input:radio[name=savedContent][disabled=false]:first');
								$firstOpt.attr('checked', true);
								getSavedMsg($firstOpt.val(), obj);
							}
						}
			
						$('#btnTextSubmit').click(function() { overlaySubmit(pageID, index, module, obj); });
					break;
					
					case 'WireframeProfileModuleStandard': 
					case 'WireframeProfileModuleAlternate':
						response = $.parseJSON(response);
												
						addOverlay({html:'&lt;div>' + response.bodyContent + '&lt;/div>', width:960, height:520, canClose:true}, null);
						$(':radio[value=' + response.displayType + ']').attr('checked',true);
						activateEditor(pageID, response.bodyMarkup);
						
						$('#btnProfileSubmit').click(function() { overlaySubmit(pageID, index, module); });
					break;
							
					case 'WireframeCalloutModule':
						addOverlay({html:'&lt;div style="overflow:hidden;">' + response + '&lt;/div>', width:980, height:500, canClose:true}, 55);
					break;
					
					case 'WireframeQuickSearchWithMapModule':
						response = $.parseJSON(response);
						addOverlay({html:'&lt;div>' + response.bodyContent + '&lt;/div>', width:response.width, height:500, canClose:true}, null);
							
						var map = new reliance.mapping.SearchLocalization('map');
						setMap(map, response.mapType, parseFloat(response.lat), parseFloat(response.lng), parseInt(response.zoom));
						
						$('#saveMap').click(function() {
							var bounds = map.getBounds();
							var center = bounds.getCenter();
							var lat = reliance.utilities.formatNumber(center.lat(),{precision:6});
							var lng = reliance.utilities.formatNumber(center.lng(),{precision:6});
							var ne = bounds.getNorthEast();
							var sw = bounds.getSouthWest();
							var nlat = ne.lat();
							var slat = sw.lat();
							var elng = ne.lng();
							var wlng = sw.lng();
							saveMap(module, pageID, index, map.getCurrentMapType().getName(), lat, lng, map.getZoom(), nlat, slat, elng, wlng);
							closeOverlay();
						});

						$('#resetMapChanges').click(function() {
							setMap(map, response.mapType, parseFloat(response.lat), parseFloat(response.lng), parseInt(response.zoom));
						});	
							
						$('#resetMapToDefault').click(function() {
							var bounds = map.getMlsBounds();
							map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds));
							map.setMapType(G_NORMAL_MAP);
						});	
					break;
				}
			}

			function overlaySubmit(pageID, index, module, obj) {
				switch(module) {
					case 'WireframeQuickSearchWithLargePhotoModule':
					break;
					case 'WireframeFeaturedPropertiesCarouselModule':
					break;
					case 'WireframeTextModule':	
						var data = 'companyID=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountID=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;pageID=' + pageID + '&amp;index=' + index + '&amp;intranetAccountID=<xsl:value-of select="$IntranetAccountID"/>';
						var type;
						if($('#divSavedContentOpts').length > 0) {
							var message = escape($('#divSavedContent').html());
							var title = $('input[name=savedContent]:checked + label').text();
							
							if($('#divCompanyContent').length > 0) {
								var companyContentVersion = 0;
								if($('#selCompanyContentVersions').length > 0 ){
									companyContentVersion = $('#selCompanyContentVersions option:selected').val();								
								}
								type = 'company';
							}
							else if($('#divCustomContent').length > 0) {
								type = 'customSaved';
							}
							
							data +='&amp;companyContentID=' + $('input[name=savedContent]:checked').val() + '&amp;companyContentVersion=' + companyContentVersion;
						}
						else
						{
							var title = $('#txtTextTitle').val();
							var message = escape(tinymce.activeEditor.getContent());
							var errCount = 0;

							//Validation
							errCount = validate(title, 'Title', errCount);
							if (errCount == 0) {
								type='custom'; 
							}
							else {
								return false;
							}							
						}	
						
						data += '&amp;title=' + title + '&amp;message='+ message + '&amp;type=' + type;							
							<!--If message validation is restored, statement below will need moved, adjusted.-->
							$.ajax({url:'/modules/intranet/SiteBuilder/TextEditorProcessingPage.aspx',
								data:data, type:'POST', success:function(xml){onSubmitSuccess(xml, module, obj);}, error:function(xml){onSubmitFail(xml, index, module);}});
						
						
					break;
					case 'WireframeProfileModuleStandard': 
					case 'WireframeProfileModuleAlternate':
						var message = escape(tinymce.activeEditor.getContent());
						var errCount = 0;
						if (errCount == 0) {
							data = 'companyID=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountID=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;pageID=' + pageID + '&amp;index=' + index + '&amp;intranetAccountID=<xsl:value-of select="$IntranetAccountID"/>&amp;message='+ message+'&amp;module='+module;
							$.ajax({url:'/modules/intranet/SiteBuilder/ProfileEditorProcessingPage.aspx',
							data:data, type:'POST', success:function(xml){onSubmitSuccess(xml, module);}, error:function(xml){onSubmitFail(xml, index, module);}});
						}
						break;
					case 'WireframeCalloutModule':
						break;
				}
			}

			function onFail(response, pageID, module) {
				closeOverlay();
				showErrorScreen('An error has occurred.  Please try again.');				
			}

			function onSubmitSuccess(response, module, obj) {
				switch(module) {
					case 'WireframeQuickSearchWithLargePhotoModule':
						break;
					case 'WireframeFeaturedPropertiesCarouselModule':
						break;
					case 'WireframeTextModule':
						response = $.parseJSON(response);
						if(response.origModID != response.newModID) {														
						
						$(obj).attr('_uniqueID', response.newModID);
					
						}
					<!-- intentionally no break here-->
					case 'WireframeProfileModuleStandard':
					case 'WireframeProfileModuleAlternate':
						tinymce.EditorManager.execCommand('mceRemoveControl', true, 'markup');
						closeOverlay();
						break;
					case 'WireframeCalloutModule':
						break;
				}
			reloadSandboxPreview();
			resetVersionSelect();
			}

			function onSubmitFail(response, pageID, module) {
				if (module == 'WireframeTextModule' || module == 'WireframeProfileModuleStandard' || module == 'WireframeProfileModuleAlternate') {
					var moduleType;

					switch (module) {
						case 'WireframeTextModule':
							moduleType = 'text';
							break;
						case 'WireframeProfileModuleStandard':
						case 'WireframeProfileModuleAlternate':
							moduleType = 'profile';
							break;
					}
					alert('An error has occured.  Please try saving your ' + moduleType + ' again.');
				}
			}

			function editSection(id, index, module, obj, opts) {
						
				index = index - 1;
				<!--11-28-11 - pageID is now used dynamically with textEditor-->
				if(module == 'WireframeTextModule')
					id = $(obj).attr('_uniqueID')
			
				<!--12-27-11 - added noCache parameter to resolve issue where ie caches previous ajax call instead of calling again,
								causing edits in profile and text editor to not show (possibly other module changes as well).-->
				var noCache = Math.random();				
				var data = 'companyid=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountID=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;index=' + index + '&amp;pageID=' + id + '&amp;intranetAccountID=<xsl:value-of select="$IntranetAccountID"/>&amp;noCache='+noCache;
						
				switch(module) {
					case 'WireframeQuickSearchWithLargePhotoModule':
						showWaitScreen("Loading \'Quick Search with Photo\' settings.");
						$.ajax({url:'/modules/intranet/SiteBuilder/PhotoManager.aspx', data:data, success:function(xml){onSuccess(xml, id, index, module);}, error:function (xhr, ajaxOptions, thrownError){alert(xhr.responseText); alert(thrownError); }, type:"POST"});
					break;
					case 'WireframeFeaturedPropertiesCarouselModule':
						showWaitScreen("Loading \'Featured Property\' settings.");
						$.ajax({url:'/modules/intranet/SiteBuilder/FeaturedPropertiesToolProcessingPage.aspx',
						data:data, success:function(xml){onSuccess(xml, id, index, module);}, error:function(xml){onFail(xml, id, module);}});
					break;
					case 'WireframeTextModule':
						data += '&amp;topic=textSavedPages&amp;value=' + module + '&amp;moduleType=' + module;
					$.ajax('ajaxprocess.aspx', {data:data, error:updateSectionError, success:function(xml){chooseTextType(xml, id, index, module, data, opts, obj);}, type:'POST'});
						//chooseTextType(id, index, module, data, opts);						
					break;
					case 'WireframeProfileModuleStandard':
					case 'WireframeProfileModuleAlternate':
						data += '&amp;moduleType=' + module;
						showWaitScreen("Loading \'Profile\' settings.");
						$.ajax({url:'/modules/intranet/SiteBuilder/ProfileEditor.aspx', data:data, success:function(xml){onSuccess(xml, id, index, module);}, error:function(xml){onFail(xml, id, module);}});
					break;
					case 'WireframeCalloutModule':
						showWaitScreen("Loading \'Callout\' settings.");
						$.ajax({url:'/modules/intranet/SiteBuilder/CalloutManager.aspx', data:data,  success:function(xml){onSuccess(xml, id, index, module);}, error:function(xml){onFail(xml, id, module);}});
					break;
					case 'WireframeQuickSearchWithMapModule':
					showWaitScreen("Loading \'Quick Search with Map\' settings.");
					$.ajax({url:'/modules/intranet/SiteBuilder/MapManager.aspx', data:data + '&amp;t=' + (new Date()).getTime(), success:function(xml){onSuccess(xml, id, index, module);}, error:function(xml){onFail(xml, id, module);}});
					break;
				}
			}
			<!--Note: attempting to pass obj (settings link) in "savedPagesHtml" string variable resulted in javascript error.
			Instead, setting global variable here to hold object, then removing it as soon as getCustomSavedText() function is reached-->
			var settingsLinkObj;
			function chooseTextType(response, id, index, module, data, opts, obj) {		
				var savedPagesHtml ='';
				var varHeight = 115;
				var customContentHtml = '&lt;tr>&lt;td style="border-right: 1px dotted #000" width="30%">&lt;span class="buttonSurround">&lt;input type="button" style="width:225px" onclick="closeOverlay();getCustomText(\'' + id + '\', ' + index + ',\'' + module + '\',\'' + data + '\');"\
				value="Create/Edit My Own Content" class="button" />&lt;/span>&lt;/td>&lt;td align="left">Enter your own custom content for this text area.&lt;/td>&lt;/tr>';		
				
				if(parseInt(response) > 0 ) {
				settingsLinkObj = obj;
				varHeight += 45;
				savedPagesHtml = '&lt;tr>&lt;td style="border-right: 1px dotted #000">&lt;span class="buttonSurround">&lt;input type="button" style="width:225px" onclick="closeOverlay();getCustomSavedText(\'' + id + '\', ' + index + ',\'' + module + '\',\'' + data + '\');"\
				value="Choose from My Existing Content" class="button" />&lt;/span>&lt;/td>&lt;td align="left">Select your existing content for this text area.&lt;/td>&lt;/tr>';
				}
						
				var companyContentHtml = '&lt;tr>&lt;td style="border-right: 1px dotted #000">&lt;span class="buttonSurround">&lt;input type="button" style="width:225px" onclick="closeOverlay();getCompanyContent(\'' + id + '\', ' + index + ',\'' + module + '\',\'' + data + '\');"\
				value="Choose from Company Content" class="button" />&lt;/span>&lt;/td>&lt;td align="left">Select existing, uneditable company content for this text area.&lt;/td>&lt;/tr>';

		    var	message = 'Please make a selection?';
				addOverlay({ html: '&lt;div style="padding:10px;">&lt;table width="100%"  cellpadding="10" cellspacing="0">' + customContentHtml + savedPagesHtml + companyContentHtml + '&lt;/table>&lt;/div>', width: 500, height: varHeight, canClose: true }, null);
			}

			function getCompanyContent(id, index, module, data) {
				data += '&amp;type=company';
				showWaitScreen("Loading \'Text\' settings.");
				$.ajax({url:'/modules/intranet/SiteBuilder/TextEditor.aspx', data:data, success:function(xml){onSuccess(xml, id, index, module);}, error:function(xml){onFail(xml, id, module);}});
			}

			function getCustomText(id, index, module, data) {
				data+= '&amp;type=custom';
				showWaitScreen("Loading \'Text\' settings.");
				$.ajax({url:'/modules/intranet/SiteBuilder/TextEditor.aspx', data:data, success:function(xml){onSuccess(xml, id, index, module);}, error:function(xml){onFail(xml, id, module);}});
			}
			
			function getCustomSavedText(id, index, module, data) {
			var obj = settingsLinkObj;
			settingsLinkObj = '';			
				data+= '&amp;type=customSaved';
				showWaitScreen("Loading \'Text\' settings.");
				$.ajax({url:'/modules/intranet/SiteBuilder/TextEditor.aspx', data:data, success:function(xml){onSuccess(xml, id, index, module, obj);}, error:function(xml){onFail(xml, id, module);}});
			}


			function xTheSection(id, disabledState)
			{
			
				var sectionDiv = $('#' + id);
				var childDiv = sectionDiv.children();
				var position = childDiv.position();

				if(disabledState) {					
					var dTable = document.createElement('table');
					var dTblBody = document.createElement('tbody');
					var dTr = document.createElement('tr');
					var dTd = document.createElement('td');
					var dTdText = document.createTextNode('Hidden');
					
					dTable.style.cssText='position:absolute; top:0px; left:0px; background-color:#7F7F7F; filter: alpha(opacity=80); opacity:0.8; -moz-opacity:0.8; width:' + sectionDiv.width() + 'px; height:' + sectionDiv.height() + 'px;'
					dTd.setAttribute('align', 'center');
					dTd.setAttribute('valign', 'middle');
					dTd.style.cssText='color:#FFFFFF; font-weight: bold; font-size:13pt;';
					
					dTd.appendChild(dTdText);
					dTr.appendChild(dTd);
					dTblBody.appendChild(dTr);
					dTable.appendChild(dTblBody);
			
					sectionDiv.append(dTable);			
				}
				else {
					sectionDiv.children('table').remove();
				}
			}

			function showhide(node, index) {
				var disabledState = node.id.indexOf('_hidden') > 0 ? true : false;
				var mode = disabledState ? 'hidden' : 'visible';
				var id = node.id;
				node = $(node);
				var section = id.substring(0, id.indexOf('_'));

				var sectionDiv = $('#layout' + section);
				var childDiv = sectionDiv.children();
				var checkboxSection = node.parent().next();
				var checkboxSectionLink;

				if(checkboxSection.children().children().is('input'))
					checkboxSectionLink = checkboxSection.children().children('input:checked').next().next('a');
				else
					checkboxSectionLink = checkboxSection.children('a');

				xTheSection('layoutsection' + index, disabledState);
				checkboxSectionLink.css('visibility', mode);
			}

			function toggleHover(node) {
				if (arguments[0].data)
					node = arguments[0].data.node;

				$(node).toggleClass('optionhover');
			}

			//Text Editor Functions
			function closeEditor() {
				closeOverlay();
			}

			function clearPage() {
				var iframe=document.getElementById('markup_ifr');
				$(iframe.contentWindow.document.body).empty();
				$('#txtTextTitle').val('');
			}

			function validate(val, valName, errCount) {
				if (val == undefined || val == '' || val.toLowerCase() == '&lt;p>&lt;br _mce_bogus="1">&lt;/p>'  ) {
					alert(valName + ' is required');
					errCount++;
				}
				return parseInt(errCount);
			}

			function confirmHomepageRedirect(varInt, node, value) {
				if (confirm('By changing your homepage to redirect to an interior page, your current ' + layoutOrWireframe + ' website previewer settings will be cleared.\n\nWould you like to continue?')) 
					toggleWireframeTool(varInt, node, value);
			}

			function updateHomepageRedirect(node, element, value, showWait) {
					if(showWait == 'true') 
						showWaitScreen("Updating Home Page Settings.");
					var data = 'companyid=<xsl:value-of select="websiteConfiguration/contentID"/>&amp;accountid=<xsl:value-of select="websiteConfiguration/accountID"/>&amp;intranetaccountid=<xsl:value-of select="$IntranetAccountID"/>&amp;topic=' + element + '&amp;value=' + value + '&amp;lbl=' + value + '&amp;brnd=Prudential&amp;arch=RelianceNetwork';
					$.ajax('ajaxprocess.aspx', {data:data, success:updateHomepageRedirectSuccess, type:'POST'});
					
			}

			function updateHomepageRedirectSuccess() {
				closeOverlay();
				reloadSandboxPreview();
			}

			function toggleWireframeTool(showElem, node, element) {
				if (showElem == 'int') {
					document.getElementById('CustomizeLayoutSection').style.display = 'none';
					document.getElementById('SelectInteriorPage').style.display = 'block';
				
					var selectedOptions = $('#' + element + 's .optionselected');
					
					for (var i = 0; i &lt; selectedOptions.length; i++) {
						$(selectedOptions[i]).toggleClass('optionselected');
					}

					$(node).toggleClass('optionselected');
					
				
					<!--Check if any 'Interior Page' opts are selected. 
					Grab either first selection or previously chosen and update sandbox.-->
					var homepageOpts = $('#tdHomepageRedirectOpts').children('input:radio');
					var selectedOpt;								
					
					for (var i=0; i &lt; homepageOpts.length; i++) {
						if($(homepageOpts[i]).is(':checked'))
							selectedOpt = $(homepageOpts[i]);
					}
				
					if(selectedOpt=== undefined)
						selectedOpt = $(homepageOpts[0]);
					
					updateHomepageRedirect(selectedOpt, 'homepageRedirect', escape(selectedOpt.val()), 'true');
					selectedOpt.attr('checked', true);
				
				
				}else{
					document.getElementById('CustomizeLayoutSection').style.display = 'block';
					document.getElementById('SelectInteriorPage').style.display = 'none';
				}	
			
			}
		</script>
		
		<div style="position:absolute; width:100%; height:100%; left:0; top:0; z-index:1000; display:none;">
			<div class="ui-overlay">
				<div class="ui-widget-overlay"></div>
				<div class="ui-widget-shadow ui-corner-all" style="width: 302px; height: 152px; position: absolute; left: 50px; top: 30px;"></div>
			</div>
			<div style="position: absolute; width: 280px; height: 130px;left: 50px; top: 30px; padding: 10px;" class="ui-widget ui-widget-content ui-corner-all">
				<br/>
			</div>
		</div>
		
		<table cellpadding="0" cellspacing="0" border="0" width="100%" class="itemContainer">
		<tr>
		<td class="itemHelp"><img src="http://content.mediastg.net/dyna_images/intranet/icon_warning.gif"/> You are viewing a limited subset of the Site Builder tools.
			<br/><br/>
			By upgrading to a full website account, you will have access to:<br/>
			<ul>
			<li>Modify website colors, header, and home page layout</li>
			<li>Add top-level navigation</li>
			<li>Add/update website content</li>
			<li>Suite of SEO tools for improving search engine rankings</li>
			<li>Specify default search area for Property Search</li>
			</ul>
		</td>
		</tr>
		</table>
		<br/><br/>
		<form id="frmWireframe" action="processwireframe.aspx" style="margin:0">
			<input type="hidden" name="accountid" runat="server" value="{websiteConfiguration/accountID}"/>
			<input type="hidden" name="wireframe" value="{websiteConfiguration/wireframeType}" />
			<input type="hidden" id="designNumber" />
			<input type="hidden" id="siteDirectory" />
			<table cellpadding="0" cellspacing="0" border="0" width="100%" class="itemContainer">
			<xsl:if test="count(websiteConfigurationOptions/skinOptions/skin) > 1 and 1 = 0 ">
			<tr>
			<td>
				<table id="tblLayouts" cellpadding="0" cellspacing="0" border="0" width="100%" class="itemTable">
				<tr>
				<td><img src="{$Static}/global/invis.gif" height="5"/></td>
				</tr>
				<tr><td class="itemTitle">Skins</td>
				</tr>
				<tr>
				<td>
					<table cellpadding="0" cellspacing="0" border="0" width="100%" class="datatable">
					<tr>
					<td>
						<div id="skins">
							<xsl:apply-templates select="websiteConfigurationOptions/skinOptions/skin"/>
						</div>
					</td>
					</tr>
					</table>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			<tr>
			<td><img src="{$Static}/global/invis.gif" height="5"/></td>
			</tr>
			</xsl:if>
			<tr>
			<td>
				<table id="tblLayouts" cellpadding="0" cellspacing="0" border="0" width="100%" class="itemTable">
				<tr>
				<td>
					<table id="tblLayouts" cellpadding="0" cellspacing="0" border="0" width="100%" class="itemTable">
					<tr>
					<td id="CustomizeLayoutSection">
						<xsl:if test="string-length(websiteConfiguration/homepageUrl) > 0">
							<xsl:attribute name="style">
								<xsl:value-of select="'display:none'"/>
							</xsl:attribute>
						</xsl:if>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
						<td class="itemTitle">Customize Your <xsl:value-of select="$LayoutOrWireframe"/></td>
						</tr>
						<tr>
						<td style="padding-bottom:5px;">Customize the home page of your website by selecting and changing options below</td>
						</tr>
						<tr>
						<td id="customizeWireframe">
							<xsl:apply-templates select="websiteConfiguration/wireframeConfiguration"/>
						</td>
						</tr>
						</table>
					</td>
					</tr>
					<tr>
					<td id="SelectInteriorPage">
						<xsl:if test="string-length(websiteConfiguration/homepageUrl) = 0">
							<xsl:attribute name="style">
								<xsl:value-of select="'display:none'"/>
							</xsl:attribute>
						</xsl:if>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
						<td class="itemTitle">Interior Home Page Redirect</td>
						</tr>
						<tr>
						<td class="item" height="100%">
							<table cellpadding="0" cellspacing="0" border="0" height="100%" ID="Table5">
							<tr>
							<td valign="top" style="padding-top: 4px;">Select an interior page to act as the Home Page.  This sets one of your interior pages as the Home Page of your site.</td>
							</tr>
							<tr>
							<td id="tdHomepageRedirectOpts" style="padding-top:10px;">
								<xsl:apply-templates select="websiteConfiguration/homepageRedirectOptions/homepageRedirectOption"/>
							</td>
							</tr>
							</table>
						</td>
						</tr>
						</table>
					</td>
					</tr>
					</table>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			</table>
		</form>
	</xsl:template>

	<xsl:template match="websiteConfigurationOptions/skinOptions/skin">
		<xsl:variable name="selected">
			<xsl:if test="/xml/websiteConfiguration/skin = name">
				<xsl:value-of select="' optionselected'"/>
			</xsl:if>
		</xsl:variable>

		<div class="option{$selected}" onmouseover="toggleHover(this)" onmouseout="toggleHover(this)" onclick="updateOption(this, 'skin', '{name}')">
			<xsl:value-of select="@label"/>
		</div>
	</xsl:template>

	<xsl:template match="websiteConfigurationOptions/wireframeOptions/wireframe">
		<xsl:variable name="selected">
			<xsl:if test="/xml/websiteConfiguration/wireframeConfiguration/@xsi:type = key and string-length(/xml/websiteConfiguration/homepageUrl) = 0">
				<xsl:value-of select="' optionselected'"/>
			</xsl:if>
		</xsl:variable>

		<div id="div{key}" class="option{$selected}" onmouseover="toggleHover(this)" onmouseout="toggleHover(this)" onclick="updateWireframe(this, 'wireframe', '{key}');">
			<xsl:value-of select="label"/>
		</div>
	</xsl:template>

	<xsl:template match="websiteConfigurationOptions/otherCalloutOptions/callout">
		<xsl:variable name="selected">
			<xsl:if test="/xml/websiteConfigurationOptions/callout = node()">
				<xsl:value-of select="' optionselected'"/>
			</xsl:if>
		</xsl:variable>

		<div class="option{$selected}" onmouseover="toggleHover(this)" onmouseout="toggleHover(this)" onclick="updateOption(this, 'callout', '{node()}')">
			<img src="{$StaticUrl}RealEstate/Website/Callout/{node()}" width="100" alt="{node()}"/>
		</div>
	</xsl:template>

	<xsl:template match="websiteConfiguration/homepageRedirectOptions/homepageRedirectOption">
		<xsl:variable name="selectedValue" select="/xml/websiteConfiguration/homepageUrl"/>
		<xsl:variable name="currentValue" select="key"/>
		<input type="radio" name="homepageRedirectOption" value="{key}" id="{key}" onclick="updateHomepageRedirect(this, 'homepageRedirect', escape(this.value), 'true');">
			<xsl:if test="$selectedValue = $currentValue">
				<xsl:attribute name="checked">
					<xsl:value-of select="'true'"/>
				</xsl:attribute>
			</xsl:if>
		</input><label for="{key}" style="cursor:pointer"><xsl:value-of select="label"/></label><br/>
	</xsl:template>
</xsl:stylesheet>