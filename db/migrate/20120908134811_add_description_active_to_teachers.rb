class AddDescriptionActiveToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :description, :string
    add_column :teachers, :active, :boolean
  end
end
