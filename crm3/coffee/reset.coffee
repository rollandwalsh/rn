# Appends CRM3 stylesheet - TODO: this doesn't work currently for unclear reasons.
$('head').append '<link href="/crm3/css/theme-01.css" rel="stylesheet">'

# Removes uneccessary type attribute 
$('link[href*="shared-header-footer.css"]').removeAttr 'type'
# Changes stylesheet link to CRM3
$('link[href*="shared-header-footer.css"]').attr 'href', $('link[href*="shared-header-footer.css"]').attr('href').replace('Themes/08/shared-header-footer.css', 'crm3/css/theme-01.css')
# Removes all other stylesheets
$('link[type="text/css"]').remove()

# Removes Foundation wrapper stylings
$('.off-canvas-wrap').children().unwrap()
$('.inner-wrap').children().unwrap()

# Changes page header to CRM3 class
$('header.razor').attr 'class', 'crm-site-header'
# Changes page header element to CRM3 class
$('.crm-site-header > div').addClass 'crm-site-header-top-bar'

# Renames and rearranges logo
$('<a class="crm-site-header-logo"></a>').prependTo '.crm-site-header-top-bar'
$('#nav-logo').appendTo '.crm-site-header-logo'


$('.crm-site-header-top-bar > div').replaceWith '<aside class="crm-site-header-user">' + $('.crm-site-header-top-bar > div').html() + '</aside>'
if $('.crm-site-header-user div.hide-for-small').length > 0
  $('.crm-site-header-user div.hide-for-small').replaceWith '<span>Working as</span>'
$('#user-info').children().unwrap()
$('#user-icon').children().unwrap().addClass 'initials'
$('<ul class="dropdown menu align-right" data-dropdown-menu><li></li></ul>').appendTo '.crm-site-header-user'
$('#user-options').appendTo('.crm-site-header-user .menu li').removeAttr 'class'
$('#user-options span').replaceWith $('#user-options span').text()
$('#user-options-dd').appendTo('.crm-site-header-user .menu li').attr 'class', 'menu'
if $('#user-options-dd > li > ul > li').length > 0
  $('#user-options-dd > li > ul').children().unwrap().unwrap()

$('.top-bar').attr 'class', 'crm-site-header-nav'
$('.top-bar-section > ul').unwrap().addClass 'crm-site-header-menu'
$('.has-dropdown > .dropdown > .has-dropdown > .dropdown').attr 'class', 'slideright'
$('.has-dropdown > .dropdown > .has-dropdown').attr 'class', 'has-slideright'
$('.divider').remove()
$('<i class="crm-icon-triangle-right"></i>').appendTo '.intranet-resources-button a'
$('.intranet-resources-button').removeAttr 'class'
$('.tab-bar').remove()

$('.breadcrumbs').parent().parent().replaceWith '<aside class="crm-site-breadcrumbs"><div class="crm-container">' + $('.breadcrumbs').parent().html() + '</div></aside>'
$('.breadcrumbs li span').replaceWith ->
  $ '<a/>', html: @innerHTML
$('.breadcrumbs').removeAttr 'class'

$('.left-off-canvas-menu').remove()

$('.main-section').attr 'class', 'crm-site-content'

setTimeout (->
  $('#spinner').fadeOut 'slow'
  return
), 500