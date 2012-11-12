class SpecialitiesController < ApplicationController
  def find
    if params[:term]
      @specialities = Speciality.where("name like ?", "#{params[:term]}%")
    else
      @specialities = Speciality.all
    end
    list = @specialities.map {|s| Hash[id: s.id, label: s.name.downcase, name: s.name]}
    render :json => list
  end

end
