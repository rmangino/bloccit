class Topic < ActiveRecord::Base
  has_many :posts

  # Always grab the newest Topics first
  default_scope { order('created_at DESC') }

  # Configure will_paginate
  self.per_page = 50

  validates :name, length: { minimum: 5 }
  
end
