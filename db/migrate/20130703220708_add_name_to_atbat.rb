class AddNameToAtbat < ActiveRecord::Migration
  def change
    add_column :atbats, :pitcher_name, :string
    add_column :atbats, :batter_name, :string
  end
end
