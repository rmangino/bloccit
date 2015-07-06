class User < ActiveRecord::Base
  attr_accessor :avatar_cache
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # From the CarrierWave gem
  mount_uploader :avatar, AvatarUploader

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def member?
    role == 'member'
  end

  # returns nil if this user has notfavorited post, the favorited post otherwise
  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  # Returns the vote if we voted on post, nil otherwise
  def voted(post)
    votes.find_by_post_id(post.id)
  end

  def self.top_rated
    self.select('users.*') # Select all attributes from the users table
        .select('COUNT(DISTINCT comments.id) AS comments_count') # Count the # of comments made by user
        .select('COUNT(DISTINCT posts.id) AS posts_count') # Count the posts made by user
        .select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank') # Add the comment count to the post count and label the sum as "rank"
        .joins(:posts) # Ties the posts table to the users table, via the user_id
        .joins(:comments) # Ties the comments table to the users table, via the user_id
        .group('users.id') # Instructs the database to group the results so that each user will be returned in a distinct row
        .order('rank DESC') # Instructs the database to order the results in descending order, by the rank that we created in this query. (rank = comment count + post count)
  end

end
