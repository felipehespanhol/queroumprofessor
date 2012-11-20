# encoding: utf-8
class TeachersController < ApplicationController
  def home
  end

  def search_results
    @city_with_abbr = "#{params[:location] && params[:location][:name]}"
    @city_name = get_clean_city_name(@city_with_abbr)
    @state_sigla = get_state_sigla(@city_with_abbr)
    if @city_name && @state_sigla
      @city = Cidade.joins(:estado).where("cidades.nome = ? and estados.sigla = ?", @city_name, @state_sigla).first
    # In case it doesn't find any city with there criteria, search for the city without state sigla
    elsif @state_sigla.nil?
      @related_cities = Cidade.where("nome = ?", @city_name)
      @city = @related_cities.first if @related_cities.count == 1
    end
    @speciality = Speciality.where("name = ?", "#{params[:speciality] && params[:speciality][:name]}").first
    @teachers = []
    if @speciality && @city
      @teachers = Teacher.joins(:specialities).where(["specialities.id = ? and teachers.cidade_id = ?", @speciality.id, @city.id]).page params[:page]
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
    @estados = Estado.all
    @specialities = Speciality.order("name")
  end

  def update
    @teacher = Teacher.find(params[:id])

    if @teacher.update_attributes(params[:teacher])
      redirect_to root_path, :notice => "Dados atualizados com sucesso"
    else
      @estados = Estado.all
      @specialities = Speciality.order("name")
      flash[:warning] = "Você ainda não informou suas especialidades." if @teacher.specialities.empty?
      render "edit", :notice => "teste"
    end
  end

  def add_speciality
    @teacher = Teacher.find(params[:teacher_id])
    @speciality = Speciality.find(params[:speciality_id])

    respond_to do |format|
      # There won't be repeated specialities for a teacher
      if @teacher.specialities.where("id = ?", @speciality.id).empty?
        @teacher.specialities << @speciality
        format.html { render :partial => "teacher_speciality_button", :locals => {:s => @speciality, :teacher => @teacher} }
        format.json { render :json    => {:status => "Especialidade criada com sucesso."} }
      else
        format.html { render :nothing }
        format.json { render :json => {:status => "Professor já possui especialidade."} }
      end
    end
  end

  def remove_speciality
    @teacher = Teacher.find(params[:teacher_id])
    @speciality = Speciality.find(params[:speciality_id])

    respond_to do |format|
      # There won't be repeated specialities for a teacher
      if @teacher && @speciality
        @teacher.specialities.destroy(@speciality)
        format.html { render :partial => "teacher_speciality_button", :locals => {:s => @speciality, :teacher => @teacher} }
        format.json { render :json    => {:status => "Especialidade criada com sucesso."} }
      else
        format.html { render :nothing }
        format.json { render :json => {:status => "Professor já possui especialidade."} }
      end
    end
  end

  private

    # Tirar a sigla de estado q vem no termo da busca
    def get_clean_city_name(city_with_abbr)
      if city_with_abbr
        city_name_match = city_with_abbr.match(/([A-Za-zçã\s]*).*/)
        city_name_match = city_name_match[1] if city_name_match
      end
      return city_name_match
    end

    def get_state_sigla(city_with_abbr)
      if city_with_abbr
        state_name_match = city_with_abbr.match(/.*,\s*([A-Za-z]{2})/)
        state_name_match = state_name_match[1] if state_name_match
      end
      return state_name_match
    end

end
