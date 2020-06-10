class CartController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_paypaltoken, :only => [:createorder, :onapprove]
  before_action :get_totalprice, :only => [:createorder, :showcart]

  def get_totalprice
    # Obtenemos los productos de la cesta
    @productscart = Product.find session[:products]

    @totalprice = 0.0

    # Calculamos el precio total de la cesta
    @productscart.uniq.each do |product|
      # Multiplicacmos el precio por la cantidad seleccionada
      @totalprice += product.price.to_f * session[:products].count( product.id ).to_i
    end

    # Redondeamos a 2 decimales el precio
    @totalprice = @totalprice.round(2)
  end

  def set_paypaltoken
    # Especificamos nuestro client_id y secret
    paypal_client = "AfhQAyn2RmF3PXoCnNMMpenYijDrFIcAzXtSZB2hSD55El8LfREtvr6hcM8Asqg0ACmhbtV5gttQqyR8"
    paypal_secret =  "EOLio9QqLgE65jLFLDyzjuOHfGu6WKA48FoxJnC-mvDVmTFH345Ztce5uBW_7MAqfdl5TQTz2gXOUfUB"

    auth = {:username => paypal_client, :password => paypal_secret}
    response = HTTParty.post("https://api.sandbox.paypal.com/v1/oauth2/token",
                         :headers => {'Accept' => 'application/json',
                                      'Accept-Language' => 'en_US',
                                      "Content-Type" => "application/x-www-form-urlencoded"},
                         :basic_auth => auth,
                         :body => "grant_type=client_credentials",
                         :debug_output => Rails.logger)
    Rails.logger.debug("Token PayPal: #{response.inspect}")

    # Sacamos a el token
    @paypaltoken = response['access_token']

    Rails.logger.debug("access_token PayPal: #{@paypaltoken}")
  end

  def createorder
    @response = HTTParty.post('https://api.sandbox.paypal.com/v2/checkout/orders',
                                                :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@paypaltoken}"},
                                                :body => {:intent => 'CAPTURE', :purchase_units => [{'amount' => {'currency_code' => 'EUR', 'value' => "#{@totalprice}" }}]}.to_json,
                                                :debug_output => Rails.logger)

    Rails.logger.debug("My object1: #{@response.inspect}")
    render json: {orderID: "#{@response["id"]}"}
  end

  def onapprove
    @response = HTTParty.post("https://api.sandbox.paypal.com/v2/checkout/orders/#{params[:orderID]}/capture",
                                          :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@paypaltoken}"},
                                          :body => {}.to_json, :debug_output => Rails.logger)
    Rails .logger.debug("My object2: #{@response.inspect}")

    render json: {surname: "#{@response["payer"]["name"]["surname"]}", orderID: "#{@response["id"]}", status: "#{@response["status"]}"}
  end

  # Metodo para mostrar la lista de la compra
  def showcart
    # Calculamos el total de productos
    @numproducts = session[:products].count.to_i
    @hayproducts = @numproducts > 0
  end

  # Metodo para añadir productos a la lista de la compra
  def addprod
    # Añadimos los productos a la lista de la compra
    (session[:products] ||= []) << params[:item].to_i
  end

  # Metodo para quitar productos de la cesta
  def deleteprod
    (session[:products] ||= []).delete(params[:item].to_i)
  end

  # Metodo para eliminar productos de la cesta
  def removeprod
    (session[:products] ||= []).reject{params[:item].to_i}
  end
end