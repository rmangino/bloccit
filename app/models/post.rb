class Post < ActiveRecord::Base
  has_many   :comments
  has_one    :summary, dependent: :destroy
  accepts_nested_attributes_for :summary, allow_destroy: true, 
                                reject_if: lambda { |attrs| attrs[:description].blank? }
  belongs_to :user
  belongs_to :topic

  # Always grab the newest posts first
  default_scope { order('created_at DESC') }
end
