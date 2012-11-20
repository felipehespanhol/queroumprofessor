# encoding: utf-8
class TeachersController < ApplicationController
  def home
  end

  def search_results
    @city_with_abbr = "#{params[:location] && params[:location][:name]}"
    @city = Cidade.where("nome = ?", get_clean_city_name(@city_with_abbr)).first
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
      city_name_match = city_with_abbr.match(/([A-Za-z\s]+)/)
      city_name_match = city_name_match[1] if city_name_match
      return city_name_match
    end

end
