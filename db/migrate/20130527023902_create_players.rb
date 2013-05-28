class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :p_id
      t.string :name
      t.string :bats
      t.string :throws
      t.string :pos
      t.integer :jersey_number
      t.integer :team_id
      t.integer :league_id

      t.timestamps
    end
  end
end
