var bgRotation;

bgRotation = Math.floor(Math.random() * 5 + 1);

$('body').addClass('bg-' + bgRotation);

$(function() {
  var qs;
  qs = setInterval((function() {
    if ($('.rn-qsr').length > 0) {
      $('.rn-qsr-cz-f').attr('placeholder', 'Search by Address, City, Zip Code, or MLS #').removeAttr('style');
      $('.rn-qsr-mn-f option').eq(0).html('$ Min');
      $('.rn-qsr-mx-f option').eq(0).html('$ Max');
      $('.rn-qsr-bd-f option').eq(0).html('Beds');
      $('.rn-qsr-ba-f option').eq(0).html('Baths');
      $('.rn-qsr-button').wrap('<div class="rn-qsr-button-container"></div>');
      clearInterval(qs);
    }
  }), 200);
});
