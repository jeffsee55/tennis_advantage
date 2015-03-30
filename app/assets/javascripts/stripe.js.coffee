$ ->
  $('#new_order').submit (event) ->
    $form = $(this)
    # Disable the submit button to prevent repeated clicks
    $form.find('button').prop 'disabled', true
    console.log "disabled"
    # Prevent the form from submitting with the default action
    Stripe.createToken {
      number: $('#cc_num').val()
      cvc: $('#cvc').val()
      exp_month: $('#exp_month').val()
      exp_year: $('#exp_year').val()
    }, stripeResponseHandler
    false
  stripeResponseHandler = (status, response) ->
    console.log response
    $form = $('#new_order')
    if response.error
      # Show the errors on the form
      $form.find('.payment-errors').text response.error.message
      $form.find('button').prop 'disabled', false
      console.log response.error.message
    else
      # response contains id and card, which contains additional card details
      token = response.id
      # Insert the token into the form so it gets submitted to the server
      $form.append $('<input type="hidden" name="stripe_token" />').val(token)
      # and submit
      $form.get(0).submit()
    return

