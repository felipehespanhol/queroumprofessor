class Speciality < ActiveRecord::Base
  attr_accessible :area_id, :name

  has_and_belongs_to_many :teachers
end
