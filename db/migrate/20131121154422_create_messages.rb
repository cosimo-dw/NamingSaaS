class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.string :time_stamp
      t.boolean :is_user
      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end
end
