# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$ ->
  $("#speciality_name").autocomplete
    source: "/specialities/find"
    select: (event, ui) -> $("#speciality_name").val(ui.item.name)

  $("#location_name").autocomplete
    source: "/cidades/find"
    select: (event, ui) -> $("#location_name").val(ui.item.name)

  $("#search_teacher_form button").click (event) ->
    if $("#speciality_name").val() == ""
      message = "Escolha uma especialidade para o seu professor. No que ele é fera?"
    else if $("#location_name").val() == ""
      message = "Escolha uma cidade para o seu professor. Onde você mora?"
    if message
      $("#messages").html("<div class='alert alert-block'>#{message}</div>")
      event.preventDefault()

      
	
