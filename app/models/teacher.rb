class Teacher < ActiveRecord::Base
  attr_accessible :email, :name, :speciality, :cidade

  has_many :authorizations
  belongs_to :cidade
  belongs_to :speciality
  
  #validates :name, :email, :presence => true
  
  def city_with_abbr
    "#{cidade.nome}, #{cidade.estado.sigla}"
  end

end
