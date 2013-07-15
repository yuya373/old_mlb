class AddIndexToDb < ActiveRecord::Migration
  def change
    add_index :atbats, :pitcher_id
    add_index :atbats, :batter_id
    add_index :atbats, :pitcher_name
    add_index :atbats, :batter_name
    add_index :atbats, :game_id_num

    add_index :batters, :p_id
    add_index :batters, :team_id
    add_index :pitchers, :p_id
    add_index :pitchers, :team_id

    add_index :pitch_tendencies, :game_id
    add_index :pitch_type_details, :p_id


  end
end
