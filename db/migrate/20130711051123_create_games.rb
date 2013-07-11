class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game_id
      t.string :home_team_abbrev
      t.string :home_team_name_full
      t.string :home_team_name
      t.string :home_team_name_brief
      t.integer :home_w
      t.integer :home_l
      t.integer :home_league_id
      t.string :home_league
      t.string :away_team_abbrev
      t.string :away_team_name_full
      t.string :away_team_name
      t.string :away_team_name_brief
      t.string :away_w
      t.string :away_l
      t.string :away_league_id
      t.string :away_league
      t.string :stadium
      t.string :location
      t.timestamps
    end
  end
end
