class AddTimestampsToPitchings < ActiveRecord::Migration
  def change
    add_timestamps :pitchings
  end
end
