$ ->
  $("[id^=content-]").hover ->
    $(@).find("rect").toggleClass("svg-hover")
  $("[id^=content-]").click ->
    id = $(@).attr('id')
    input = id.substr(id.length - 1)
    console.log input
    $("#content_#{input} input").click()

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
