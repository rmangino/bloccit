class PostPolicy < ApplicationPolicy
  # Anyone (even non-logged in users) can view posts
  def index?
    true
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      elsif user.member?
        scope.where(user_id: user.id)
      else
        [] # Any other roles see nothing
      end
    end
  end
end