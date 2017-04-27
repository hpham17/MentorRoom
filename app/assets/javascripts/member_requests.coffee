# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.member-request').click ->
    $.post "/member_requests/?user_id=#{$('.member-request').attr('data-id')}&organization_id=#{$(this).attr('data-organization-id')}"
    , (data) ->
        $("a[data-organization-id='#{data.organization_id}']").html "PENDING"
    return false
