openPage = (evnt, url, name, newWindow) ->
  if newWindow
    window.open '/' + companyAbbr + '/' + url + '?AccountID=' + accountID, name, 'width=815px,height=555px,resizable=1,scrollbars=1,'
  else
    document.location = '/' + companyAbbr + '/' + url
  return

openForm = (evnt, url, name, newWindow) ->
  if newWindow
    window.open '/' + companyAbbr + '/modules/global/forms/' + url + '?AccountID=' + accountID, name, 'width=450px,height=600px,resizable=1,scrollbars=1,'
  else
    document.location = '?' + url
  return

testForm = ->
  addMask()
  $.ajax
    url: 'http://devweb.summitnetworks.com/' + companyAbbr + '/modules/global/forms/sellerrequest.asp?AccountID=' + accountID + '&acc=' + account
    success: testformCallback
    dataType: 'html'
  return

testformCallback = (response) ->
  response = response.replace(/<\/?(html|head|body)[^>]*>/g, '')
  response = response.substring(response.indexOf('/script>') + 8).replace(/script/g, '')
  console.log response
  $('<div></div>').attr('id', 'form').css(
    position: 'absolute'
    top: '10px'
    backgroundColor: '#fff'
    zIndex: 1001).append(response).appendTo $('body')
  return

forgotPassword = ->
  addMask()
  return

tryLogin = (username, rememberMe, password) ->
  usernameField = $('input[name=' + username + ']')
  passwordField = $('input[name=' + password + ']')
  rememberMeField = $('input[name=' + rememberMe + ']')
  if rememberMeField.attr('type') == 'radio'
    rememberMeField = $('#' + rememberMe + '-yes')
    if rememberMeField.length == 0
      throw '\'Remember Me\' field not found'
      return
      $('<div></div>').attr('id', 'form').css(backgroundColor: '#fff').append(response).appendTo body
  usernameValue = $.trim(usernameField.val())
  passwordValue = $.trim(passwordField.val())
  rememberMeValue = if rememberMeField.attr('checked') == 'checked' then 'on' else 'off'
  if usernameValue.length == 0
    alert 'Please enter your email address.'
    usernameField.focus()
    false
  $('input[name=username]').val usernameValue
  $('input[name=password]').val passwordValue
  $('input[name=remember]').val rememberMeValue
  form = $('form[name=extranet-login]')[0]
  form.submit()
  false

closeContactMe = ->
  $('#contactMask').remove()
  $('#contactForm').remove()
  return

addMask = ->
  $('<div id="contactMask"></div>').appendTo $('body')
  return

contactMe = (evnt) ->
  addMask()
  $.ajax
    url: '/' + companyAbbr + '/modules/internet/contactMeForm.aspx?webSessionID=' + randomNumber + '&contentID=' + companyId + '&accountid=' + accountId
    success: contactMeCallback
  return

