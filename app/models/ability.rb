class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil? # anonymous
    else # all users can view resumes and update their own credentials
      can :read, Resume
      can :update, User, id: user.id
    end

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
