class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :user_params, if: :devise_controller?

  protected

  def user_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :phone_number,
                         :availability, :price_per_hour,:city,
                         :role, :email, :password, :password_confirmation,
                         :category_id)
    end
  end
end
