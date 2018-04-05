class ProfessionalsController < ApplicationController
  def show
    @professional = current_user
    authorize @professional
  end

  def edit
    @professional = current_user
    authorize @professional
  end

  def update
    @professional = current_user
    authorize @professional
    if @professional.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:category_id, :availability, :price_per_hour, :city, :photo)
  end
end
