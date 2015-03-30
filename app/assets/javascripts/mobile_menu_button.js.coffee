$ ->
  $("#mobile-menu-open").click ->
    console.log "Click"
    $(".nav-menu").css(
      "display": "-webkit-box"
      "display": "-moz-box"
      "display": "-ms-flexbox"
      "display": "-webkit-flex"
      "display": "flex"
    )
  $("#mobile-menu-close").click ->
    console.log "Click"
    $(".nav-menu").css(
      "display":"none"
    )
