class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :code
      t.boolean :cc
      t.boolean :tc
      t.boolean :ty
      t.string :structure
      t.string :bushou
      t.integer :bihua
      t.integer :zongbihua

      t.timestamps
    end
    add_index :characters, :code, unique: true
    add_index :characters, :structure
    add_index :characters, :bushou
    add_index :characters, :zongbihua
    add_index :characters, [:bushou, :bihua]
  end
end
