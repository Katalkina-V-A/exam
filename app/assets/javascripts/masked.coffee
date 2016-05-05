ready = ->
  $("[data-masked=date]").mask('99.99.9999')
  $("[data-masked=number]").mask('(999)999-99-99')
  false

$(document).ready ready
$(document).on 'page:load', ready
