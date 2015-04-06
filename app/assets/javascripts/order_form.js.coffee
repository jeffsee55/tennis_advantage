$ ->
  $('.open-form').click ->
    $('.order-form').slideToggle()
  $('.close-form').click ->
    $('.order-form').slideToggle()
  $('#order_hand_deliver').click ->
    if $(@).is(":checked")
      $('.shipping').hide()
    else
      $('.shipping').show()
