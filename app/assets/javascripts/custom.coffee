$(document).on 'ready page:load', ->
  $('#search_btn').hover ->
    $('#search_bar').show 'slide', { direction: 'left' }, 1000

  $('#advance_search_btn').click ->
    $('#advance_search_form').toggle()

  $ ->
  $('.dropdown').hover (->
    $('.dropdown-menu', this).stop(true, true).fadeIn 'fast'
    $(this).toggleClass 'open'
    $('b', this).toggleClass 'caret caret-up'
    return
  ), ->
    $('.dropdown-menu', this).stop(true, true).fadeOut 'fast'
    $(this).toggleClass 'open'
    $('b', this).toggleClass 'caret caret-up'
