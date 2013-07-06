class RemoveTypeFromPitching < ActiveRecord::Migration
  def change
    remove_column :pitchings, :type, :string
  end
end
