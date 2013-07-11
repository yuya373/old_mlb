class AddGidpToGameBatter < ActiveRecord::Migration
  def change
    add_column :game_batters, :gidp, :integer
  end
end
