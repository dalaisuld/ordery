class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_users_active = true
    @page_title = "Ажилтны жагсаалт"
    @users = User.all
  end

  def new
    @page_users_active = true
    @user = User.new
  end

  def create
    @user = User.create!(user_params)
    render :index
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation).merge(role: 1)
  end
end
