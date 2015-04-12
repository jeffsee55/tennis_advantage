$ ->
  $("#mobile-menu-open").click ->
    $(".nav-menu").addClass("display-flex")
  $("#mobile-menu-close").click ->
    $(".nav-menu").removeClass("display-flex")
