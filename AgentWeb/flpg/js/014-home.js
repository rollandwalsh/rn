var carousel, randomSlide;

randomSlide = Math.floor(Math.random() * $('.rn-home-carousel > div').length);

carousel = $('.rn-home-carousel');

carousel.slick({
  infinite: true,
  autoplay: true,
  autoplaySpeed: 10001,
  slidesToShow: 1,
  slidesToScroll: 1,
  arrows: false,
  fade: true,
  slickGoTo: randomSlide
});

$(function() {
  var qs;
  qs = setInterval((function() {
    if ($('.rn-qsr').length > 0) {
      $('.rn-qsr-cz-f').attr('placeholder', 'Enter Location or MLS#').removeAttr('style');
      $('.rn-qsr-button').replaceWith('<button onclick="submitForm()" class="rn-qsr-button" type="submit"><i class="rn-icon-search"></i></button>');
      clearInterval(qs);
    }
  }), 200);
});
