class UsersController < ApplicationController
  before_action :admin_user?, only: :index

  def show
    # @user = User.find(params[:id])
    @user = User.find(params[:id])

  end

  def index
    @company = current_user.company
    @mycompany_users = User.all.where(company_id: current_user.company_id)
  end

  def invite
    user = User.find(params[:id])
    if user.valid?
      user.invite!
      redirect_to users_path
      flash[:success] = "招待メールを送信しました。"
    else
      redirect_to root_url
      flash[:warning] = "ユーザー情報が無効です。"#再度showページでも良いかも
    end
  end

  private
    def admin_user?
      if !current_user.has_role? :admin
        redirect_to root_url
        flash[:info] = "操作権限がありません。"
      end
    end
end
