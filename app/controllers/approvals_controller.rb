class ApprovalsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user?
  before_action :same_company?, only: [:new, :create, :edit, :update]
  before_action :approve?, only: [:new, :create]
  before_action :applied?, only: [:new, :create, :edit, :update]

  def index
    @not_approved = TripStatement.joins(:user).where("(company_id = ?) AND (applied = ?) AND (approved = ?)", current_user.company_id, true, false).where.not(user_id: current_user.id)
  end

  # 承認した申請
  def approved
    @approved = TripStatement.where(approved: true).where.not(user_id: current_user.id)
  end

  # 否認した申請
  def denied
    # @denied_statements = TripStatement.where(approved: false, applied_at: nil)
    @denied_statements = TripStatement.left_joins(:approvals).where(approved: false).where.not(user_id: current_user.id)
  end

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @user = current_user
    @approval = @user.approvals.build(trip_statement_id: @trip_statement.id)
    @expences = @trip_statement.expences.all #承認画面にて、紐づく旅費全てを表示する。
  end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @approval = current_user.approvals.create(trip_statement_id: @trip_statement.id, approval: true)
    @trip_statement.update(approved: true, approved_at: Time.zone.now)
    redirect_to approvals_index_url
    flash[:success] = "承認しました！"
  end

  def deny
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @approval = current_user.approvals.build(deny_params)
    @approval.update(trip_statement_id: @trip_statement.id, approval: false)
    @trip_statement.update(approved: false, approved_at: Time.zone.now, applied: false)
    redirect_to approvals_index_url
    flash[:warning] = "否認しました。"
  end

  def edit
    @approval = Approval.find(params[:id])
    @trip_statement = @approval.trip_statement
    @user = @trip_statement.user
  end

  def update
  end

  def destroy
  end

  private
    def admin_user?
      if !current_user.admin
        redirect_to root_url
        flash[:danger] = "管理者権限を確認してください。"
      end
    end

    def deny_params
      params.permit(:comment).merge(approval: false)
    end

    def approve?
      @trip_statement = TripStatement.find(params[:trip_statement_id])
      if @trip_statement.approved
        redirect_to approvals_index_url
        flash[:danger] = "承認済の申請です。"
      end
    end

    def applied?
      @trip_statement = TripStatement.find(params[:trip_statement_id])
      if @trip_statement.applied == false
        redirect_to approvals_index_url
        flash[:danger] = "未提出の申請です。"
      end
    end

    def own_statement?
    end

    def same_company?
      @trip_statement = TripStatement.find(params[:trip_statement_id])
      if @trip_statement.user.company_id != current_user.company_id
        redirect_to approvals_index_url
        flash[:danger] = "他社ユーザーの申請は操作できません"
      end
    end

end
