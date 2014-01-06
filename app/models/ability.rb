class Ability
  include CanCan::Ability

  def initialize(user)
    # Static pages available to all visitors
    can :index, [:index, :pub, :earlier, :resumes, :contact]

    return unless user # anonymous

    # All users can view resumes and update their credentials
    can :read, Resume
    can :update, User, id: user.id
    can :me, User

    if user.student?
      # Students can create and manage their own resumes
      can :create, Resume
      can :manage, Resume, user_id: user.id
      can :manage, Experience, resume: { user_id: user.id }

      can [:index, :create, :update], :files
    end

    if user.pr?
      can [:index, :create], User
      can [:update, :delete, :destroy], User, role: 'organization'
      can :manage, Post
    end

    if user.organization?
      can :intro, User
    end

    if user.admin?
      can :manage, :all
    end
  end
end
