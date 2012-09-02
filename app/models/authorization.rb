class Authorization < ActiveRecord::Base
  attr_accessible :provider, :teacher_id, :uid
  belongs_to :teacher
  validates :provider, :uid, :presence => true

end
