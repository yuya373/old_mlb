class BatterFavorite < ActiveRecord::Base
  validates_uniqueness_of :batter_id, scope: :user_id
  belongs_to :batter
  belongs_to :user
end
