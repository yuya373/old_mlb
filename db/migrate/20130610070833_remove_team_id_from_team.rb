class RemoveTeamIdFromTeam < ActiveRecord::Migration
  def change
    remove_columns :teams, :team_id, :league_id
    add_column :teams, :team_id, :integer
    add_column :teams, :league_id, :integer
  end
end
