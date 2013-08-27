class AddDesToMedia < ActiveRecord::Migration
  def change
    add_column :media, :des, :text
  end
end
