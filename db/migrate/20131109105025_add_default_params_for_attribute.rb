class AddDefaultParamsForAttribute < ActiveRecord::Migration
  def change
    change_column_default :product_attributes, :params, '{label: false}'
  end
end
