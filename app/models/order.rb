class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  has_many :product_attribute_values, dependent: :destroy
  accepts_nested_attributes_for :product_attribute_values
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :product_id, presence: true

  def assign_price
    self.price = product.price
  end
end
