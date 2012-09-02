class CidadesController < ApplicationController
  def find
    if params[:term]
      cidades = Cidade.where("nome like ?", "%#{params[:term]}%")
    else
      cidades = Cidade.all
    end
    list = cidades.map {|c| {:id => c.id, :label => "#{c.nome}, #{c.estado.sigla}", :name => c.nome}}
    render :json => list
  end
end
