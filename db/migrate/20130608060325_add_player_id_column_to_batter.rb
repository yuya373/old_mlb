class AddPlayerIdColumnToBatter < ActiveRecord::Migration
  def change
    add_column :batters, :player_id, :integer
    add_column :pitchers, :player_id, :integer

  end
end
