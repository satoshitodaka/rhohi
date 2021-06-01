class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    @user = User.find_by(params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(new_user_params)
    if @user.save
      # ユーザーに招待メールを送る。
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  private
    def user_new_params
      params.require(:user).permit(:name, :email, :birthday, :company_id, :admin, :system_admin)
    end
  

end
