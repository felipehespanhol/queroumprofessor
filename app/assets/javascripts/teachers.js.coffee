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

  update_estado = () ->
    estado_id = $("#teacher_estado_id").val()
    select = $("#teacher_cidade_id")
    cidade_id = $("#cidade_id").val()
    cidade_id = parseInt(cidade_id, 10)
    select.empty()
    if estado_id
      $.get '/cidades/find_by_estado.json', {"estado_id": estado_id}, (data)-> 
        select.append("<option value=''>Escolha uma cidade</option>")
        $.each data, (index, cidade)-> 
          if cidade_id == cidade.id
            select.append("<option value='#{cidade.id}' selected='selected'>#{cidade.nome}</option>")
          else
            select.append("<option value='#{cidade.id}'>#{cidade.nome}</option>")
    else
      select.append("<option value=''>Escolha um estado</option>")
  
  $("#teacher_estado_id").change ()->
    update_estado()

  if $("#teacher_estado_id").val() != "" && $("#teacher_cidade_id") == ""
    update_estado() # In case of page refreshing with a state selected

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
       

