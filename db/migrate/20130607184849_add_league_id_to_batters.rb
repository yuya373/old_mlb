class AddLeagueIdToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :league_id, :integer
    add_column :pitchers, :league_id, :integer
  end
end
