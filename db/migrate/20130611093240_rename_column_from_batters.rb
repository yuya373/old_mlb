class RenameColumnFromBatters < ActiveRecord::Migration
  def change
    rename_column :batters, :carrer_ab, :career_ab
    rename_column :batters, :carrer_avg, :career_avg
    rename_column :batters, :carrer_h, :career_h
    rename_column :batters, :carrer_bb, :career_bb
    rename_column :batters, :carrer_so, :career_so
    rename_column :batters, :carrer_r, :career_r
    rename_column :batters, :carrer_sb, :career_sb
    rename_column :batters, :carrer_hr, :career_hr
    rename_column :batters, :carrer_rbi, :career_rbi
    rename_column :batters, :carrer_ops, :career_ops
  end
end
