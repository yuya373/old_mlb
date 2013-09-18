class AddRegToPitchers < ActiveRecord::Migration
  def change
    add_column :pitchers, :reg, :integer
  end
end
