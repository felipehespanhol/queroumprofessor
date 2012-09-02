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

      
	
