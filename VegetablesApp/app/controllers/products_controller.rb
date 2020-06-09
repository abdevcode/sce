class ProductsController < ApplicationController
  def index
    session[:products] ||= []

    @products = Product.all
    @products = @products.uniq{ |product| [product.name] }
  end
end
