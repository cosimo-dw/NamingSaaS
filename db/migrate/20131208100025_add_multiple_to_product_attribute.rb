class AddMultipleToProductAttribute < ActiveRecord::Migration
  def change
    add_column :product_attributes, :multiple, :boolean, default: false
  end
end
