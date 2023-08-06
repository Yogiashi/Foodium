class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags
  has_one :notification, as: :subject, dependent: :destroy
  has_one_attached :post_image

  validates :post_image, presence: true
  validates :shop_name, presence: true
  validates :dish_name, presence: true
  validates :caption, presence: true, length: { maximum: 200 }
  validates :price, presence: true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
  end

  def liked?(user)
     likes.where(user_id: user.id).exists?
  end
  
  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
end
end
