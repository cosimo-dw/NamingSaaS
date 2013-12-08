class AddValueSetToProductAttributeValues < ActiveRecord::Migration
  def change
    add_column :product_attribute_values, :value_set, :string
  end
end
