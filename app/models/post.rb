class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments
  mount_uploader :picture, PictureUploader
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end