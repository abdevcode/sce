class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :get_cart_information
  before_action :inicializar_cliente

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      '/'
    else
      '/products'
    end
  end

  def inicializar_cliente

    if !admin_signed_in?
      if client_signed_in?
        @client ||= Client.find_by(id: current_client.id)
      end
    end
  end

  def get_cart_information
    # Inicializamos la cesta
    session[:products] ||= []

    # Calculamos el total de productos
    @numproducts = session[:products].count.to_i
    @hayproducts = @numproducts > 0
    @totalprice = 0.0

    # Obtenemos los productos de la cesta
    @productscart = Product.find session[:products]

    # Calculamos el precio total de la cesta
    @productscart.uniq.each do |product|
      # Multiplicacmos el precio por la cantidad seleccionada
      @totalprice += product.price.to_f * session[:products].count( product.id ).to_i
    end
  end

  private

  def set_locale
    locale = extract_locale_from_accept_language_header
    variable =  if locale_valid?(locale)
                   locale
                 else
                   :es
                 end
    if current_client
      I18n.locale = current_client.preference || variable
    else
      I18n.locale = variable
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}.merge options
  end

  def locale_valid?(locale)
    I18n.available_locales.map(&:to_s).include?(locale)
  end

  def extract_locale_from_accept_language_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    return unless accept_language

    accept_language.scan(/^[a-z]{2}/).first
  end
end
