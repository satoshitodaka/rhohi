class ApprovalController < ApplicationController
before_action :authenticate_user!
before_action :admin_user?

  def index
    @not_approved = TripStatement.where(approved: false)
    @approved = TripStatement.where(approved: true)
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
    @approval.approval = true
    if @approval.save
      @trip_statement.approved = true
      @trip_statement.save
      redirect_to trip_statement_approval_index_path
    else
      redirect_to root_url #何するか要検討
    end
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

    # def approval_params
    #   params.permit(:comment).merge(approval_user_id: current_user.id, trip_statement_id: params[:id])
    # end
end
