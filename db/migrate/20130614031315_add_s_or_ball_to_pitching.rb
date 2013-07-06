class AddSOrBallToPitching < ActiveRecord::Migration
  def change
    add_column :pitchings, :s_or_ball, :string
  end
end
