class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :subject, dependent: :destroy
  
  validates :content, presence: true

  after_create_commit :create_notifications # コメントされたらメソッドを呼び出す

  private
  def create_notifications
    # コメント通知を
    Notification.create(subject: self, user: post.user, action_type: :commented_to_own_post)
  end
end
