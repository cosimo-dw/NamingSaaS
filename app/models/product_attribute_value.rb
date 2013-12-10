class ProductAttributeValue < ActiveRecord::Base
  belongs_to :order, :inverse_of => :product_attribute_values
  belongs_to :product_attribute

  validates_presence_of :order
  validates :product_attribute_id, presence: true
  validate :validate_attribute

  serialize :value_set

  def attr_type
    product_attribute.attr_type.to_sym if product_attribute
  end

  def value_type
    if product_attribute and product_attribute.multiple
      :value_set
    else
      :value
    end
  end

  def attr_params
    eval(product_attribute.params) if product_attribute
  end

  def attr_id
    product_attribute.id if product_attribute
  end

  private

  def validate_attribute
    ret = product_attribute.check(value) if product_attribute
    if ret
      errors[:base] << product_attribute.error(ret)
    end
  end

end
