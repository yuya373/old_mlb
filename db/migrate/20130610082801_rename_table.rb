class RenameTable < ActiveRecord::Migration
  def change
    rename_table :table_batters, :batters
  end
end
