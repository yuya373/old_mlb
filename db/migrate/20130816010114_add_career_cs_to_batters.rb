class AddCareerCsToBatters < ActiveRecord::Migration
  def change
    add_column :batters, :career_cs, :integer
  end
end
