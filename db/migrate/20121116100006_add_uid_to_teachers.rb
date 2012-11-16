class AddUidToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :uid, :string
  end
end
