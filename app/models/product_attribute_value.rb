class ProductAttributeValue < ActiveRecord::Base
  belongs_to :order
  belongs_to :product_attribute

  #validates :order_id, presence: true
  validates :product_attribute_id, presence: true
end
