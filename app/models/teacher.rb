class Teacher < ActiveRecord::Base
  attr_accessible :email, :name, :speciality, :cidade

  has_many :authorizations
  belongs_to :cidade
  belongs_to :speciality
  
  #validates :name, :email, :presence => true
  
  def city_with_abbr
    "#{cidade.nome}, #{cidade.estado.sigla}"
  end

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :teacher_id => self.id, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end


end
