class PostPolicy < ApplicationPolicy
  # Anyone (even non-logged in users) can view posts
  def index?
    true
  end

  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end
end