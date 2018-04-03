class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @professionals = User.where(role: "Professional")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, flash[:notice]
    else
      redirect_to new_user_registration_path, flash: :notice
    end
  end

  private

end
