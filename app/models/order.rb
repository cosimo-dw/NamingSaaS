class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  has_many :product_attribute_values, dependent: :destroy, inverse_of: :order
  has_many :messages, dependent: :destroy
  has_many :histories, dependent: :destroy

  accepts_nested_attributes_for :product_attribute_values, reject_if: :value_check_failed
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :product_id, presence: true
  validate :validate_attribute_count

  def assign_price
    self.price = product.price
  end

  private

  def value_check_failed(attributes)
    ProductAttribute.find(attributes[:product_attribute_id]).check(attributes[:value])
  end

  def validate_attribute_count
    if product_id.nil?
      return
    end
    err = product.product_attributes.size - product_attribute_values.size
    if err != 0
      errors.add(:product_attribute_values, "#{err} illegal field")
    end
  end
end
