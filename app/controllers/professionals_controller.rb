class ProfessionalsController < ApplicationController
  def show
    @professional = User.find(params[:user_id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:category_id, :availability, :price_per_hour, :city)
  end

  def professional_params
    params.require(:professional).permit(:user_id)
  end


end
