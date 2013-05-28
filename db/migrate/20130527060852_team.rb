class Team < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :fname
  end
end
