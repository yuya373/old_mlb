class ChangeColumnFromBench < ActiveRecord::Migration
  def change
    change_column :benches, :team, :string
  end
end
