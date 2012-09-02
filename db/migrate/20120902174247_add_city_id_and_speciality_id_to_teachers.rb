class AddCityIdAndSpecialityIdToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :cidade_id, :integer
    add_column :teachers, :speciality_id, :integer
  end
end
