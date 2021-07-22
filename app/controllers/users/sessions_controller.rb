# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
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

  def new_guest
    user = User.guest
    redirect_to root_url
    if sign_in user
      flash[:success] = 'ゲストログインいただきありがとうございます！'
    else
      flash[:info] = 'ゲストログインに失敗しました。管理者にお問い合わせください。'
    end
  end

  def new_admin_guest
    user = User.new_admin_guest
    user.add_role :admin
    redirect_to root_url
    if sign_in user
      flash[:success] = 'ゲスト管理者ログインいただきありがとうございます！'
    else
      flash[:info] = 'ゲストログインに失敗しました。管理者にお問い合わせください。'
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
