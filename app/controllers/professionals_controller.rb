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
    raise
    @professional = current_user
    authorize @professional
    if params[:user]["availability"].present?
      days = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"]
      params_avaiable = params[:user]["availability"]
      @professional.availability = ""
      available = ""
      days.each do |day|
        available += " #{day}" if params_avaiable.to_s.match(/"#{day}"/).present?
      end
      @professional.availability = available
    end
    if @professional.update(user_params)
      redirect_to professionals_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:category_id, :availability, :price_per_hour, :city, :photo)
  end
end
