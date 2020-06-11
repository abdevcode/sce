class HomeController < ApplicationController
  def index

    session[:products] ||= []

    if current_client
      @client ||= Client.find_by(id: current_client.id)
    else
      redirect_to '/products'
    end
  end
end
