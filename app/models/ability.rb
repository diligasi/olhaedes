# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    return can :manage, :all if user.admin?

    if user.field?
      can :manage, User, id: user.id
      can %i[index create read], FieldForm, user_id: user.id
      can :update, FieldForm, user_id: user.id, status: :pending
    end

    if user.lab?
      can :manage, User, id: user.id
      can %i[index read], [Faq, Institutional]
      can %i[index read update], FieldForm, user: { region: { department: user.region.department } }, status: :pending
    end

    if user.supervisor?
      can :manage, User, id: user.id
      can :manage, :dashboard
      can %i[index read], [Faq, Institutional]
      can %i[index read], FieldForm, user: { region: { department: user.region.department } }
    end
  end
end
