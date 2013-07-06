class AddPitcherToPitching < ActiveRecord::Migration
  def change
    add_column :pitchings, :pitcher, :integer
    add_column :pitchings, :batter, :integer

    add_column :pitchings, :des, :string
    add_column :pitchings, :des_es, :string
    add_column :pitchings, :type, :string
    add_column :pitchings, :tfs, :integer
    add_column :pitchings, :tfs_zulu, :string
    add_column :pitchings, :x, :float
    add_column :pitchings, :y, :float
    add_column :pitchings, :sv_id, :string
    add_column :pitchings, :start_speed, :float
    add_column :pitchings, :end_speed, :float
    add_column :pitchings, :sz_top, :float
    add_column :pitchings, :sz_bot, :float
    add_column :pitchings, :pfx_x, :float
    add_column :pitchings, :pfx_z, :float
    add_column :pitchings, :px, :float
    add_column :pitchings, :pz, :float
    add_column :pitchings, :x0, :float
    add_column :pitchings, :y0, :float
    add_column :pitchings, :z0, :float
    add_column :pitchings, :vx0, :float
    add_column :pitchings, :vy0, :float
    add_column :pitchings, :vz0, :float
    add_column :pitchings, :ax, :float
    add_column :pitchings, :ay, :float
    add_column :pitchings, :az, :float
    add_column :pitchings, :break_y, :float
    add_column :pitchings, :break_angle, :float
    add_column :pitchings, :break_length, :float
    add_column :pitchings, :pitch_type, :string
    add_column :pitchings, :type_confidence, :float
    add_column :pitchings, :zone, :integer
    add_column :pitchings, :nasty, :integer
    add_column :pitchings, :spin_dir, :float
    add_column :pitchings, :spin_rate, :float
    add_column :pitchings, :cc, :string
    add_column :pitchings, :mt, :string
  end
end