contactMeCallback = (response) ->
  $('<div id="contactForm" class="row"></div>').append(response).appendTo $('body')
  if $('#contactForm').length > 0
    $('#-cf-column-form').attr('id', 'contactFormLeft').addClass 'medium-8 columns'
    $('#-cf-column-info').attr('id', 'contactFormRight').addClass('medium-4 columns').removeAttr 'style'
    $('#-cf-form-close').attr('id', 'formClose').addClass('right').html('<i class="fa fa-times-circle fa-lg"></i>').appendTo '#contactForm'
    $('#contactFormLeft > div > form').attr('onsubmit', 'return newContactFormSubmit();').removeAttr('style').unwrap()
    $('.-cf-clear').remove()
    $('.-cf-form-required-indicator').remove()
    $('label[for="-cf-form-field-from"]').append '*'
    $('label[for="-cf-form-field-firstname"]').append '*'
    $('label[for="-cf-form-field-lastname"]').append '*'
    $('#-cf-form > div:first-child').attr 'id', 'fromRow'
    $('#-cf-form > div:nth-child(2)').attr 'id', 'subjectRow'
    $('#-cf-form > div:nth-child(3)').attr 'id', 'textareaRow'
    $('#-cf-form > div:nth-child(4)').attr 'id', 'firstNamePhoneRow'
    $('#-cf-form > div:nth-child(5)').attr 'id', 'lastNameContactRow'
    $('#-cf-form > div:nth-child(6)').attr('id', 'buttonRow').removeAttr 'style'
    $('#-cf-form').children().addClass('row').unwrap()
    $('#fromRow > div:first-child').attr 'class', 'large-12 columns'
    $('#-cf-form-field-from').removeAttr('class').removeAttr('onfocus').removeAttr('onblur').removeAttr('value').attr('placeholder', 'Enter Your Email Address').unwrap().appendTo 'label[for="-cf-form-field-from"]'
    $('#subjectRow > div:first-child').attr 'class', 'large-12 columns'
    $('#-cf-form-field-subject').removeAttr('class').appendTo 'label[for="-cf-form-field-subject"]'
    $('#-cf-form-field-message').wrap('<div class="large-12 columns">').removeAttr 'style'
    $('#firstNamePhoneRow > div:first-child').attr 'class', 'medium-6 columns'
    $('#-cf-form-field-firstname').removeAttr('class').unwrap().appendTo 'label[for="-cf-form-field-firstname"]'
    $('#firstNamePhoneRow > div:nth-child(2)').attr 'class', 'medium-6 columns'
    $('#-cf-form-field-phone').removeAttr('class').unwrap().appendTo 'label[for="-cf-form-field-phone"]'
    $('#lastNameContactRow > div:first-child').attr 'class', 'medium-6 columns'
    $('#-cf-form-field-lastname').removeAttr('class').unwrap().appendTo 'label[for="-cf-form-field-lastname"]'
    $('#lastNameContactRow > div:nth-child(2)').attr 'class', 'medium-6 columns'
    $('#-cf-form-field-method').removeAttr('class').appendTo 'label[for="-cf-form-field-method"]'
    $('#buttonRow').append '<div class="large-12 columns text-center"></div>'
    $('#-cf-form-button-submit').appendTo('#buttonRow div.large-12').replaceWith '<button type="submit" class="small radius success">Submit</button> '
    $('button.small').after '<br>'
    $('#-cf-form-button-reset').appendTo('#buttonRow div.large-12').replaceWith '<button type="reset" class="tiny radius secondary">Reset</button> '
    $('#-cf-form-button-cancel').appendTo('#buttonRow div.large-12').replaceWith '<button onclick="closeContactForm()" type="button" class="tiny radius alert">Cancel</button>'
    $('#contactForm form div:nth-child(7)').replaceWith '<div id="formFooter" class="row"><div class="medium-3 columns">* = Required Field</div></div>'
    $('#-cf-disclaimer').attr('id', 'formDisclaimer').addClass('medium-9 columns').appendTo '#formFooter'
    $('#formDisclaimer span').removeAttr 'style'
    $('#formDisclaimer span a').removeAttr 'style'
    $('#formFooter').children().wrapInner '<small>'
    $('#-cf-info-name').wrapInner '<h5 class="text-center">'
    $('#-cf-info-name h5').unwrap()
    $('#-cf-info-photo').attr('class', 'text-center').removeAttr 'id'
    $('#-cf-info-photo img').removeAttr 'style'
    $('#-cf-info-office-heading').wrapInner '<h6>'
    $('#-cf-info-numbers-heading').wrapInner '<h6>'
    $('#-cf-info-website-heading').wrapInner '<h6>'
    $('#-cf-info-mobile-heading').wrapInner '<h6>'
    $('#-cf-info-office-heading h5').unwrap()
    $('#-cf-info-numbers-heading h5').unwrap()
    $('#-cf-info-website-heading h5').unwrap()
    $('#-cf-info-mobile-heading h5').unwrap()
    $('#-cf-info-company-name').replaceWith '<p id="officeInfo">' + $('#-cf-info-company-name').html() + '<br></p>'
    $('#-cf-info-address-1').appendTo('#officeInfo').replaceWith $('#-cf-info-address-1').html() + '<br>'
    $('#-cf-info-address-city').appendTo('#officeInfo').replaceWith $('#-cf-info-address-city').html() + ' '
    $('#-cf-info-address-state').appendTo('#officeInfo').replaceWith $('#-cf-info-address-state').html() + ' '
    $('#-cf-info-address-zip').appendTo('#officeInfo').replaceWith $('#-cf-info-address-zip').html() + '<br>'
    $('#-cf-info-office-phone').appendTo('#officeInfo').replaceWith $('#-cf-info-office-phone').html() + '</p>'
    $('#-cf-form-field-phone').removeAttr 'id'
    $('#-cf-info-numbers-info div:first-child').replaceWith '<p id="contactNumbers">' + $('#-cf-info-numbers-info div:first-child').html() + '<br>'
    $('#-cf-info-numbers-info div:nth-child(2)').appendTo('#contactNumbers').replaceWith '' + $('#-cf-info-numbers-info div:nth-child(2)').html() + '<br>'
    $('#-cf-info-numbers-info div:nth-child(3)').appendTo('#contactNumbers').replaceWith '' + $('#-cf-info-numbers-info div:nth-child(3)').html() + '<br>'
    $('.-cf-info-numbers-number').appendTo('#contactNumbers').replaceWith '' + $('.-cf-info-numbers-number').html() + '</p>'
    $('#-cf-info-website-info').replaceWith '<p id="websiteInfo">' + $('#-cf-info-website-info').html() + '</p>'
    $('#-cf-info-mobile-info').replaceWith '<p id="mobileInfo">' + $('#-cf-info-mobile-info').html() + '</p>'
  return

