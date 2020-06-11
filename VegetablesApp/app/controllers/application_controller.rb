class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :get_cart_information

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      '/'
    else
      '/products'
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
