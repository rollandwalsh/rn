randomSlide = Math.floor(Math.random() * $('.rn-home-carousel > div').length)
carousel = $('.rn-home-carousel')
carousel.slick(
	infinite: true
	autoplay: true
	autoplaySpeed: 10001
	slidesToShow: 1
	slidesToScroll: 1
	arrows: false
	fade: true
	slickGoTo: randomSlide
)

$ ->
	qs = setInterval((->
		if $('.rn-qsr').length > 0
			$('.rn-qsr-mn-f option').eq(0).html '$Min'
			$('.rn-qsr-mx-f option').eq(0).html '$Max'
			$('.rn-qsr-bd-f option').eq(0).html 'Beds'
			$('.rn-qsr-ba-f option').eq(0).html 'Baths'
			$('.rn-qsr-button').replaceWith '<button onclick="submitForm()" class="rn-qsr-button" type="submit">Go <i class="rn-icon-angle-right-medium"></i></button>'
			clearInterval qs
		return
	), 200)
	return

$('#-wf-col-2').addClass('rn-home-content-main')
$('#-wf-col-3').addClass('rn-home-content-secondary')
$('#-wf-col-2, #-wf-col-3').wrapAll('<section class="rn-home-content"></section>')
$('.rn-home-social-links').appendTo('#-wf-col-3')
