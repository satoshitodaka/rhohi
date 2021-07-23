class HomeController < ApplicationController
  def home
    if user_signed_in?
      # 申請フォーム
      @user = current_user
      @trip_statement = TripStatement.new
      # 申請中の件数を表示
      @created_statements = @user.trip_statements.left_joins(:approvals).merge(Approval.where(id: nil))
      # 管理者向け表示
      @not_approved = TripStatement.joins(:user).where('(company_id = ?) AND (applied = ?) AND (approved = ?)', current_user.company_id, true, false)
    end
  end

  def about; end

  def help; end

  def contact; end
end
