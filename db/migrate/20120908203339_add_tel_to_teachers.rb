class AddTelToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :tel, :string
  end
end
