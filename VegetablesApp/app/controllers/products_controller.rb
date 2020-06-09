class ProductsController < ApplicationController
  before_action :force_json, only: :autocomplete
  def index
    session[:products] ||= []

    @products = Product.all
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @products = @products.uniq{ |product| [product.name] }
  end

  def edit
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def delete
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @product = Product.find(params[:id])
    @product.destroy
  end

  def new
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @product = Product.new
    @categories = Category.all
  end


  def update
    if !admin_signed_in?
      @client ||= Client.find_by(id: current_client.id)
    end
    @product = Product.find params[:id]
    if @product.update_attributes(product_params)
      redirect_to '/products'
    else
      redirect_to '/products/'+@product.id.to_s+'/edit'
    end
  end

  def create
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @product = Product.new(product_params)
    if @product.save
      redirect_to '/products'
    else
      redirect_to('/products/new')
    end
  end

  def show
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @product = Product.find(params[:id])
    @categories = @product.categories
  end

  def autocomplete
    @products = Product.ransack(name_cont: params[:search]).result(distinct: true).limit(5)
  end

  def search
    @products = Product.ransack(name_cont: params[:search]).result(distinct: true).limit(5)
  end

  private
  def product_params
    params.require(:product).permit(:name, :image, :stock, :description, :price, category_ids: [])
  end

  def force_json
    request.format = :json
  end
end

