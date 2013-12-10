class ChangeColumnParamsInProductAttributes < ActiveRecord::Migration
  def change
    change_column :product_attributes, :params, :text, :limit => nil
  end
end
