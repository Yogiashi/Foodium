class Post < ApplicationRecord
  belongs_to :user
  
  has_one_attached :post_image
  
  validates :post_image, presence: true
  validates :shop_name, presence: true
  validates :dish_name, presence: true
  validates :caption, presence: true, length: { maximum: 100 }
  
  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
  end
end
