class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  # Always grab the newest posts first
  default_scope { order('created_at DESC') }
end
