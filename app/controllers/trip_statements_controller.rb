class TripStatementsController < ApplicationController
before_action :authenticate_user!

  def show
    @user = current_user
    @trip_statement = TripStatement.find(params[:id])
    @expences = @trip_statement.expences.all
    if @trip_statement.user = current_user
      render 'show'
    else
      render 'index'
    end

  end

  def index
    @user = current_user
    @trip_statements = @user.trip_statements.all

  end

  def new
    @trip_statement = TripStatement.new
  end

  def create
    @trip_statement = current_user.trip_statements.create(trip_statement_params)
    if @trip_statement.save
      #flash[:success] = '申請しました'
      redirect_to trip_statement_path(@trip_statement)
      
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
