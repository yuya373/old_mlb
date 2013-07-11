class AddNoteToGameBatter < ActiveRecord::Migration
  def change
    add_column :game_batters, :note, :string
  end
end
