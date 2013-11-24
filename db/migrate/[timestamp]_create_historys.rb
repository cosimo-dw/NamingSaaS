class CreateHistorys < ActiveRecord::Migration
  def change
    create_table :historys do |t|
      t.string :content
      t.integer :order_id

      t.timestamps
    end
    add_index :historys, [:order_id, :created_at, :updated_at]
  end
end
