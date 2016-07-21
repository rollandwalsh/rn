var navMenu, navMenuButton;

navMenuButton = $('#rnSiteHeaderNavButton');

navMenu = $('#rnSiteHeaderNavMenu');

navMenuButton.on('click', function(e) {
  navMenuButton.toggleClass('is-active');
  navMenu.slideToggle();
  e.preventDefault();
  console.log('test');
});
