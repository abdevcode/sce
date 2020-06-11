class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_locale

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      '/'
    else
      '/products'
    end
  end


  private

  def set_locale
    if current_client
      I18n.locale = current_client.preference || I18n.default_locale
    else
      I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options={})
    {locale: I18n.locale}.merge options
  end
end
