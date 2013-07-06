class AddColumnToPitching < ActiveRecord::Migration
  def change
    add_column :pitchings, :on_1b, :onteger
    add_column :pitchings, :on_2b, :integer
    add_column :pitchings, :on_3b, :integer
  end
end
