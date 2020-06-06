class ProductsController < ApplicationController
  def index
    @products = Product.all
    @products = @products.uniq{ |product| [product.name] }
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def delete
    @product = Product.find(params[:id])
    @product.destroy
  end

  def new
    @product = Product.new
    @categories = Category.all
  end


  def update
    @product = Product.find params[:id]
    if @product.update_attributes(product_params)
      redirect_to '/products'
    else
      redirect_to '/products/'+@product.id.to_s+'/edit'
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to '/products'
    else
      redirect_to('/products/new')
    end
  end

  def show
    @product = Product.find(params[:id])
    @categories = @product.categories
  end

  private
  def product_params
    params.require(:product).permit(:name, :image, :stock, :description, :price, category_ids: [])
    end
end

