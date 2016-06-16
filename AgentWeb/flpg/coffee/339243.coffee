carousel = $('#homeSlider')
carousel.slick()

$ ->
	qs = setInterval((->
		if $('.rn-qsr').length > 0
			$('.rn-qsr-cz-f').attr('placeholder', 'Enter City, Zip, Address or MLS Numbe').removeAttr 'style'
			$('.rn-qsr-mn-f option').eq(0).html '$ Min'
			$('.rn-qsr-mx-f option').eq(0).html '$ Max'
			$('.rn-qsr-bd-f option').eq(0).html 'Beds'
			$('.rn-qsr-ba-f option').eq(0).html 'Bath'
			$('.rn-qsr-button').replaceWith '<button onclick="submitForm()" class="rn-qsr-button" type="submit"><i class="rn-icon-search"></i></button>'
			$('#quickSearchLink').insertBefore '.rn-qsr-button'
			clearInterval qs
		return
	), 200)
	return

$ ->
	fp = setInterval((->
		if $('.rn-fp').length > 0
			i = 1
			while i <= 2
				div = '.rn-fp div:first-of-type .rn-fp-c:nth-of-type(' + i + ') '
				oldLinkPath = 'modules/internet/search/includes/mapsearch/listingpopup.asp'
				link = $(div + 'div.rn-fp-photo a').attr('href')
				link = link.replace(oldLinkPath, '')
				img = $(div + 'div.rn-fp-photo img:nth-child(3)').attr('src')
				city = $(div + '#rn-fp-info-value-city').html()
				price = $(div + '#rn-fp-info-value-list-price').html()
				$('<article class="rn-home-featured-listing"><a href="' + link + '"><div class="" style="background-image: url(' + img + ')"></div><ul><li><span>City</span>' + city + '</li><li><span>Price</span>' + price + '</li><ul><button>View Details <i class="rn-icon-triangle-right"></i></button></a></article>').appendTo '#featuredListings'
				i++
			$('.rn-fp').remove()
			clearInterval fp
		return
	), 400)
	return
	