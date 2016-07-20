randomSlide = Math.floor(Math.random() * 4) + 1
$('.rn-home-page').attr 'style', 'background-image: url(img/home-bg-' + randomSlide + '.jpg)'

$ ->
	qs = setInterval((->
		if $('.rn-qsr').length > 0
			$('.rn-qsr-cz-f').attr('placeholder', 'Enter City, Zip, Address or MLS Numbe').removeAttr 'style'
			$('.rn-qsr-mn-f option').eq(0).html 'Min'
			$('.rn-qsr-mx-f option').eq(0).html 'Max'
			$('.rn-qsr-button').replaceWith '<button onclick="submitForm()" class="rn-qsr-button" type="submit"><i class="rn-icon-search"></i></button>'
			$('<div class="rn-qsr-selects"></div>').appendTo $('.rn-qsr form')
			$('.rn-qsr-mn').appendTo '.rn-qsr-selects'
			$('.rn-qsr-mx').appendTo '.rn-qsr-selects'
			$('.rn-qsr-clearctr').remove()
			clearInterval qs
		return
	), 200)
	return
