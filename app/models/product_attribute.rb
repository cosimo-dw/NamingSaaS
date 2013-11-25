class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  has_many :product_attribute_values, dependent: :destroy

  validates :product_id, presence: true

  def check(value)
    # This is preliminary. See "Following users" for the full implementation.
    if requirement
      raise 'error' if eval(requirement)
    end
  end
end
