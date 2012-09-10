class CreateSpecialitiesTeachersJoinTable < ActiveRecord::Migration
  def change
    create_table :specialities_teachers, :id => false do |t|
      t.integer :speciality_id
      t.integer :teacher_id 
    end
  end
end
