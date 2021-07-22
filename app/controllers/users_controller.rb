class UsersController < ApplicationController
  before_action :admin_user?, only: [ :index, :destroy ]

  def show
    @user = User.find(params[:id])
  end

  def index
    @company = current_user.company
    @mycompany_users = User.all.where(company_id: current_user.company_id)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
      flash[:success] = 'ユーザーを削除しました'
    else
      user_path(@user)
      flash[:warning] = 'ユーザーの削除失敗しました'
    end
  end

  def invite
    user = User.find(params[:id])
    if user.invite!
      redirect_to users_path
      flash[:success] = '招待メールを送信しました。'
    else
      redirect_to root_url
      flash[:warning] = 'ユーザー情報が無効です。'
    end
  end

  private

    def admin_user?
      if !current_user.has_role? :admin
        redirect_to root_url
        flash[:info] = '操作権限がありません。'
      end
    end
end
