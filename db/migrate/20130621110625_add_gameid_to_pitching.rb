class AddGameidToPitching < ActiveRecord::Migration
  def change
    add_column :pitchings, :game_id, :string
  end
end
