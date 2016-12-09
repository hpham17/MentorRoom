# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#mentor-signup').click ->
    $('#signup-title').html "Mentor Sign Up";
    $('input#user_role').val('Mentor')
  $('#mentee-signup').click ->
    $('#signup-title').html "Mentee Sign Up";
    $('input#user_role').val('Mentee')

  $('.chips').material_chip();




  $.get '/events', {}, (data) ->
    $('#calendar').fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,agendaWeek,agendaDay,listWeek'
      navLinks: true
      editable: true
      eventLimit: true
      events: data
      eventClick: (calEvent) ->
        $toastContent = $("<span>#{calEvent.title}<br>#{calEvent.start.toString()}</span>");
        Materialize.toast($toastContent, 5000, 'rounded');
        return

  $('.timepicker').pickatime({
    autoclose: true,
    twelvehour: true
  });
  $('select').material_select();
  $ ->
    $('.date').datetimepicker();

  $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrain_width: false,
      gutter: 0,
      belowOrigin: false,
      alignment: 'left'
    }
  );

  $(".checkbox-skill input[type=checkbox]").click ->
    $.post '/tag', {skill: $(this).val()}, (data) ->
      $(data).appendTo($('.skill-list'))

  $('.skill-list .chip .close').click ->
    data= $($(this).closest('.chip').contents()[0]).text();
    $.ajax
      url: '/tag'
      type: 'DELETE',
      data:
        skill: data

  $(".checkbox-help input[type=checkbox]").click ->
    $.post '/tag', {help: $(this).val()}, (data) ->
      $(data).appendTo($('.help-list'))

  $('.help-list .chip .close').click ->
    data= $($(this).closest('.chip').contents()[0]).text();
    $.ajax
      url: '/tag'
      type: 'DELETE',
      data:
        help: data

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

  #jQuery time
  current_fs = undefined
  next_fs = undefined
  next_next_fs = undefined
  previous_fs = undefined
  #fieldsets
  left = undefined
  opacity = undefined
  scale = undefined
  #fieldset properties which we will animate
  animating = undefined
  #flag to prevent quick multi-click glitches
  $('.next').click ->
    if animating
      return false
    animating = true
    current_fs = $(this).parent()
    next_fs = $(this).parent().next()
    #activate next step on progressbar using the index of next_fs
    $('#progressbar a').eq($('.fieldset').index(next_fs)).addClass 'active'
    #show the next fieldset
    next_fs.show()
    #hide the current fieldset with style
    current_fs.animate { opacity: 0 },
      step: (now, mx) ->
        #as the opacity of current_fs reduces to 0 - stored in "now"
        #1. scale current_fs down to 80%
        scale = 1 - ((1 - now) * 0.2)
        #2. bring next_fs from the right(50%)
        left = now * 50 + '%'
        #3. increase opacity of next_fs to 1 as it moves in
        opacity = 1 - now
        current_fs.css 'transform': 'scale(' + scale + ')'
        next_fs.css
          'left': left
          'opacity': opacity
        return
      duration: 800
      complete: ->
        current_fs.hide()
        animating = false
        return
      easing: 'easeInOutBack'
    return
  $('.prev').click ->
    if animating
      return false
    animating = true
    current_fs = $(this).parent()
    previous_fs = $(this).parent().prev()
    #de-activate current step on progressbar
    $('#progressbar a').eq($('.fieldset').index(current_fs)).removeClass 'active'
    #show the previous fieldset
    previous_fs.show()
    #hide the current fieldset with style
    current_fs.animate { opacity: 0 },
      step: (now, mx) ->
        #as the opacity of current_fs reduces to 0 - stored in "now"
        #1. scale previous_fs from 80% to 100%
        scale = 0.8 + (1 - now) * 0.2
        #2. take current_fs to the right(50%) - from 0%
        left = (1 - now) * 50 + '%'
        #3. increase opacity of previous_fs to 1 as it moves in
        opacity = 1 - now
        current_fs.css 'left': left
        previous_fs.css
          'transform': 'scale(' + scale + ')'
          'opacity': opacity
        return
      duration: 800
      complete: ->
        current_fs.hide()
        animating = false
        return
      easing: 'easeInOutBack'
    return

$(document).on 'keypress', 'form', (e) ->
  code = e.keyCode or e.which
  if code == 13
    e.preventDefault()
    return false
  return
