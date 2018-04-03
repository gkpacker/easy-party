class OrganizersController < ApplicationController
  def show
    @organizer = User.find(params[:user_id])
  end

  private

  def organizer_params
    params.require(:organizer).permit(:user_id)
  end
end
