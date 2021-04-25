class TripStatementsController < ApplicationController

  def show
    @user = current_user
    @trip_statements = @user.trip_statements.paginate(page: params[:page])
  end

  def index
    @user = current_user
    @trip_statements = @user.trip_statements.paginate(page: params[:page])
  end

  def new
  end
  
end
