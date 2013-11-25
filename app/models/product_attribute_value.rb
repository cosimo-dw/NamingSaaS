class ProductAttributeValue < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_attribute

  #validates :order_id, presence: true
  validates :product_attribute_id, presence: true
  before_save { product_attribute.check(value)}

  private

  def check_attribute!
    product_attribute.check(value)
  end

end
