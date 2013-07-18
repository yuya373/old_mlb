class AddYearMonthDayToGame < ActiveRecord::Migration
  def change
    add_column :games, :year, :integer
    add_column :games, :month, :integer
    add_column :games, :day, :integer
  end
end
