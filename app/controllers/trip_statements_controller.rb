class TripStatementsController < ApplicationController
before_action :authenticate_user!


  def show
    # @user = current_user
    # @trip_statements = @user.trip_statements.paginate(page: params[:page])
  end

  def index
    @user = current_user
    @trip_statements = @user.trip_statements.paginate(page: params[:page])
  end

  def new
    @trip_statement = TripStatement.new
  end

  def create
    @trip_statement = current_user.trip_statements.create(trip_statement_params)
    if @trip_statement.save
      flash[:success] = '申請しました'
      render 'home/home'
    else
      render 'new'
    end
  end

  def destroy
  end

  private
    def trip_statement_params
      params.require(:trip_statement).permit(:distination, :purpose)
    end
  
end
