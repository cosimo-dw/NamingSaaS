class ProductAttributeValue < ActiveRecord::Base
  belongs_to :order, :inverse_of => :product_attribute_values
  belongs_to :product_attribute

  validates_presence_of :order
  validates :product_attribute_id, presence: true
  validate :validate_attribute

  serialize :value, JSON

  private

  def validate_attribute
    ret = product_attribute.check(value) if product_attribute
    if ret
      errors[:base] << product_attribute.error(ret)
    end
  end

end
