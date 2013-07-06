class ChangeAbFromPitchTypeDetails < ActiveRecord::Migration
  def change
    change_column :pitch_type_details, :ab, :integer
  end
end
