class ExpencesController < ApplicationController
before_action :authenticate_user!

  def new
    @trip_statement = TripStatement.find(params[:trip_statements.id])
    @expence = @trip_statement.expences.new
  end

  def index
  end

  def show
    @user = current_user
    @trip_statement = TripStatement.find(params[:id])
    @expences = @trip_statement.expences.all
  end

  def create
    @expence = @trip_statement.expences.build(expence_params)
    if @expence.save
      # redirect_to 'root_url'
    else
      render 'new_trip_statement_expences_path'
    end
  end

  def destroy
  end

  private
    def expence_params
      params.require(:expence).permit(:date, :transportation, :bording, :get_off, :fare, :mileage, :allowance)
    end

end
