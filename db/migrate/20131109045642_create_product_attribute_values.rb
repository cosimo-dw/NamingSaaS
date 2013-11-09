class CreateProductAttributeValues < ActiveRecord::Migration
  def change
    create_table :product_attribute_values do |t|
      t.integer :product_attribute_id
      t.integer :order_id
      t.string :value

      t.timestamps
    end

    add_index :product_attribute_values, :order_id
  end
end
