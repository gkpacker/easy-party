class OrganizersController < ApplicationController
  def show
    @organizer = current_user
    authorize @organizer
  end
end
