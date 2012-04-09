class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest

    # User
    can :manage, User, id: user.id # Manage their own account. Works for Guest too because nil == nil

    # Organisation
    can :read, Organisation do |organisation|
      organisation.members.include?(user)
    end
    can :create, Organisation
    can :update, Organisation do |organisation|
      organisation.members.include?(user)
    end
    can :destroy, Organisation do |organisation|
      organisation.members.include?(user)
    end
  end
end
