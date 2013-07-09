class CreateAtbats < ActiveRecord::Migration
  def change
    create_table :atbats do |t|
      t.integer :num
      t.integer :b
      t.integer :s
      t.integer :o
      t.integer :start_tfs
      t.string :start_tfs_zulu
      t.integer :batter_id
      t.integer :pitcher_id
      t.string :stand
      t.string :b_height
      t.string :p_throws
      t.string :des
      t.string :event

      t.timestamps
    end
  end
end
