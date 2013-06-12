class AddMonthDesToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :month_des, :string
  end
end
