class ProfessionalsController < ApplicationController
  def show
    @professional = User.find(params[:user_id])
  end

  private

  def professional_params
    params.require(:professional).permit(:user_id)
  end
end
