class ProductsController < ApplicationController
  before_action :force_json, only: :autocomplete
  def index
    session[:products] ||= []

    @products = Product.where(cistell: false)
    @products_cist =  Product.where(cistell: true)
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end

    @products = @products.uniq{ |product| [product.name] }
    @products_cist =  @products_cist.uniq{ |product| [product.name] }
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
    @product.cistell = params[:cist]
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
    @product.cistell = params[:cist]
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
    @products = Product.ransack(name_cont: params[:search]).result(distinct: true).limit(5).where(cistell: false)
    @products_cist = Product.ransack(name_cont: params[:search]).result(distinct: true).limit(5).where(cistell: true)
  end

  private
  def product_params
    params.require(:product).permit(:name, :image, :stock, :description, :price, category_ids: [])
  end

  def force_json
    request.format = :json
  end

  def get_cart_information
    # Obtenemos los productos de la cesta
    if session[:products]
      @productscart = Product.find session[:products]
      # Calculamos el total de productos
      @numproducts = session[:products].count.to_i
      @hayproducts = @numproducts > 0

      @totalprice = 0.0

      # Calculamos el precio total de la cesta
      @productscart.uniq.each do |product|
        # Multiplicacmos el precio por la cantidad seleccionada
        @totalprice += product.price.to_f * session[:products].count( product.id ).to_i
      end

      # Redondeamos a 2 decimales el precio
      @totalprice = @totalprice.round(2)
    end
  end
end

