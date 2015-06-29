class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  # From the CarrierWave gem
  attr_accessor :post_image_cache
  mount_uploader :post_image, PostImageUploader

  # Always grab the newest posts first
  default_scope { order('created_at DESC') }

  # Validations
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true
end
