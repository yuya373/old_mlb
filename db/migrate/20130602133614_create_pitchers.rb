class CreatePitchers < ActiveRecord::Migration
  def change
    create_table :pitchers do |t|
      t.string :name
      t.integer :p_id
      t.integer :team_id
      t.float :era
      t.integer :w
      t.integer :l
      t.float :whip
      t.float :ip
      t.integer :h
      t.integer :er
      t.integer :r
      t.integer :bb
      t.integer :k
      t.integer :sv
      t.integer :hbp
      t.integer :hra

      t.timestamps
    end
  end
end
