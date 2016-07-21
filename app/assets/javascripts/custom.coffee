$(document).on 'ready page:load', ->
  $('#search_btn').hover ->
    $('#search_bar').show 'slide', { direction: 'left' }, 1000

  $('#advance_search_btn').click ->
    $('#advance_search_form').toggle()
