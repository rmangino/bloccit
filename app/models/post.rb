class Post < ActiveRecord::Base
  include ModelHelper
  has_many :comments
  belongs_to :user
  belongs_to :topic
  after_initialize { add_markdown_to_html_methods_for_class_attributes(Post, [:title, :body]) }

  # Always grab the newest posts first
  default_scope { order('created_at DESC') }

  # Validations
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
