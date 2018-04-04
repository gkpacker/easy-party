class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_params, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.role == "Organizer"
    else
      user = resource_or_scope
      if user.category_id.nil? || user.price_per_hour.nil? || user.city.nil?
        edit_professionals_path
      else
        root_path
      end
    end
  end

  def record_not_found
    flash[:alert] = "Não pode acessar essa pagina"
    redirect_to root_path
  end


  protected

  def user_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :phone_number,
                         :availability, :price_per_hour,:city,
                         :role, :email, :password, :password_confirmation,
                         :category_id, :photo)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:first_name, :last_name, :phone_number,
                         :availability, :price_per_hour,:city,
                         :role, :email, :current_password, :password, :password_confirmation,
                         :category_id, :photo)
    end
  end
end
