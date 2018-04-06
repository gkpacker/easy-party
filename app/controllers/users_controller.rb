class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :skip_authorization, only: [:index, :show]
  def index
    if params[:query].present?
      @search = params[:query]
      if params[:order_query].present?
        order_param = params[:order_query]
        @results = policy_scope(User).search(params[:query]).order(order_param).reverse
      else
        @results = policy_scope(User).search(params[:query])
      end
    else
      if params[:order_query].present?
        @search = params[:query]
        order_param = params[:order_query]
        @results = policy_scope(User).where(role: "Profissional").order(order_param).last(25)
      else
        @search = params[:query]
        @results = policy_scope(User).where(role: "Profissional").order(:created_at).last(25).reverse
      end
    end
  end

  def show
    @professional = User.find(params[:id])
    @jobs = @professional.jobs
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
