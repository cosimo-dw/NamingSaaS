class AddHistoryAndIndexToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :origin, :string
    add_index :characters, :rank
  end
end
