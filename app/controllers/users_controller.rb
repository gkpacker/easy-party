class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @search = params[:query]
      results = PgSearch.multisearch(params[:query])
      @professionals = []
      results.each do |result|
        if result.searchable_type == "User"
          @professionals << result.searchable
        elsif result.searchable_type == "Category"
          @professionals << User.where(category_id: result.searchable.id)
        end
      end

    else
      @search = params[:query]
      @professionals = User.where(role: "Professional").order(:created_at).last(10).reverse
    end
  end

  def show
    if params[:id] != "sign_out"
      @professional = User.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.role == "Professional"
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
