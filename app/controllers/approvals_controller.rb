class ApprovalsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user?
  before_action :same_company?, only: [:new, :create, :edit, :update]
  before_action :approved?, only: [:new, :create]
  before_action :applied?, only: [:new, :create, :edit, :update]

  def index
    @not_approved = TripStatement.joins(:user).where('(company_id = ?) AND (applied = ?) AND (approved = ?)', current_user.company_id, true, false).where.not(user_id: current_user.id).page(params[:page])
  end

  # 承認した申請
  def approved
    @approved = TripStatement.joins(:user).where('(company_id = ?) AND (approved = ?)', current_user.company_id, true).where.not(user_id: current_user.id).page(params[:page])
  end

  # 否認した申請
  def denied
    @denied_statements = TripStatement.joins(:user, :approvals).where('(company_id = ?) AND (approval = ?)', current_user.company_id, false).where.not(user_id: current_user.id).page(params[:page])
  end

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @user = current_user
    @approval = @user.approvals.build(trip_statement_id: @trip_statement.id)
    @expences = @trip_statement.expences.all # 承認画面にて、紐づく旅費全てを表示する。
  end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @approval = current_user.approvals.create(approval: true, trip_statement_id: @trip_statement.id)
    @approval = current_user.approvals.create(approval_params)
    @trip_statement.update(approved: true, approved_at: Time.zone.now)
    redirect_to approvals_index_url
    flash[:success] = '承認しました！'
  end

  def deny
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @approval = current_user.approvals.create(deny_params)
    @trip_statement.update(approved: false, approved_at: Time.zone.now, applied: false)
    if @approval.save
      redirect_to approvals_index_url
      flash[:success] = '否認しました。'
    else
      render 'new'
      flash[:warning] = '否認に失敗しました。再度確認してください。'
    end
  end

  private

  def admin_user?
    return current_user.admin

    redirect_to root_url
    flash[:danger] = '管理者権限を確認してください。'
  end

  # def approval_params
  #   params.require(:approval).merge(approval: true, trip_statement_id: @trip_statement.id)
  # end

  def deny_params
    params.require(:approval).permit(:comment).merge(approval: false, trip_statement_id: @trip_statement.id)
  end

  def approved?
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    return @trip_statement.approved

    redirect_to approvals_index_url
    flash[:danger] = '承認済の申請です。'
  end

  def applied?
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    return @trip_statement.applied == false

    redirect_to approvals_index_url
    flash[:danger] = '未提出の申請です。'
  end

  def same_company?
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    return @trip_statement.user.company_id != current_user.company_id

    redirect_to approvals_index_url
    flash[:danger] = '他社ユーザーの申請は操作できません'
  end
end
