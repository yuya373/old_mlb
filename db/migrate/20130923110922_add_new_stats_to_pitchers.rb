class AddNewStatsToPitchers < ActiveRecord::Migration
  def change
    add_column :pitchers, :k_pct, :float
    add_column :pitchers, :bb_pct, :float
    add_column :pitchers, :k_9, :float
    add_column :pitchers, :bb_9, :float
    add_column :pitchers, :hr_9, :float
    add_column :pitchers, :k_bb, :float
    add_column :pitchers, :e_f, :float
    add_column :pitchers, :fip_minus, :float
    add_column :pitchers, :fip, :float
    add_column :pitchers, :xfip, :float
    add_column :pitchers, :babip, :float
    add_column :pitchers, :uera, :float
    add_column :pitchers, :rsaa, :float
    add_column :pitchers, :dips, :float
    add_column :pitchers, :lob_pct, :float
    add_column :pitchers, :p_r, :float

  end
end
