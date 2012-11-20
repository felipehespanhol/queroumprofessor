class AddProviderToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :provider, :string
  end
end
