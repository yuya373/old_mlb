class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :gid
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :team_name
      t.integer :team_id

      t.timestamps
    end
  end
end
