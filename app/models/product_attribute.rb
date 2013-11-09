class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  has_many :product_attribute_values, dependent: :destroy

  validates :product_id, presence: true

end
