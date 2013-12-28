class AddMessageBoxFlagToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_message_box_closed, :boolean, default: false
  end
end
