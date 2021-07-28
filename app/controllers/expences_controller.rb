class ExpencesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy, :edit, :update]
  before_action :applied_expence?, only: [:update, :destroy]
  # before_action :admin_user?, only: :show

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @expence = @trip_statement.expences.new
  end

  def show
    @expence = Expence.find(params[:id])
    @trip_statement = @expence.trip_statement
    @user = @trip_statement.user
  end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @expence = @trip_statement.expences.build(expence_params)
    if @expence.save
      redirect_to trip_statement_path(params[:trip_statement_id])
      flash[:success] = '旅費情報を登録しました！'
    else
      redirect_to new_trip_statement_expence_url(@trip_statement)
      flash[:danger] = '登録に失敗しました。'
    end
  end

  def destroy
    @expence = Expence.find(params[:id])
    @expence.destroy
    redirect_to trip_statement_url(@expence.trip_statement.id)
    flash[:info] = '旅費を削除しました'
  end

  def edit
    @expence = Expence.find(params[:id])
  end

  def update
    @expence = Expence.find(params[:id])
    @trip_statement = @expence.trip_statement
    if @expence.update(expence_params)
      redirect_to trip_statement_path(@expence.trip_statement.id)
      flash[:success] = '旅費情報を更新しました。'
    else
      render 'edit'
    end
  end

  private

  def expence_params
    params.require(:expence).permit(:date, :transportation, :bording, :get_off, :fare, :mileage, :allowance)
  end

  # 他ユーザーの旅費情報の操作（編集・削除）を制限する。
  def correct_user
    @expence = Expence.find(params[:id])
    @own_statement = current_user.trip_statements.find_by(id: @expence.trip_statement_id)
    return unless @own_statement.nil?

    redirect_to root_url
    flash[:info] = '他ユーザーの申請は操作できません'
  end

  def applied_expence?
    @expence = Expence.find(params[:id])
    @trip_statement = @expence.trip_statement
    return unless @trip_statement.applied == true

    redirect_to trip_statement_path(@trip_statement)
    flash[:danger] = '申請済みの旅費情報は操作できません。'
  end
end
