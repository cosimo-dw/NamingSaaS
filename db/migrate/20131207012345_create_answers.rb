class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :chosen_name
      t.string :content
      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end
end
