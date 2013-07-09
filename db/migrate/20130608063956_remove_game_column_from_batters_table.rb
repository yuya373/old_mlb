class RemoveGameColumnFromBattersTable < ActiveRecord::Migration
  def change
    remove_column :batters, :game
    remove_column :pitchers, :game
  end
end
