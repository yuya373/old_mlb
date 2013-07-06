class AddColumnToAtbat < ActiveRecord::Migration
  def change
    add_column :atbats, :game_id, :string
  end
end
