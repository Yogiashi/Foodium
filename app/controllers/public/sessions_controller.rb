# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  protected
  def after_sign_in_path_for(resource)
     posts_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  # 退会しているかを判断するメソッド
  def user_state
    @user = User.find_by(email: params[:user][:email]) # 入力されたemailからアカウントを1件取得
    return if !@user # アカウントを取得できなかった場合、このメソッドを終了する
    if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true) # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      redirect_to new_user_registration_path
    end
  end
end
