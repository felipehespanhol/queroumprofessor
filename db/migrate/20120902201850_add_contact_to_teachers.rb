class AddContactToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :contact, :string
  end
end
