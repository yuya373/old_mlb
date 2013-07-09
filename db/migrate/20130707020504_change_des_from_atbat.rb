class ChangeDesFromAtbat < ActiveRecord::Migration
  def change
    change_column :atbats, :des, :text
  end
end
