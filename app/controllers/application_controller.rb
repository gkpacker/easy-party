class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_params, if: :devise_controller?

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.role == "Organizer"
      root_path
    else
      user = resource_or_scope
      if user.category_id.nil? || user.price_per_hour.nil? || user.city.nil?
        edit_professional_path(user)
      else
        root_path
      end
    end
  end

  protected

  def user_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :phone_number,
                         :availability, :price_per_hour,:city,
                         :role, :email, :password, :password_confirmation,
                         :category_id)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:first_name, :last_name, :phone_number,
                         :availability, :price_per_hour,:city,
                         :role, :email, :current_password, :password, :password_confirmation,
                         :category_id)
    end
  end
end
