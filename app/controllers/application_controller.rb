class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!
  before_action :user_params, if: :devise_controller?

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  # Overwriting the sign_out redirect path method
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.role == "Organizador"
      stored_location_for(resource_or_scope) || super
    else
      user = resource_or_scope
      if user.category_id.nil? || user.price_per_hour.nil? || user.city.nil?
        edit_professionals_path
      else
        professionals_path
      end
    end
  end

  def record_not_found
    flash[:alert] = "Não pode acessar essa pagina"
    redirect_to root_path
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
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
