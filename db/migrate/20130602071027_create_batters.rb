class CreateBatters < ActiveRecord::Migration
  def change

    drop_table :batters

    create_table :batters do |t|
      t.string :name
      t.integer :p_id
      t.integer :team_id
      t.float :avg
      t.integer :ab
      t.integer :h
      t.integer :r
      t.integer :rbi
      t.integer :single
      t.integer :double
      t.integer :triple
      t.integer :hr
      t.integer :bb
      t.integer :hbp
      t.integer :sb
      t.integer :cs
      t.integer :so
      t.integer :err

      t.timestamps
    end
  end
end
