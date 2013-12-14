class AddMessageNotificationFlagToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :new_user_message, :boolean, default: false
    add_column :orders, :new_admin_message, :boolean, default: false
  end
end
