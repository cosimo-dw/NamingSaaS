class AddErrorsToProductAttributes < ActiveRecord::Migration
  def change
    add_column :product_attributes, :error_messages, :string
  end
end
