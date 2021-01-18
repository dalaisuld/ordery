class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create!(user_params)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email).merge(password: "password").merge(password_confirmation: "password")
  end
end
