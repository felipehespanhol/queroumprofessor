class Cidade < ActiveRecord::Base
  attr_accessible :estado_id, :nome

  belongs_to :estado
end
