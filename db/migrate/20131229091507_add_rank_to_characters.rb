class AddRankToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :rank, :integer, default: 0
  end
end
