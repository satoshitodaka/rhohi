# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # cannnot :manage, :all

    if user.has_role?(:normal)
      can :manage, TripStatement, user_id: user.id
      cannnot :update, TripStatement, applied: true # 提出済の申請は編集不可にする
      cannnot :update, TripStatement, approved: true # 承認済の申請は編集不可にする
      can :manage, Expence, trip_statement: { applied: false }
      can :manage, Expence, trip_statement: { approved: false }
      can :manage, User, id: user.id
      cannot :manage, Approval
    end

    if user.has_role?(:admin)
      can :manage, :all
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
