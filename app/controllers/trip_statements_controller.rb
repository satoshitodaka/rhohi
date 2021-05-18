class TripStatementsController < ApplicationController
  before_action :authenticate_user!
  before_action :currect_user, only: [:destroy, :edit, :update]
  before_action :admin_user?, only: :show

  def show
    @trip_statement = TripStatement.find(params[:id])
    @user = @trip_statement.user
    @expences = @trip_statement.expences.all #申請書のshow画面にて、経費を全て表示する。
    
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
    # if params[:process] = "update"
      if @trip_statement.update(trip_statement_params)
        # @trip_statement.save
        redirect_to trip_statement_url(params[:id])
        flash[:success] = "出張情報を更新しました。"
      else
        render 'edit'
      end
    # end
    # if params[:prosess] == "apply"
    #   @trip_statement.applied = true
    #   @trip_statement.applied_at = Time.zone.now
    #   @trip_statement.save
    #   redirect_to trip_statements_url
    #   flash[:success] = "出張を申請しました。"
    # end
  end

  def destroy
    TripStatement.find(params[:id]).destroy
    redirect_to trip_statements_url
    flash[:info] = "出張情報を削除しました。"
    
  end

  private
    def trip_statement_params
      params.require(:trip_statement).permit(:distination, :purpose, :start_at, :finish_at, :work_done_at)
    end

    def approved?
      if @trip_statement.approved == true
        # ここに処理を記述する。
      end 
    end

    def currect_user
      @trip_statement = current_user.trip_statements.find_by(id: params[:id])
      redirect_to root_url if @trip_statement.nil?
    end

    def admin_user?
      redirect_to root_url if current_user.admin != true
    end
end
