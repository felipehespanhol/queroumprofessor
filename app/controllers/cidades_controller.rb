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

  def find_by_estado
    respond_to do |format|
      format.html { render :nothing }
      format.json do
        @cidades = Cidade.where("estado_id = ?", params[:estado_id])
        render :json => @cidades
      end
    end
  end
    
end
