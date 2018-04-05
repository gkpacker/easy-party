class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :skip_authorization, only: [:show]
  def index
    if params[:query].present?
      @search = params[:query]
      if params[:filter_query].present?
      @results = User.search(params[:query]).filter(params[:filter_query])
      else
      @results = User.search(params[:query])
      end
    else
      @search = params[:query]
      @results = policy_scope(User).where(role: "Profissional").order(:created_at).last(10).reverse
    end
  end

  def show
    @professional = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.role == "Profissional"
      if @user.save
        redirect_to edit_professionals_path(@user)
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
