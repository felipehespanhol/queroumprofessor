class Teacher < ActiveRecord::Base
  attr_accessible :email, :name, :cidade, :contact, :cidade_id, :estado_id, :estado, :tel, :description, :specialities_attributes

  has_many :authorizations
  belongs_to :estado
  belongs_to :cidade
  has_and_belongs_to_many :specialities, :uniq => true

  validates :name, :email, :presence => true
  validate :cidade_belongs_to_estado

  def cidade_belongs_to_estado
    if estado_id && cidade_id
      e = Estado.find(estado_id)
      c = Cidade.find(cidade_id)
    end
    if e && c
      return true if c.estado_id == estado_id
    end
    return false
  end

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
