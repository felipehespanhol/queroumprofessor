class AddEstadoIdToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :estado_id, :integer
  end
end
