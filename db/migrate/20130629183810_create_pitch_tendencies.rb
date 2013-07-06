class CreatePitchTendencies < ActiveRecord::Migration
  def change
    create_table :pitch_tendencies do |t|
      t.integer :p_id
      t.string :game_id
      t.integer :game_num
      t.float :game_vel
      t.string :pitch_type
      t.integer :num
      t.float :movement
      t.float :pfx
      t.float :vel
      t.float :avg_x0
      t.float :avg_z0

      t.timestamps
    end
  end
end
