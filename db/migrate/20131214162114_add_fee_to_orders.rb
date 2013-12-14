class AddFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fee, :int
  end
end
