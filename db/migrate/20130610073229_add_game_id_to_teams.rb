class AddGameIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :game_id, :string
  end
end
