class AddGameColumnToPlayer < ActiveRecord::Migration
  def change
    add_column :batters, :game, :integer
    add_column :pitchers, :game, :integer
  end
end
