class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags, dependent: :destroy
  has_one :notification, as: :subject, dependent: :destroy
  has_many_attached :post_images

  validates :post_images, presence: true
  validates :shop_name, presence: true
  validates :dish_name, presence: true
  validates :caption, length: { maximum: 200 }
  validates :price, presence: true
  validates :address, presence: true
  validate :validate_number_of_files

  # 地図機能
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # 投稿にいいねされてるかの判別
  def liked?(user)
     likes.where(user_id: user.id).exists?
  end

  def save_tag(sent_tags)
    sent_tags.uniq!
    # タグが存在していれば、タグの名前を全て取得
    current_tags = self.tags.pluck(:name)
    # 現在取得したタグから送られてきたタグを除いてold_tagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnew_tagsとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      tag = Tag.find_by(name: old)
      self.post_tags.find_by!(tag_id: tag.id).destroy if tag.present?
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
   end
  end

  # キーワード検索メソッド
  def self.search(search)
    if search != nil && search != ''
      Post.joins(:tags).joins(:user).where('shop_name LIKE(?) OR dish_name LIKE(?) OR caption LIKE(?) OR address LIKE(?) OR tags.name LIKE(?) OR users.name LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").distinct
    else
      Post.all
    end
  end

  # 最小価格〜最大価格の検索メソッド
  def self.price_search(min_search, max_search)
    if max_search != '' && max_search != nil && min_search != '' && min_search != nil
        @posts = Post.where("price >= #{min_search} and price <= #{max_search}")
    elsif max_search != '' && max_search != nil
        @posts = Post.where("price <= #{max_search}")
    elsif min_search != '' && min_search != nil
        @posts = Post.where("price >= #{min_search}")
    end
  end

  # 添付できる画像を４枚までに制限
  FILE_NUMBER_LIMIT = 4
  def validate_number_of_files
    return if post_images.length <= FILE_NUMBER_LIMIT
    errors.add(:post_images, "の添付は#{FILE_NUMBER_LIMIT}枚までです。")
  end
end
