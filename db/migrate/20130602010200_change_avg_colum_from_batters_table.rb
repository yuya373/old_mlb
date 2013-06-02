class ChangeAvgColumFromBattersTable < ActiveRecord::Migration
  change_column(:batters, :avg, :float)
end
