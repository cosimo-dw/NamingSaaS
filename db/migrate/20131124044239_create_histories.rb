class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :content
      t.integer :order_id

      t.timestamps
    end
  end
end
