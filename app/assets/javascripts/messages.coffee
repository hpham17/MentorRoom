# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#clear-all').click (e) ->
    $.post '/notifications/clear'
  $('.notifications').click ->
    $.post '/notifications/clear', { message_id: $(this).data('message-id') }
