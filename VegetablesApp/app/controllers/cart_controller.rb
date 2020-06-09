class CartController < ApplicationController
  # Metodo para mostrar la lista de la compra
  def showcart
    @productscart = Product.find session[:products]

  end

  # Metodo para añadir productos a la lista de la compra
  def addprod
    (session[:products] ||= []) << params[:item].to_i
  end
end
