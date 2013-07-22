class AddIndexToPitching < ActiveRecord::Migration
  def change
    add_index :pitchings, :game_id_num_id
  end
end
