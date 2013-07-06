class RenameTypeFromPitching < ActiveRecord::Migration
  def change
    rename_column :pitchings, :type, :s_or_ball
  end
end
