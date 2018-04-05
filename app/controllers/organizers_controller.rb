class OrganizersController < ApplicationController
  def show
    @organizer = current_user
    authorize @organizer
    @event = Event.new
  end
end
