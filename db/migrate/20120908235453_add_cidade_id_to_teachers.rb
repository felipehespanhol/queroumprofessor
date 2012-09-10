class AddCidadeIdToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :cidade_id, :integer
  end
end
