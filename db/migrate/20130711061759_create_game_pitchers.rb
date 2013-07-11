class CreateGamePitchers < ActiveRecord::Migration
  def change
    create_table :game_pitchers do |t|
      t.string :game_id
      t.string :team_flag
      t.integer :team_id
      t.integer :p_id
      t.string :name
      t.string :name_display_first_last
      t.string :pos
      t.integer :out
      t.integer :bf
      t.integer :er
      t.integer :r
      t.integer :h
      t.integer :so
      t.integer :hr
      t.integer :bb
      t.integer :np
      t.integer :s
      t.integer :w
      t.integer :l
      t.integer :sv
      t.integer :bs
      t.integer :hld
      t.float :s_ip
      t.integer :s_h
      t.integer :s_r
      t.integer :s_er
      t.integer :s_bb
      t.integer :s_so
      t.float :era
      t.string :win
      t.string :loss
      t.string :save
      t.string :blown_save
      t.string :note


      t.timestamps
    end
  end
end
