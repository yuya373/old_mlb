class AddManyColumnToPitching < ActiveRecord::Migration
  def change
    add_column :pitchings, :inning, :string
    add_column :pitchings, :inning_num, :integer
    add_column :pitchings, :away_team, :string
    add_column :pitchings, :home_team, :string
  end
end
