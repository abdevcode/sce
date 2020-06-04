class ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = @products.uniq{ |product| [product.name] }
  end
end
