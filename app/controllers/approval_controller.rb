class ApprovalController < ApplicationController
before_action :authenticate_user!
before_action :admin_user?
before_action :approve?, only: [:create]

  def index
    @not_approved = TripStatement.where(approved: false).where.not(user_id: current_user.id)
    @approved = TripStatement.where(approved: true).where.not(user_id: current_user.id)
    @denial = TripStatement.where(approved: true)
  end

  # def new
  #   @approval = current_user.approval.build(trip_statement_id: [:trip_statement_id])
  # end

  # def show
  #   @not_approved = TripStatement.find(:id)
  # end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @approval = current_user.approval.build(trip_statement_id: params[:trip_statement_id])
    if params[:approval] == "true"
      @trip_statement.approved = true
      @approval.approval = true
    elsif params[:approval] == "false"
      @trip_statement.approved = false
      @approval.approval = false
    else
      render 'home/help'
      redirect_to root_url #上手くいっていないための確認用
    end
    @trip_statement.save
    @approval.save
    if params[:approval] == "true"
      flash[:success] = "承認しました！"
    elsif
      flash[:warning] = "否認しました。"
    end
    redirect_to trip_statement_approval_index_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def admin_user?
      redirect_to root_url unless current_user.admin
    end

    def own_statement?

    end

    # def approval_params
    #   params.permit(:comment).merge(approval_user_id: current_user.id, trip_statement_id: params[:id])
    # end

    def approve?
      @trip_statement = TripStatement.find(params[:trip_statement_id])
      if @trip_statement.approved
        redirect_to trip_statement_approval_index_url
        flash[:danger] = "承認済の申請です。"
      end
    end
end
