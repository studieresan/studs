class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user # anonymous

    # all users can view resumes and update their credentials
    can :read, Resume
    can :read, User, id: user.id
    can :update, User, id: user.id

    if user.student?
      can :create, Resume
      can :manage, Resume, user_id: user.id
      can :create, :files
    end

    if user.admin?
      can :manage, :all
    end
  end
end
