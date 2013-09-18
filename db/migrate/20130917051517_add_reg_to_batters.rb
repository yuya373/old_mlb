class AddRegToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :reg, :integer
  end
end
