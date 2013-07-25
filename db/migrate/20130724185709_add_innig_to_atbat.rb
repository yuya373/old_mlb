class AddInnigToAtbat < ActiveRecord::Migration
  def change
    add_column :atbats, :inning, :integer
    add_column :atbats, :t_b, :string
  end
end
