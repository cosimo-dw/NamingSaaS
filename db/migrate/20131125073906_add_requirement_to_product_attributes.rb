class AddRequirementToProductAttributes < ActiveRecord::Migration
  def change
    add_column :product_attributes, :requirement, :string
  end
end
