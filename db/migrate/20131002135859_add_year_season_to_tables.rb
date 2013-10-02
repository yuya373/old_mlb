class AddYearSeasonToTables < ActiveRecord::Migration
  def change
    add_column :atbats, :year, :integer
    add_column :atbats, :season, :string
    add_column :batters, :season, :string
    add_column :games, :season, :string
    add_column :media, :year, :integer
    add_column :media, :season, :string
    add_column :pitch_tendencies, :year, :integer
    add_column :pitch_tendencies, :season, :string
    add_column :pitch_type_details, :year, :integer
    add_column :pitch_type_details, :season, :string
    add_column :pitchers, :season, :string
    add_column :teams, :year, :integer
    add_column :teams, :season, :string
  end
end
