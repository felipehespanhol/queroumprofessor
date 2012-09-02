class TeachersController < ApplicationController
  def home
  end

  def search_results
    @city_with_abbr = "#{params[:location] && params[:location][:name]}"
    city_name_match = @city_with_abbr.match(/([A-Za-z\s]+)/)
    city_name_match = city_name_match[1] if city_name_match
    @city = Cidade.where("nome = ?", city_name_match).first
    @speciality = Speciality.where("name = ?", "#{params[:speciality] && params[:speciality][:name]}").first
    if @speciality && @city
      @teachers = Teacher.where(:speciality_id => @speciality.id, :cidade_id => @city.id)
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
      render :action => "edit"
    end
  end

end
