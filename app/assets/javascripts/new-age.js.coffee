$ ->
  $('a.page-scroll').bind 'click', (event) ->
    $anchor = $(this)
    $position = $($anchor.attr('href')).offset().top - 50
    $('html, body').stop().animate { scrollTop: $position }, 1250, 'swing'
    event.preventDefault()
    return
  $('.navbar-collapse ul li a').click ->
    $('.navbar-toggle:visible').click()
    return
  # Closes the Responsive Menu on Menu Item Click
  $('body').scrollspy({ target: '#mainNav', offset: 100 })
  return

