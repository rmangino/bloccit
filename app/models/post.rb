class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic

  # Always grab the newest posts first
  default_scope { order('created_at DESC') }

  # Validations
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
