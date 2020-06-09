class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if admin_signed_in?
      '/'
    else
      '/clients'
    end
  end
end
