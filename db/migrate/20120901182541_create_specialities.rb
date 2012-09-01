class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.string :name
      t.integer :area_id

      t.timestamps
    end
  end
end
