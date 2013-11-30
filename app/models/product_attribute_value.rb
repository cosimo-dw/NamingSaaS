class ProductAttributeValue < ActiveRecord::Base
  belongs_to :order, :inverse_of => :product_attribute_values
  belongs_to :product_attribute

  validates_presence_of :order
  validates :product_attribute_id, presence: true
  validate :validate_attribute

  def name
    product_attribute.name
  end

  private

  def validate_attribute
    ret = product_attribute.check(value)
    if ret
      errors.add(name.to_sym, product_attribute.error(ret))
    end
  end

end
