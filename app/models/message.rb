class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  default_scope -> { order('created_at DESC') }

  validates :content, presence: true
  validates :content, length: { maximum: 500 }
  validates :is_user, presence: true
  #validates :user_id, presence: true
  validates :order_id, presence: true
end
