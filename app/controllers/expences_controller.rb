class ExpencesController < ApplicationController
before_action :authenticate_user!

  def new
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @expence = @trip_statement.expences.new
  end

  def index
  end

  def show
    @expence = Expence.find(params[:id])
    @trip_statement = @expence.trip_statement
    @user = @trip_statement.user
    # @expence = Expence.find(params[:id])
  end

  def create
    @trip_statement = TripStatement.find(params[:trip_statement_id])
    @expence = @trip_statement.expences.build(expence_params)
    if @expence.save
      redirect_to trip_statement_path(params[:trip_statement_id])
    else
      redirect_to new_trip_statement_expence_url(@trip_statement)
    end
  end

  def destroy
  end


  private
    def expence_params
      params.require(:expence).permit(:date, :transportation, :bording, :get_off, :fare, :mileage, :allowance)
    end
end