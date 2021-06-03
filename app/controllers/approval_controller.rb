class ApprovalController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_user?
  # before_action :approve?, only: :create
  load_and_authorize_resource

  def index
    @not_approved = TripStatement.where(applied: true, approved: false).where.not(user_id: current_user.id)
    # @not_approved = TripStatement.left_joins(:approval).select("trip_statements.*").where("approval.id is null")
  end

  def approved
    @approved = TripStatement.where(approved: true).where.not(user_id: current_user.id)
  end

  def denied
    @denied = TripStatement.where(approved: true)
    # @denied_approval = @denied.approvals
  end

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @user = @trip_statement.user
    @approval = @user.approval.build(trip_statement_id: @trip_statement.id)
    @expences = @trip_statement.expences.all #承認画面にて、紐づく旅費全てを表示する。
  end

  # def show
  #   @not_approved = TripStatement.find(:id)
  # end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    if params[:approval] == "true"
      @approval = current_user.approval.create(trip_statement_id: @trip_statement.id, approval: true)
      @trip_statement.approved = true
    elsif params[:approval] == "false"
      @approval = current_user.approval.create(trip_statement_id: @trip_statement.id, approval: false)
      @trip_statement.approved = false
    else
      redirect_to trip_statement_approval_index_path
      flash[:warning] = "問題が発生しました。再度お試しください。"
    end
    @trip_statement.save
    @approval.save
    if params[:approval] == "true"
      flash[:success] = "承認しました！"
    elsif params[:approval] == "false"
      flash[:warning] = "否認しました。"
    end
    redirect_to trip_statement_approval_index_path
  end
    
  #   redirect_to trip_statement_approval_index_path
  # end

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
        redirect_to trip_statement_approval_index_url
        # flash[:danger] = "承認済の申請です。"
        flash[:success] = "出張を申請しました。"
      end
    end

    def own_statement?
    end

    # def approval_params
    #   params.permit(:comment).merge(approval_user_id: current_user.id, trip_statement_id: params[:id])
    # end

end
