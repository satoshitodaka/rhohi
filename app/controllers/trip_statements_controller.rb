class TripStatementsController < ApplicationController
before_action :authenticate_user!

  def show
    @trip_statement = TripStatement.find(params[:id])
    @user = @trip_statement.user
    @expences = @trip_statement.expences.all #申請書のshow画面にて、経費を全て表示する。
    # if @trip_statement.user = current_user
    #   render 'show'
    # else
    #   render 'index'
    # end
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

  def edit
    @trip_statement = TripStatement.find(params[:id])
  end

  def update
    @trip_statement = TripStatement.find(params[:id])
    @trip_statement.applied = true
    @trip_statement.applied_at = Time.zone.now
    @trip_statement.save
    redirect_to trip_statements_url
    flash[:success] = "出張を申請しました。"
  end

  def destroy

  end

  private
    def trip_statement_params
      params.require(:trip_statement).permit(:distination, :purpose, :start, :finish, :work_done)
    end
  
end
