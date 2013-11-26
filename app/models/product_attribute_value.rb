class ProductAttributeValue < ActiveRecord::Base
  belongs_to :order, :inverse_of => :product_attribute_values
  belongs_to :product_attribute

  validates_presence_of :order
  validates :product_attribute_id, presence: true

end
