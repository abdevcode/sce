class CartController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_paypaltoken, :only => [:createorder, :onapprove]

  def set_paypaltoken
    # curl https://api.sandbox.paypal.com/v1/oauth2/token -H "Accept: application/json" -H "Accept-Language: en_US" -u "AfhQAyn2RmF3PXoCnNMMpenYijDrFIcAzXtSZB2hSD55El8LfREtvr6hcM8Asqg0ACmhbtV5gttQqyR8:EOLio9QqLgE65jLFLDyzjuOHfGu6WKA48FoxJnC-mvDVmTFH345Ztce5uBW_7MAqfdl5TQTz2gXOUfUB" -d "grant_type=client_credentials"

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
=begin
    basicAuth = Base64.encode64("**#{paypal_client}:#{paypal_secret}**")

    Rails.logger.debug("basicAuth: #{paypal_client} ::: #{paypal_secret} ===> #{basicAuth}")

    # Hacemos la llamada a PayPal para que nos devuelva el token
    response = HTTParty.post('https://api.sandbox.paypal.com/v1/oauth2/token',
                              :headers => {'Accept' => 'application/json',
                                           'Accept-Language' => 'en_US',
                                           'Authorization' => "Basic #{paypal_client}:#{paypal_secret}"},
                              :data => "grant_type=client_credentials",
                              :debug_output => Rails.logger)

    Rails.logger.debug("Token PayPal: #{response.inspect}")


    curl -v https://api.sandbox.paypal.com/v1/oauth2/token \
   -H "Accept: application/json" \
   -H "Accept-Language: en_US" \
   -u "client_id:secret" \
   -d "grant_type=client_credentials"
=end


    @paypaltoken = response['access_token']

    Rails.logger.debug("access_token PayPal: #{@paypaltoken}")
  end


  # Metodo para mostrar la lista de la compra
  def showcart
    @productscart = Product.find session[:products]
  end

  # Metodo para añadir productos a la lista de la compra
  def addprod
    (session[:products] ||= []) << params[:item].to_i
  end



  def createorder
    @response = HTTParty.post('https://api.sandbox.paypal.com/v2/checkout/orders',
                                                :headers => {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{@paypaltoken}"},
                                                :body => {:intent => 'CAPTURE', :purchase_units => [{'amount' => {'currency_code' => 'EUR', 'value' => '0.07'}}]}.to_json,
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
end