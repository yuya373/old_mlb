class ChangeTypeFromBatterDetail < ActiveRecord::Migration
  def change
    rename_column :batter_details, :type, :pitch_type
  end
end
