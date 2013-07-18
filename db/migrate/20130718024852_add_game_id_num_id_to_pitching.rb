class AddGameIdNumIdToPitching < ActiveRecord::Migration
  def change
    add_column :pitchings, :game_id_num_id, :string
  end
end
