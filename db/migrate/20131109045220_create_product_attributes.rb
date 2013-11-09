class CreateProductAttributes < ActiveRecord::Migration
  def change
    create_table :product_attributes do |t|
      t.integer :product_id
      t.string :name
      t.string :type
      t.string :params

      t.timestamps
    end
  end
end
