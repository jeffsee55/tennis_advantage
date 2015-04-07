$ ->
  $("svg > [id^=content-]").hover ->
    $(@).find("rect").toggleClass("svg-hover")
    $(@).click ->
      id = $(@).attr('id')
      input = id.substr(8)[0]
      console.log input
      $("[id^=content_#{input}] input").click()

  $("#input_a").on "change", ->
    if $(this).is(":checked")
      $("body").addClass "modal-open"
    else
      $("body").removeClass "modal-open"
    return

  $(".modal-window").on "click", ->
    $(".modal-state:checked").prop("checked", false).change()
    return

  $(".modal-inner").on "click", (e) ->
    e.stopPropagation()
    return

  $("svg > #content-slideshow").click ->
    window.location = "/admin/slide_images"
