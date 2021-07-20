class TripStatementsController < ApplicationController
  before_action :authenticate_user!
  before_action :currect_user, only: [:destroy, :edit, :update]
  before_action :admin_user?, only: :show
  before_action :applied?, only: [:destroy, :edit, :update]
  before_action :approved?, only: [:destroy, :edit, :update]

  def show
    @trip_statement = TripStatement.find(params[:id])
    @user = @trip_statement.user
    @expences = @trip_statement.expences.all #申請書のshow画面にて、経費を全て表示する。
    @approval = Approval.find_by(trip_statement_id: @trip_statement.id)
  end

  # 承認依頼中の申請(紐づく承認を持っていない)
  def index
    @user = current_user
    @created_statements = @user.trip_statements.left_joins(:approvals).merge(Approval.where(id: nil)).page(params[:page])
  end

  # 承認済みの申請
  def approved
    @user = current_user
    @approved_statements = @user.trip_statements.all.where(approved: true).page(params[:page])
  end

  # 否認された申請
  def denied
    @user = current_user
    @denied_statements = @user.trip_statements.includes(:approvals).where(applied: true, approved: false).where.not(approved_at: nil).page(params[:page])
  end  

  def new
    @trip_statement = TripStatement.new
  end

  def create
    @trip_statement = current_user.trip_statements.create(create_trip_statement_params)
    if @trip_statement.save
      redirect_to trip_statement_path(@trip_statement)
      flash[:success] = '出張申請を作成しました。旅費情報を追加してください。'
    else
      render 'new'
    end
  end

  def edit
    @trip_statement = TripStatement.find(params[:id])
  end

  def update
    @trip_statement = TripStatement.find(params[:id])
    if @trip_statement.update(update_trip_statement_params)
      @trip_statement.save
      redirect_to trip_statement_url(params[:id])
      flash[:success] = '出張申請を編集しました。'
    else
      render 'edit'
    end
  end

    # 承認依頼（提出）する
  def submit
    @trip_statement = TripStatement.find(params[:id])
    @trip_statement.update(applied: true, applied_at: Time.zone.now)
    # @trip_statement.applied = true
    # @trip_statement.applied_at = Time.zone.now
    @trip_statement.save
    redirect_to trip_statements_url
    flash[:success] = '出張を提出しました。'
  end

  def destroy
    TripStatement.find(params[:id]).destroy
    redirect_to trip_statements_url
    flash[:info] = '出張情報を削除しました。'
  end

  private
    def create_trip_statement_params
      params.require(:trip_statement).permit(:distination, :purpose, :start_at, :finish_at, :work_done_at).merge(applied: false, approved: false)
    end

    def update_trip_statement_params
      params.require(:trip_statement).permit(:distination, :purpose, :start_at, :finish_at, :work_done_at)
    end

    def applied?
      if @trip_statement.applied == true
        redirect_to trip_statements_url(@trip_statement)
        flash[:warning] = '提出済みの申請は操作できません'
      end 
    end

    def approved?
      if @trip_statement.approved == true
        redirect_to trip_statements_url(@trip_statement)
        flash[:warning] = '承認済みの申請は操作できません'
      end 
    end

    def currect_user
      @trip_statement = current_user.trip_statements.find_by(id: params[:id])
      redirect_to root_url if @trip_statement.nil?
    end

    def admin_user?
      @trip_statement = current_user.trip_statements.find_by(id: params[:id])
      if @trip_statement.nil?
        if current_user.admin != true
          redirect_to root_url
        end
      end
    end

    # 多分使ってない
    # def has_approval?
    #   if @trip_statement = TripStatement.find(params[:id])
    #     @trip_statement.approval.any?
    #   end
    # end
end
