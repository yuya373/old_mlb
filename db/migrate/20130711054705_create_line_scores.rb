class CreateLineScores < ActiveRecord::Migration
  def change
    create_table :line_scores do |t|
      t.string :game_id
      t.integer :inning
      t.integer :home
      t.integer :away
      t.integer :home_team_runs
      t.integer :away_team_runs
      t.integer :home_team_hits
      t.integer :away_team_hits
      t.integer :home_team_errors
      t.integer :away_team_errors

      t.timestamps
    end
  end
end
