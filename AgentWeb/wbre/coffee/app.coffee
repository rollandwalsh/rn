navMenuButton = $('#rnSiteHeaderNavButton')
navMenu = $('#rnSiteHeaderNavMenu')

navMenuButton.on 'click', (e) ->
  navMenuButton.toggleClass 'is-active'
  navMenu.slideToggle()
  e.preventDefault()
  return
  