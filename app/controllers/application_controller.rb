class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :authenticate_customer!, except: [:top, :about]

   def admin_url
     request.fullpath.include?("/admin")
   end


  protected

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      orders_path
    when Customer
      customer_path(resource.id)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active])
  end

end
