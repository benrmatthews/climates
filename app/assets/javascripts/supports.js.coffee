# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $support_body = $('#support_body')
  $filters_trigger = $('.filters-trigger')
  $filters_bar = $('.search-filters')

  setSupportBodyParam = ->
    query = $.param
      support:
        body: $support_body.val()
    $('[data-another-supporter]').attr 'href', "?#{query}"

  setActiveClass = ->
    $('.radio').removeClass('active')
    $(@).addClass('active')

  toggleFilters = (e)->
    $filters_bar.toggle('slow')

    if $filters_trigger.hasClass('filters-hidden')
      $filters_trigger.html('Hide filters').removeClass('filters-hidden')
    else
      $filters_trigger.html('Show filters').addClass('filters-hidden')


  setSupportBodyParam()
  $support_body.on 'change', setSupportBodyParam


  $('.radio').on 'click', setActiveClass
  $('.filters-trigger').on 'click', { what: this }, toggleFilters
