class OrganizersController < ApplicationController
  def show
    @organizer = current_user
  end
end
