class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  has_many :product_attribute_values, dependent: :destroy

  validates :product_id, presence: true

  def check(value)
    if requirement
      return eval(requirement)
    else
      return false
    end
  end

  def error(type)
    return eval(error_messages)[type]
  end
end
