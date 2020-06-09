class CategoriesController < ApplicationController

  def index
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @categories = Category.all
    @categories = @categories.uniq{ |product| [product.name] }
  end

  def edit
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @category = Category.find(params[:id])
    @products = Product.all
  end

  def delete
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @category = Category.find(params[:id])
    @category.destroy
  end

  def new
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @category = Category.new
    @products = Product.all
  end


  def update
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @category = Category.find params[:id]
    if @category.update_attributes(category_params)
      redirect_to '/categories'
    else
      redirect_to '/categories/'+@category.id.to_s+'/edit'
    end
  end

  def create
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @category = Category.new(category_params)
    if @category.save
      redirect_to '/categories'
    else
      redirect_to('/categories/new')
    end
  end

  def show
    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
    @category = Category.find(params[:id])
    @products = @category.products
  end

  private
  def category_params
    params.require(:category).permit(:name, product_ids: [])
  end
end
