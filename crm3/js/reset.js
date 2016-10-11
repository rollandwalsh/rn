$('head').append('<link href="/crm3/css/theme-01.css" rel="stylesheet">');

$('link[href*="shared-header-footer.css"]').removeAttr('type');

$('link[href*="shared-header-footer.css"]').attr('href', $('link[href*="shared-header-footer.css"]').attr('href').replace('Themes/08/shared-header-footer.css', 'crm3/css/theme-01.css'));

$('link[type="text/css"]').remove();

$('.off-canvas-wrap').children().unwrap();

$('.inner-wrap').children().unwrap();

$('header.razor').attr('class', 'crm-site-header');

$('.crm-site-header > div').addClass('crm-site-header-top-bar');

$('<a class="crm-site-header-logo"></a>').prependTo('.crm-site-header-top-bar');

$('#nav-logo').appendTo('.crm-site-header-logo');

$('.crm-site-header-top-bar > div').replaceWith('<aside class="crm-site-header-user">' + $('.crm-site-header-top-bar > div').html() + '</aside>');

if ($('.crm-site-header-user div.hide-for-small').length > 0) {
  $('.crm-site-header-user div.hide-for-small').replaceWith('<span>Working as</span>');
}

$('#user-info').children().unwrap();

$('#user-icon').children().unwrap().addClass('initials');

$('<ul class="dropdown menu align-right" data-dropdown-menu><li></li></ul>').appendTo('.crm-site-header-user');

$('#user-options').appendTo('.crm-site-header-user .menu li').removeAttr('class');

$('#user-options span').replaceWith($('#user-options span').text());

$('#user-options-dd').appendTo('.crm-site-header-user .menu li').attr('class', 'menu');

if ($('#user-options-dd > li > ul > li').length > 0) {
  $('#user-options-dd > li > ul').children().unwrap().unwrap();
}

$('.top-bar').attr('class', 'crm-site-header-nav');

$('.top-bar-section > ul').unwrap().addClass('crm-site-header-menu');

$('.has-dropdown > .dropdown > .has-dropdown > .dropdown').attr('class', 'slideright');

$('.has-dropdown > .dropdown > .has-dropdown').attr('class', 'has-slideright');

$('.divider').remove();

$('<i class="rn-icon-triangle-right"></i>').appendTo('.intranet-resources-button a');

$('.intranet-resources-button').removeAttr('class');

$('.tab-bar').remove();

$('.breadcrumbs').parent().parent().replaceWith('<aside class="crm-site-breadcrumbs"><div class="crm-container">' + $('.breadcrumbs').parent().html() + '</div></aside>');

$('.breadcrumbs li span').replaceWith(function() {
  return $('<a/>', {
    html: this.innerHTML
  });
});

$('.breadcrumbs').removeAttr('class');

$('.left-off-canvas-menu').remove();

$('.main-section').attr('class', 'crm-site-content');

$('.reveal-modal').attr('class', 'reveal');

if ($('a[href="javascript: // Resources"]').length > 0) {
  $('a[href="javascript: // Resources"]').attr('data-open', 'resources-modal');
}

if ($('.resource-category[data-type="link"]').length > 0) {
  $('.resource-category[data-type="link"] > a').attr('class', 'button expanded').prepend('<i class="rn-icon-link"></i> ').unwrap();
}

setTimeout((function() {
  $('#spinner').fadeOut('slow');
}), 500);
