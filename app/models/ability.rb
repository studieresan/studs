class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil? # anonymous
    else # all users can view resumes and update their credentials
      can :read, Resume
      can :update, User, id: user.id
    end

    if user.student? # students can control their own resume
      can :create, Resume
      can :manage, Resume, user_id: user.id
    end

    if user.admin?
      can :manage, :all
    end
  end
end
