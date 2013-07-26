class AddIndexToAtbat < ActiveRecord::Migration
  def change
    add_index :atbats, :game_id
  end
end
