class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: :user) # гость или дефолт

    if user.admin?
      can :manage, :all
      # доступ в админ-панель, если понадобится:
      can :access, :rails_admin
      #can :dashboard
    elsif user.editor?
      can :read, :all
      can [:create, :update], Article
      cannot :destroy, Article
    else # обычный user
      can :read, :all
      can :create, Comment
      can :destroy, Comment, user_id: user.id
    end
  end
end

