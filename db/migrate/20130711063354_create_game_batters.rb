class CreateGameBatters < ActiveRecord::Migration
  def change
    create_table :game_batters do |t|
      t.string :game_id
      t.string :team_flag
      t.integer :team_id
      t.integer :p_id
      t.string :name
      t.string :name_display_first_last
      t.string :pos
      t.integer :bo
      t.integer :ab
      t.integer :po
      t.integer :r
      t.integer :a
      t.integer :bb
      t.integer :sac
      t.integer :t
      t.integer :sf
      t.integer :h
      t.integer :e
      t.integer :d
      t.integer :hbp
      t.integer :so
      t.integer :hr
      t.integer :rbi
      t.integer :lob
      t.float :fldg
      t.integer :sb
      t.integer :cs
      t.integer :s_hr
      t.integer :s_rbi
      t.integer :s_h
      t.integer :s_bb
      t.integer :s_r
      t.integer :s_so
      t.float :avg
      t.integer :go
      t.integer :ao

      t.timestamps
    end
  end
end
