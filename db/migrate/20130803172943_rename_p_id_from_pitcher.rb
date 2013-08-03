class RenamePIdFromPitcher < ActiveRecord::Migration
  def change
    rename_column :pitcher_favorites, :p_id, :pitcher_id
  end
end
