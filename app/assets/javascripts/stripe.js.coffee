$ ->
  return if typeof Stripe == 'undefined'
  Stripe.setPublishableKey($("meta[name='stripe-key']").attr('content'))
  charge.setupForm()

charge = 
  setupForm: ->
    $("new_tip").on "submit", ->
      $("#stripe-error").text("")
      $("input[type=submit]").attr('disabled', true)
      if $("#card_number").length
        charge.processCard()
        false
      else
        true

  processCard: ->
    card = 
      number:   $("#card_number").val()
      ccv:      $("#card_cvc").val()
      expMonth: $("#card_month").val()
      expYear:  $("#card_year").val()
    Stripe.createToken(card, charge.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if (response.error)
      $("#stripe-error").text(response.error.message)
      $("input[type=submit]").attr('disabled', false)
    else
      $("#stripe_card_token").val(response.id)
      $("#new_tip")[0].submit()