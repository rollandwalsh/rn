var agentsServicesNavBtn, bgRotation, homeScrollTop;

bgRotation = Math.floor(Math.random() * 5 + 1);

$('body').addClass('bg-' + bgRotation);

agentsServicesNavBtn = $('#agentsServicesNav li');

agentsServicesNavBtn.on('click', function() {
  var content;
  if ($(this).hasClass('active')) {
    return;
  } else {
    agentsServicesNavBtn.removeClass('active');
    $(this).addClass('active');
    $('.rn-home-agents-services-content').hide();
    content = '#' + $(this).data('content');
    $(content).show();
  }
});

homeScrollTop = $('#homeScrollTop');

homeScrollTop.on('click', function() {
  return $('html, body').animate({
    scrollTop: 0
  }, 1200);
});

$(function() {
  var qs;
  qs = setInterval((function() {
    if ($('.rn-qsr').length > 0) {
      $('.rn-qsr-cz-f').attr('placeholder', 'Search by Address, City, Zip Code, or MLS #').removeAttr('style');
      $('.rn-qsr-bd-f option').eq(0).html('Beds');
      $('.rn-qsr-mn-f option').eq(0).html('Price');
      $('.rn-qsr-button').replaceWith('<button onclick="submitForm()" class="rn-qsr-button" type="submit">Go!</button>');
      clearInterval(qs);
    }
  }), 200);
});
