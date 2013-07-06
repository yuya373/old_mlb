class AddPBToBatterDetail < ActiveRecord::Migration
  def change
    add_column :batter_details, :p_b, :string
  end
end
