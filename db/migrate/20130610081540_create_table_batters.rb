class CreateTableBatters < ActiveRecord::Migration
  def change
    create_table :table_batters do |t|
      t.integer :p_id
      t.string :name
      t.string :active_sw
      t.string :status_cd
      t.string :last_name
      t.string :name_display_last_first
      t.string :name_display_first_last
      t.string :name_display_roster
      t.string :bats
      t.string :throws
      t.string :pos
      t.integer :jersey_number
      t.integer :year
      t.integer :team_id
      t.string :team_abbrev
      t.integer :league_id
      t.string :league
      t.integer :league_games
      t.integer :h
      t.integer :ab
      t.integer :tb
      t.float :avg
      t.float :avg_sort
      t.float :slg
      t.float :slg_sort
      t.integer :a
      t.integer :e
      t.integer :po
      t.integer :g
      t.integer :r
      t.integer :b2
      t.integer :b3
      t.integer :hr
      t.integer :rbi
      t.integer :sac
      t.integer :sf
      t.integer :hbp
      t.integer :bb
      t.integer :ibb
      t.integer :so
      t.integer :sb
      t.integer :cs
      t.integer :gidp
      t.float :ops
      t.float :ops_sort
      t.float :obp
      t.float :obp_sort
      t.integer :np
      t.integer :go
      t.integer :ao
      t.integer :tpa
      t.integer :of_a
      t.integer :ph_ab
      t.integer :ph_h
      t.integer :ph_hr
      t.integer :ph_rbi
      t.integer :last10_ab
      t.integer :last10_h
      t.integer :last10_hr
      t.integer :last10_rbi
      t.timestamps
    end
  end
end
