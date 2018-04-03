class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :user_params, if: :devise_controller?


  def index
    @professionals = User.where(role: "Professional")
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      redirect_to new_user_registration_path
    end
  end

  private

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