submitlostpasswordrequest = ->
  x = undefined
  username = $.trim($('input[name=username]').val())
  x = window.open('/' + companyAbbr + '/modules/internet/search/lostpassword.asp?email=' + username, 'lostpassword', 'width=313,height=245')
  x.focus()
  true

newContactFormSubmit = ->
  fromField = $('#-cf-form-field-from')
  firstNameField = $('#-cf-form-field-firstname')
  lastNameField = $('#-cf-form-field-lastname')
  phoneField = $('#-cf-form-field-phone')
  from = $.trim(fromField.val().replace('Enter Your Email Address', ''))
  subject = $.trim($('#-cf-form-field-subject').val().split(' ').join('+'))
  firstName = $.trim(firstNameField.val())
  lastName = $.trim(lastNameField.val())
  phone = $.trim(phoneField.val())
  method = $('#-cf-form-field-method').val()
  message = $.trim($('#-cf-form-field-message').val())
  emailPattern = /^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*(\+[a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2}[a-zA-Z0-9]*$/
  if !from.match(emailPattern)
    alert 'Please enter a valid email address.'
    fromField.focus()
    return false
  if firstName.length == 0
    alert 'Please enter your first name.'
    firstNameField.focus()
    return false
  if lastName.length == 0
    alert 'Please enter your last name.'
    lastNameField.focus()
    return false
  data = 'from=' + from + '&subject=' + subject + '&first=' + firstName + '&last=' + lastName + '&phone=' + phone + '&contactby=' + method + '&message=' + escape(message)
  $.ajax '/' + companyAbbr + '/modules/global/contact.asp?accountid=' + accountId + '&action=sendmail',
    data: data
    type: 'POST'
    success: contactFormSubmitCallback
  newContactFormSubmitCallback()
  false

newContactFormSubmitCallback = ->
  formArea = $('#contactFormLeft')
  formArea.empty()
  formArea.addClass('text-center').html '<h6>Thank you, your email has been sent.</h6><button onclick="newCloseContactForm()" type="button" class="tiny radius alert">Close</button>'
  return

newCloseContactForm = ->
  $(window).trigger 'contactformclose'
  return

$ ->
  if $('input[name=ext-username]').length > 0
    $('input[name=ext-username]').val ''
    $('input[name=ext-password]').val ''
  return
$(window).bind 'contactmeclick', contactMe
$(window).bind 'contactformclose', closeContactMe
$(window).bind 'forgotpasswordclick', submitlostpasswordrequest
$(window).bind 'openpageclick', openPage
$(window).bind 'openformclick', openForm
#////
do ->
  KEY_CODE_ARROW_LEFT = 37
  KEY_CODE_ARROW_RIGHT = 39
  KEY_CODE_ARROW_UP = 38
  KEY_CODE_ARROW_DOWN = 40
  KEY_CODE_ENTER_RETURN = 13
  KEY_CODE_HOME = 36
  KEY_CODE_END = 35
  KEY_CODE_PAGE_UP = 33
  KEY_CODE_PAGE_DOWN = 34
  KEY_CODE_ESCAPE = 27
  KEY_CODE_TAB = 9
  _textPadding = 2
  _rowHeight = 20
  _maxRows = 6

  SuggestionField = (field, dataSource, method, opts) ->
    if !field.tagName or field.tagName and !field.type or field.tagName and field.type and field.type != 'text'
      reliance.throwError '[reliance.Exception: SuggestionField] Cannot instantiate given field.'
    if method and typeof method != 'function'
      reliance.throwError '[reliance.Exception: SuggestionField] Type mismatch: method must be a type of function.'
    if opts.version != 2
      reliance.xDomainHttpRequest.create 'http://' + reliance.loader.proxyHost() + '/proxy/' + dataSource, this, ((response) ->
        @data = response
        return
      ), silent: true
    @field = field
    @method = method
    @data = if opts.version == 2 then null else []
    @suggestionKeystrokeMinimum = if opts and opts.suggestionKeystrokeMinimum and typeof opts.suggestionKeystrokeMinimum == 'number' then opts.suggestionKeystrokeMinimum else 1
    @width = if opts and opts.expandedWidth and typeof opts.expandedWidth == 'number' then opts.expandedWidth else field.offsetWidth
    @displayInfo = if opts and opts.displayInfo and typeof opts.displayInfo == 'boolean' then opts.displayInfo else false
    @infoSize = if opts and opts.infoSize and typeof opts.infoSize == 'number' then opts.infoSize else 35
    @version = if opts.version then opts.version else 1
    @dataSource = dataSource
    initialize.apply this
    return

  initialize = ->
    # The "this" keyword refers to the SuggestionField object
    f = @field
    f.autocomplete = 'off'
    list = document.createElement('div')
    list.style.cssText = 'float:left; position:absolute; border:#d21f26 1px solid; heigh: auto; display:none; overflow:auto; width:' + @width - _getBorderCorrection() + 'px;z-index:10000;'
    document.body.appendChild list
    @list = list
    reliance.event.bindDom f, 'keyup', this, (evnt) ->
      _handleKey.apply this, [
        'up'
        evnt
      ]
    reliance.event.bindDom f, 'keydown', this, (evnt) ->
      _handleKey.apply this, [
        'down'
        evnt
      ]
    reliance.event.addDomListener document, 'click', reliance.event.callbackArgs(this, _handleDisplay, 0)
    return

  _getBorderCorrection = ->
    borderWidth = 1
    borderWidth * 2

  _handleKey = (eventKeyMode, evnt) ->
    # The "this" keyword refers to the SuggestionField object
    evnt = reliance.domUtilities.fixEvent(evnt)
    if evnt.keyCode == KEY_CODE_ESCAPE or evnt.keyCode == KEY_CODE_TAB
      return @list.style.display = 'none'
    if eventKeyMode == 'up'
      if evnt.keyCode == KEY_CODE_ARROW_LEFT or evnt.keyCode == KEY_CODE_ARROW_RIGHT or evnt.keyCode == KEY_CODE_ARROW_UP or evnt.keyCode == KEY_CODE_ARROW_DOWN or evnt.keyCode == KEY_CODE_HOME or evnt.keyCode == KEY_CODE_END or evnt.keyCode == KEY_CODE_PAGE_UP or evnt.keyCode == KEY_CODE_PAGE_DOWN
        # do nothing
      else if evnt.keyCode == KEY_CODE_ENTER_RETURN
        if @highlightIndex != -1
          @list.childNodes[@highlightIndex].onclick.apply()
      else
        if eventKeyMode == 'up'
          _redraw.apply this
    if eventKeyMode == 'down'
      if evnt.keyCode == KEY_CODE_ARROW_UP or evnt.keyCode == KEY_CODE_ARROW_DOWN
        x = if evnt.keyCode == KEY_CODE_ARROW_UP then -1 else 1
        x += if @version == 2 and @highlightIndex + x < @list.childNodes.length and (@list.childNodes[@highlightIndex + x].className == 'rn-search-location-title' or @list.childNodes[@highlightIndex + x].firstChild.innerHTML == 'No Suggestions') then (if evnt.keyCode == KEY_CODE_ARROW_UP then -1 else 1) else 0
        _highlight.apply this, [ @highlightIndex + x ]
    return

  _redraw = ->
    # The "this" keyword refers to the SuggestionField object
    if @getValue().length < 3
      reliance.domUtilities.clearChildNodes @list
      @list.style.display = 'none'
    value = @field.value.trim().replace(/^,\s*/g, '')
    value = value.replace(/\|/gi, '\\|')
    if value.length >= @suggestionKeystrokeMinimum
      clear = document.createElement('div')
      clear.style.cssText = 'clear:both; overflow:hidden; height:' + (if document.compatMode == 'BackCompat' then 1 else 0) + 'px; background-color:#ffffff'
      clear.appendChild document.createTextNode('.')
      matchCount = 0
      if @data != null
        reliance.domUtilities.clearChildNodes @list
        re = new RegExp('\\b' + value + '.*?\\b', 'gi')
        i = 0
        while i < @data.length
          if @data[i].suggestion.match(re)
            @list.appendChild _createItem.apply(this, [
              @data[i]
              matchCount
            ])
            matchCount++
          i++
        @list.appendChild clear
        _handleDisplay.apply this, [ matchCount ]
      else
        dataSource = @dataSource + (if @dataSource.indexOf('?') == -1 then '?' else '&') + (if @version == 2 then 'term=' else 'q=') + value
        reliance.xDomainHttpRequest.abort _city
        _city = reliance.xDomainHttpRequest.create('http://' + reliance.loader.proxyHost() + '/proxy/' + dataSource, this, ((response) ->
          `var i`
          reliance.domUtilities.clearChildNodes @list
          index = 0
          i = 0
          while i < response.length
            if @version == 2 and response[i].type and (i == 0 or response[i].type != response[i - 1].type)
              @list.appendChild _createTitle.apply(this, [ response[i].type ])
              index++
            @list.appendChild _createItem.apply(this, [
              response[i]
              index
            ])
            index++
            i++
          @list.appendChild clear
          #_handleDisplay.apply(this, [response.length]);
          _handleDisplay.apply this, [ index ]
          return
        ), silent: true)
    return

  _handleDisplay = (matches) ->
    `var i`
    # The "this" keyword refers to the SuggestionField object
    mode = if matches > 0 then 1 else 0
    display = 
      0: 'none'
      1: 'block'
    @list.style.display = display[mode]
    @highlightIndex = -1
    height = matches * _rowHeight
    if matches > _maxRows
      height = _maxRows * _rowHeight
      scrollCorrection = if @version == 2 then 0 else reliance.browser.scrollbarWidthCorrection()
      i = 0
      while i < @list.childNodes.length - 1
        item = @list.childNodes[i]
        primaryNode = item.childNodes[0]
        item.style.width = item.offsetWidth - scrollCorrection + 'px'
        primaryNode.style.width = primaryNode.offsetWidth - scrollCorrection + 'px'
        i++
    if @version != 2
      @list.style.height = height + (if document.compatMode == 'BackCompat' then (if reliance.browser.isIE() then 3 else 1) else 0) + 'px'
    if mode != 0
      offset = reliance.domUtilities.getOffset(@field)
      @list.style.left = offset.x + 'px'
      @list.style.top = offset.y + @field.offsetHeight + 1 + 'px'
      if @version == 2
        index = 0
        i = 0
        while i < @list.childNodes.length
          if @list.childNodes[i].className == 'rn-search-location-title' or i == @list.childNodes.length - 1
            if i - index - 1 >= 10
              @list.childNodes[index].firstChild.style.width = 'auto'
              @list.childNodes[index].firstChild.appendChild document.createTextNode(' (first 10)')
            index = i
          i++
    return

  _unhighlight = ->
    # The "this" keyword refers to the SuggestionField object
    @style.backgroundColor = '#ffffff'
    @childNodes[0].style.color = '#000000'
    if @childNodes[1]
      @childNodes[1].style.color = '#999999'
    return

  _highlight = (displayIndex, mouseEvent) ->
    # The "this" keyword refers to the SuggestionField object
    if displayIndex > @list.childNodes.length - 2
      displayIndex = -1
    if displayIndex < -1
      displayIndex = @list.childNodes.length - 2
    if @highlightIndex == -1
      @userText = @field.value
    else
      _unhighlight.apply @list.childNodes[@highlightIndex]
    if displayIndex > -1 and displayIndex < @list.childNodes.length - 1
      node = @list.childNodes[displayIndex]
      node.style.backgroundColor = '#d21f26'
      node.childNodes[0].style.color = '#ffffff'
      if node.childNodes[1]
        node.childNodes[1].style.color = '#edb3b6'
      if !mouseEvent
        @field.value = _getInnerText.apply(node.childNodes[0])
    else
      @field.value = @userText
    if (displayIndex + 1) * _rowHeight > @list.scrollTop + _maxRows * _rowHeight
      @list.scrollTop = (displayIndex + 1 - _maxRows) * _rowHeight
    else if displayIndex * _rowHeight < @list.scrollTop
      @list.scrollTop = displayIndex * _rowHeight
    @highlightIndex = displayIndex
    return

  _selectItem = (dataItem) ->
    # The "this" keyword refers to the SuggestionField object
    @setValue if @version == 2 then dataItem.label else dataItem.suggestion
    _handleDisplay.apply this, [ 0 ]
    if @method
      callback = reliance.event.callbackArgs(null, @method, if dataItem.arguments then dataItem.arguments else dataItem)
      callback.apply()
    return

  _createItem = (dataItem, displayIndex) ->
    # The "this" keyword refers to the SuggestionField object
    #var itemWidth = this.width - (_getBorderCorrection() * (document.compatMode == 'BackCompat' ? 2 : 1));
    noSuggestions = @version == 2 and dataItem == 'No Suggestions'
    itemWidth = @width - _getBorderCorrection()
    if reliance.browser.isIE()
      if document.compatMode == 'BackCompat'
        itemWidth -= _getBorderCorrection()
    else if !reliance.browser.isFirefox()
      itemWidth -= _getBorderCorrection()
    nodeContentWidth = itemWidth - (_textPadding * 2)
    primaryInfo = document.createElement('div')
    primaryInfo.style.cssText = 'position:absolute; white-space:nowrap; font-family:Arial, sans-serif; overflow:hidden; text-overflow:ellipsis; font-size:9pt; left:' + _textPadding + 'px; top:2px; zIndex:1; float:left; color:#000000; width:' + nodeContentWidth + 'px'
    primaryInfo.appendChild document.createTextNode(if @version == 2 then (if !noSuggestions then dataItem.label else dataItem) else dataItem.suggestion)
    item = document.createElement('div')
    item.style.cssText = 'position:relative; float:left; width:' + itemWidth + 'px; height:' + _rowHeight + 'px; background-color:#ffffff;' + (if !noSuggestions then 'cursor:pointer' else '')
    if !noSuggestions
      item.onmouseover = reliance.event.callbackArgs(this, _highlight, displayIndex, true)
      item.onclick = reliance.event.callbackArgs(this, _selectItem, dataItem)
    item.appendChild primaryInfo
    if @displayInfo and dataItem.info
      secondaryNodeWidth = nodeContentWidth * @infoSize / 100
      primaryInfo.style.width = nodeContentWidth - secondaryNodeWidth + 'px'
      secondaryInfo = primaryInfo.cloneNode(false)
      secondaryInfo.style.fontSize = '7.5pt'
      secondaryInfo.style.left = ''
      secondaryInfo.style.right = _textPadding + 'px'
      secondaryInfo.style.top = '3px'
      secondaryInfo.style.width = secondaryNodeWidth + 'px'
      secondaryInfo.style.zIndex = 0
      secondaryInfo.style.cssFloat = 'right'
      secondaryInfo.style.styleFloat = 'right'
      secondaryInfo.style.textAlign = 'right'
      secondaryInfo.style.color = '#999999'
      secondaryInfo.appendChild document.createTextNode(dataItem.info)
      item.appendChild secondaryInfo
    item

  _getInnerText = ->
    # The "this" keyword refers to the SuggestionField object
    if @innerText
      return @innerText
    @textContent

  _createTitle = (type) ->
    title = undefined
    method = undefined
    switch type
      when 1
        title = 'Cities'
        method = 'City'
      when 2
        title = 'Neighborhoods'
        method = 'Neighborhood'
      else
        title = type
        method = 'All'
        break
    div = document.createElement('div')
    div.className = 'rn-search-location-title'
    div.style.width = @width - _getBorderCorrection() + 'px'
    content = document.createElement('div')
    content.appendChild document.createTextNode(title)
    div.appendChild content
    div

  SuggestionField::setValue = (value) ->
    @field.value = value
    return

  SuggestionField::getValue = ->
    @field.value

  _city = undefined
  return

# ---
# generated by js2coffee 2.2.0