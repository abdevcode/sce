class ClientsController < ApplicationController
  def index
    if current_client
      @client ||= Client.find_by(id: current_client.id)
    else
      redirect_to '/products'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def delete
    @client = Client.find(params[:id])
    @client.destroy
  end

  def new
    @client = Client.new
  end


  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
      sign_in(@client, :bypass=>true)
      redirect_to '/clients'
    else
      redirect_to '/clients/'+@client.id.to_s+'/edit'
    end
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      sign_in(@client, :bypass=>true)
      redirect_to '/clients'
    else
      redirect_to('/clients/new')
    end
  end

  def show
    @client ||= Client.find_by(id: current_client.id)
  end

  def after_sign_in_path_for(resource)
    '/clients'
  end

  private
  def client_params
    params.require(:client).permit(:name, :surname, :zip, :address, :city, :age, :email, :password, :gender)
  end
end
