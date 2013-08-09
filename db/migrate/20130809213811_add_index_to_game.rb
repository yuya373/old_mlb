class AddIndexToGame < ActiveRecord::Migration
  def change
    add_index :games, [:year, :month]
    add_index :games, [:year, :month, :day]
    add_index :games, :gameday
    add_index :games, [:home_team_id, :away_team_id]
  end
end
