class DropTablePitchers < ActiveRecord::Migration
  def change
    drop_table :pitchers
  end
end
