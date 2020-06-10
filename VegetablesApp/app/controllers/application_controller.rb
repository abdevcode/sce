class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if admin_signed_in?
      '/'
    else
      '/products'
    end
  end


  def after_sign_up_path_for(resource)
    '/clients/sign_in'
  end
end
