class ExpencesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:destroy, :edit, :update]
  # before_action :admin_user?, only: :show

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @expence = @trip_statement.expences.new
  end

  def index
  end

  def show
    @expence = Expence.find(params[:id])
    @trip_statement = @expence.trip_statement
    @user = @trip_statement.user
    # @expence = Expence.find(params[:id])
  end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @expence = @trip_statement.expences.build(expence_params)
    if @expence.save
      redirect_to trip_statement_path(params[:trip_statement_id])
      flash[:success] = "旅費情報を登録しました！"
    else
      redirect_to new_trip_statement_expence_url(@trip_statement)
      flash[:danger] = "登録に失敗しました。。。"
    end
  end

  def destroy
    @expence = Expence.find(params[:id])
    @expence.destroy
    redirect_to trip_statement_url(@expence.trip_statement.id)
    flash[:info] = "旅費を削除しました"
  end

  def edit
    @expence = Expence.find(params[:id])
  end

  def update
    @expence = Expence.find(params[:id])
      if @expence.update(expence_params)
        redirect_to trip_statement_path(@expence.trip_statement.id)
        flash[:success] = "旅費情報を更新しました。"
      else
        render 'edit'
      end
  end

  private
    def expence_params
      params.require(:expence).permit(:date, :transportation, :bording, :get_off, :fare, :mileage, :allowance)
    end

    def correct_user
      @expence = Expence.find(params[:id])
      @own_statement = current_user.trip_statements.find_by(id: @expence.trip_statement_id)
      if @own_statement.nil?
        redirect_to root_url
        flash[:info] = "他ユーザーの申請は操作できません"
      end
    end

    # def admin_user?
    #   @expence = current_user.expences.find_by(id: params[:id])
    #   if @expence.nil?
    #     if current_user.admin != true
    #       redirect_to root_url
    #     end
    #   end
    # end
end