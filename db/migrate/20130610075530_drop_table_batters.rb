class DropTableBatters < ActiveRecord::Migration
  def change
    drop_table :batters
  end
end
