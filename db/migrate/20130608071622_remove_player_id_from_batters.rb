class RemovePlayerIdFromBatters < ActiveRecord::Migration
  def change
    remove_column :batters, :player_id
    remove_column :pitchers, :player_id
  end
end
