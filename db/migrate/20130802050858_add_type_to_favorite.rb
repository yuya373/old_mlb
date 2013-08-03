class AddTypeToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :c_type, :string
  end
end
