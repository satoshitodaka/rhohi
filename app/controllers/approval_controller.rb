class ApprovalController < ApplicationController
before_action :authenticate_user!
before_action :admin_user?

  def index
    @not_approved = TripStatement.where(approved: false)
    @approved = TripStatement.where(approved: true)
  end

  def new
    @approval = current_user.approval.build(trip_statement_id: [:trip_statement_id])
  end

  def show
    @not_approved = TripStatement.find(:id)
  end

  def create
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
end
