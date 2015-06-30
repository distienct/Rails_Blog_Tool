class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :edit, Post do |post|
      post.collaborating_users.include?(user)
    end

    can :manage, Post do |post|
      post.user == user
    end

    can :manage, Comment do |comment|
      comment.user == user || post.collaborating_users.include?(user)
    end
  end
end
