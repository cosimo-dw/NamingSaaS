class RemoveUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :characters, :cc
    remove_column :characters, :tc
    remove_column :characters, :ty
    remove_column :characters, :bihua
    remove_column :characters, :bushou
  end
end
