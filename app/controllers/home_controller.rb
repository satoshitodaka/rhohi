class HomeController < ApplicationController
  def home
    if user_signed_in?
      # 申請フォーム
      @user = current_user
      @trip_statement = TripStatement.new
      # 申請中の件数を表示
      @created_statements = @user.trip_statements.left_joins(:approvals).merge(Approval.where(id: nil))
      # 管理者向け表示
      @not_approved = TripStatement.where(applied: true, approved: false).where.not(user_id: current_user.id)
    end
  end

  def about
    @user = current_user
  end

  def help
    @user = current_user
  end

  def contact
  end
end
