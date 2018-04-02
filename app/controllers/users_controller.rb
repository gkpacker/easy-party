class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def index
    users = User.all
    @professionals = users.select { |user| user.professional? }
  end

  def show
  end

  def new
    user = User.new
  end

  def create
    user = User.new

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :availability, :encrypted_password, :price_per_hour, :city)
  end

  def professional?
    self.role == "Professional"
  end
end
