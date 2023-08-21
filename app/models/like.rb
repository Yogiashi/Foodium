class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications # いいねされたらメソッドを呼び出す

  private
  def create_notifications
    # いいね通知を
    Notification.create(subject: self, user: self.post.user, action_type: :liked_to_own_post)
  end
end
