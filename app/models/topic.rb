class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  # Always grab the newest Topics first
  default_scope { order('created_at DESC') }

  # Logged in users can see all Topics. When not logged in only 
  # public Topics are visible.
  scope :visible_to, -> (user) { user ? all : publicly_viewable }

  scope :publicly_viewable,  -> { where(public: true) }
  scope :privately_viewable, -> { where(public: false) }

  # Configure will_paginate
  self.per_page = 50

  validates :name, length: { minimum: 5 }
  
end
