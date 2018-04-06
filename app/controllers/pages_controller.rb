class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @professionals = User.where(role: "Profissional")
  end
end
