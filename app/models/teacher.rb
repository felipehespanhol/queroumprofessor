class Teacher < ActiveRecord::Base
  #attr_accessible :name
  has_many :authorizations

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end
end
