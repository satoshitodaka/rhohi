class ApprovalsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user?
  before_action :same_company?, only: [:new, :create, :edit, :update]
  before_action :approve?, only: [:new, :create]
  before_action :applied?, only: [:new, :create, :edit, :update]

  def index
    @not_approved = TripStatement.where(applied: true, approved: false).where.not(user_id: current_user.id)
  end

  def approved
    @approved = TripStatement.where(approved: true).where.not(user_id: current_user.id)
  end

  def denied
    @denied = TripStatement.where(approved: false, applied_at: nil)
  end

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @user = current_user
    @approval = @user.approvals.build(trip_statement_id: @trip_statement.id)
    @expences = @trip_statement.expences.all #承認画面にて、紐づく旅費全てを表示する。
  end

  # def show
  #   @not_approved = TripStatement.find(:id)
  # end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    if params[:approval] == "true"
      @approval = current_user.approvals.create(trip_statement_id: @trip_statement.id, approval: true)
      @approval.trip_statement.update(approved: true, approved_at: Time.zone.now)
    elsif params[:approval] == "false"
      @approval = current_user.approvals.create(trip_statement_id: @trip_statement.id, approval: false)
      @trip_statement.update(approved: false, approved_at: Time.zone.now)
    else
      redirect_to approvals_index_path
      flash[:warning] = "問題が発生しました。再度お試しください。"
    end
    @trip_statement.save
    # @approval.save
    if params[:approval] == "true"
      flash[:success] = "承認しました！"
    elsif params[:approval] == "false"
      flash[:warning] = "否認しました。"
    end
    redirect_to approvals_index_url
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
      redirect_to root_url unless current_user.admin
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
        flash[:danger] = "他社の申請は操作できません"
      end
    end

    # def approval_params
    #   params.permit(:comment).merge(approval_user_id: current_user.id, trip_statement_id: params[:id])
    # end

end
