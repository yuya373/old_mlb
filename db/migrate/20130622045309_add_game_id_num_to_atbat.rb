class AddGameIdNumToAtbat < ActiveRecord::Migration
  def change
    add_column :atbats, :game_id_num, :string
    add_column :pitchings, :game_id_num, :string
  end
end
