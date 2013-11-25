class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :content
      t.integer :order_id

      t.timestamps
    end
    add_index :histories, [:order_id, :created_at, :updated_at]
  end
end
