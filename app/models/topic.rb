class Topic < ActiveRecord::Base
  has_many :posts

  # Always grab the newest Topics first
  default_scope { order('created_at DESC') }

  validates :name, length: { minimum: 5 }
  
end
