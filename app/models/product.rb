class Product < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :product_attributes, dependent: :destroy
end
