var carousel, heroNavBtn;

carousel = $('#homeCarousel');

carousel.slick();

heroNavBtn = $('#homeHeroNav li');

heroNavBtn.on('click', function() {
  var content;
  if ($(this).hasClass('active')) {
    return;
  } else {
    heroNavBtn.removeClass('active');
    $(this).addClass('active');
    $('.rn-home-hero-content').hide();
    content = '#' + $(this).data('content');
    $(content).show();
  }
});

$(function() {
  var qs;
  qs = setInterval((function() {
    if ($('.rn-qsr').length > 0) {
      $('.rn-qsr-cz-f').attr('placeholder', 'Location or MLS').removeAttr('style');
      $('.rn-qsr-mn-f option').eq(0).html('$MIN');
      $('.rn-qsr-mx-f option').eq(0).html('$MAX');
      $('.rn-qsr-button').replaceWith('<button onclick="submitForm()" class="rn-qsr-button" type="submit">Search <i class="rn-icon-angle-right-medium"></i></button>');
      clearInterval(qs);
    }
  }), 200);
});
