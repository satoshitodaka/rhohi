class HomeController < ApplicationController
  def home
    @user = current_user
    @not_approved = TripStatement.where(approved: false).where.not(user_id: current_user.id)
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
