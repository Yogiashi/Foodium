class Post < ApplicationRecord
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :notification, as: :subject, dependent: :destroy
  has_one_attached :post_image
  
  validates :post_image, presence: true
  validates :shop_name, presence: true
  validates :dish_name, presence: true
  validates :caption, presence: true, length: { maximum: 200 }
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
  end
  
  def liked?(user)
     likes.where(user_id: user.id).exists?
  end
end
