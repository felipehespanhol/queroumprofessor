class Authorization < ActiveRecord::Base
  attr_accessible :provider, :teacher_id, :teacher, :uid

  belongs_to :teacher
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      teacher = Teacher.create :name => auth_hash["info"]["name"]
      auth = create :teacher => teacher, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end

    auth
   end

end
