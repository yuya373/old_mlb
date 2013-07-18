class RenameGameIdFromGame < ActiveRecord::Migration
  def change
    rename_column :games, :game_id, :gameday
  end
end
