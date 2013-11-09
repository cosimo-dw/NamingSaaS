class ChangeTypeToAttrType < ActiveRecord::Migration
  def change
    rename_column :product_attributes, :type, :attr_type
  end
end
