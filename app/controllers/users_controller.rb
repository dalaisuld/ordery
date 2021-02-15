class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @page_users_active = true
    @page_title = 'Ажилтны жагсаалт'
    @users = User.all
  end

  def new
    @page_users_active = true
    @page_users_active = true
    @user = User.new
  end

  def edit
    @page_users_active = true
    @user = User.find(params[:id])
  end

  def create
    @users = User.where(delete_flag: 0)
    @user = User.new
    if User.find_by(email: params[:user][:email]).present?
      flash[:error] = 'Эмайл хаяг давхцааад байна'
      render :new
    else
      User.create!(user_params)
      flash[:alert] = 'Амжилттай бүртгэлээ'
      render :index
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update!({first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email], role: params[:user][:role]})
    @users = User.where(delete_flag: 0)
    flash[:alert] = 'Амжилттай Заслаа'
    render :index
  end

  def update_password
    @user = User.find(params[:user][:id])
    @user.update!({password: params[:user][:password], password_confirmation: params[:password_confirmation]})
    @users = User.where(delete_flag: 0)
    flash[:alert] = 'Амжилттай Заслаа'
    render :index
  end

  def destroy
    User.find(params[:id]).update!({delete_flag: 1})
    flash[:alert] = 'Амжилттай Устгалаа'
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end
end
