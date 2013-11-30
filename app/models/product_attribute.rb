class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  has_many :product_attribute_values, dependent: :destroy

  validates :product_id, presence: true

  def check(value)
    return eval(requirement) if requirement
    false
  end

  def error(type)
    eval(error_messages)[type] if error_messages
  end
end
