class AddIndexToManyTables < ActiveRecord::Migration
  def change
    add_index :pitch_type_details, [:p_id_ty,:p_b]
    add_index :pitch_type_details, [:p_id,:p_b]
    add_index :game_batters, :game_id
    add_index :pitchings, :game_id_num
    add_index :pitchings, :game_id
    add_index :line_scores, :game_id
    add_index :pitch_tendencies, [:game_id,:p_id,:pitch_type]
    add_index :pitch_tendencies, :p_id
    add_index :game_pitchers, :game_id
    add_index :teams, :team_id
  end
end
