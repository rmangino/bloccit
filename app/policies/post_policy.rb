class PostPolicy < ApplicationPolicy
  # Anyone (even non-logged in users) can view posts
  def index?
    true
  end
end