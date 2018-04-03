class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index, :show
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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :availability, :price_per_hour, :city, :role)
  end
end
