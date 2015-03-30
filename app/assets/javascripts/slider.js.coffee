$ ->
  slideshow = (card) ->
    slides = $(card).find('.product-slider ul li').length
    $(card).find('.product-slider ul').css('width', "#{ 100 * slides }%")
    $(card).find('.product-slider ul li').css('width', "#{ 100 / slides }%")

    i = 0
    console.log "I is #{i}"
    $(card).find(".next").click ->
      $(card).find('.product-slider ul').animate
        left: "-=100%"
      i += 1
      console.log ("Slides: #{slides} | I: #{i}")
      if i <= 0
        $(card).find('.prev').css('display', 'none')
      else
        $(card).find('.prev').css('display', 'flex')
      if i >= ( slides - 1 )
        $(card).find('.next').css('display', 'none')
      else
        $(card).find('.next').css('display', 'flex')
    $(card).find(".prev").click ->
      $(card).find('.product-slider ul').animate
        left: "+=100%"
      i -= 1
      console.log ("Slides: #{slides} | I: #{i}")
      if i <= 0
        $(card).find('.prev').css('display', 'none')
      else
        $(card).find('.prev').css('display', 'flex')
      if i >= ( slides - 1 )
        $(card).find('.next').css('display', 'none')
      else
        $(card).find('.next').css('display', 'flex')
    if i <= 0
      $(card).find('.prev').css('display', 'none')
    else
      $(card).find('.prev').css('display', 'flex')
    if i >= ( slides - 1 )
      $(card).find('.next').css('display', 'none')
    else
      $(card).find('.next').css('display', 'flex')

  $('#image_1_thumb').click ->
    $('.product-slider ul').css('left', '0%')
    i = 0
    $('.prev').css('display', 'none')
    $('.next').css('display', 'flex')
  $('#image_2_thumb').click ->
    $('.product-slider ul').css('left', '-100%')
    i = 1
    $('.prev').css('display', 'flex')
    $('.next').css('display', 'flex')
  $('#image_3_thumb').click ->
    $('.product-slider ul').css('left', '-200%')
    i = 2
    $('.prev').css('display', 'flex')
    $('.next').css('display', 'flex')
  $('#image_4_thumb').click ->
    $('.product-slider ul').css('left', '-300%')
    i = 3
    $('.prev').css('display', 'flex')
    $('.next').css('display', 'none')


  $('.product-card').each ->
    slideshow($(@))
  $('.content-block').each ->
    slideshow($(@))
  slideshow($('.hero-slider'))
