# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$ ->
  $(".container").css("width", "100%")
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

  update_estado = () ->
    estado_id = $("#teacher_estado_id").val()
    select = $("<select id='teacher_cidade_id' name='teacher[cidade_id]'></select>")
    selected = parseInt $("#cidade_id").val() 
    $.get '/cidades/find_by_estado.json', {"estado_id": estado_id}, (data)-> 
      $.each data, (index, cidade)-> 
        if selected is cidade.id
          select.append("<option value='#{cidade.id}' selected='selected'>#{cidade.nome}</option>")
        else
          select.append("<option value='#{cidade.id}'>#{cidade.nome}</option>")
        $("#empty_cities").html(select)
  
  if $("#teacher_estado_id")
    update_estado()

  $("#teacher_estado_id").change ()->
    update_estado()

  $("#include_speciality_button").click ()->
    teacher_id = $("#teacher_id").val()
    speciality_id = $("#specialities_list_id").val()
    $.ajax
      url: "/teachers/#{teacher_id}/add_speciality/#{speciality_id}"
      dataType: "html"
      statusCode: 
        500: ()->
          $(".messages").html("<div class='alert alert-error' ><button class='close' data-dismiss='alert' type='button'>x</button>Verifique se a especialidade escolhida já não está inclusa em seu perfil.</div>")
          button = $(".messages").find("button")
          button.alert() if button
        #404: ()->
        #  $(".messages").html("<div class='alert alert-error'>Não houve resposta do servidor... Tente mais tarde ou verifique a sua conexão</div>")
      success: (data, textStatus, jqXHR) ->
        $("#teacher_specialities_list").append(data)

  $(".remove_speciality").live "click", ()->
    teacher_id = $("#teacher_id").val()
    speciality_id = /teacher_speciality_(.+)/.exec $(this).attr("id")
    teacher_speciality_button = $(this).parent()
    $.post "/teachers/#{teacher_id}/remove_speciality/#{speciality_id[1]}", ()->
      teacher_speciality_button.remove()
       

