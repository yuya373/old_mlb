class CreateTablePitchings < ActiveRecord::Migration
  def change
    create_table :pitchings do |t|
      t.integer :pitcher_id
      t.integer :batter_id
    end
  end
end
