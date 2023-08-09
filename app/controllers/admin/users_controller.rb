class Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:word]
      @users = User.search(params[:word])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end
