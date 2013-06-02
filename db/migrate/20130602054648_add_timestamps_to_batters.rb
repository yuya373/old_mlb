class AddTimestampsToBatters < ActiveRecord::Migration
  def change
    add_timestamps(:batters)
  end
end
