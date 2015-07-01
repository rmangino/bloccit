class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  belongs_to :user
  belongs_to :topic

  # From the CarrierWave gem
  attr_accessor :post_image_cache
  mount_uploader :post_image, PostImageUploader

  # Always grab the posts in rank order. See update_rank()
  default_scope { order('rank DESC') }

  # Validations
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 *24) # 1 day in seconds
    new_rank = points + age_in_days

    update_attribute(:rank, new_rank)
  end
  
  def create_vote
    user.votes.create(post: self, value: 1)    
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do
      save
      create_vote
    end
  end 
end
