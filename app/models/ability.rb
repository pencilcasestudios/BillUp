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

    # Client
    can :read, Client do |client|
      client.organisation.members.include?(user)
    end
    can :create, Client
    can :update, Client do |client|
      client.organisation.members.include?(user)
    end
    can :destroy, Client do |client|
      client.organisation.members.include?(user)
    end

    # Invoice
    can :read, Invoice do |invoice|
      invoice.organisation.members.include?(user)
    end
    can :create, Invoice
    can :update, Invoice do |invoice|
      invoice.organisation.members.include?(user)
    end
    can :paid, Invoice do |invoice|
      invoice.organisation.members.include?(user)
    end
    can :unpaid, Invoice do |invoice|
      invoice.organisation.members.include?(user)
    end
    can :destroy, Invoice do |invoice|
      invoice.organisation.members.include?(user)
    end

    # Receipt
    can :read, Receipt do |receipt|
      receipt.organisation.members.include?(user)
    end
    can :create, Receipt
    can :update, Receipt do |receipt|
      receipt.organisation.members.include?(user)
    end
    can :destroy, Receipt do |receipt|
      receipt.organisation.members.include?(user)
    end
  end
end
