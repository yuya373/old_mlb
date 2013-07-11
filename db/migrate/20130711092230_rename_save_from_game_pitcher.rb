class RenameSaveFromGamePitcher < ActiveRecord::Migration
  def change
    rename_column :game_pitchers, :save, :save_
  end
end
