class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @professionals = User.where(role: "Professional")
  end

  def show
    @professional = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.role == "Professional"
      if @user.save
        redirect_to edit_professionals_path
      else
        redirect_to new_user_registration_path, flash: :notice
      end
    else
      if @user.save
        redirect_to root_path, flash[:notice]
      else
        redirect_to new_user_registration_path, flash: :notice
      end
    end
  end

  private

  def professional_params
    params.require(:user).permit(:id)
  end

end
