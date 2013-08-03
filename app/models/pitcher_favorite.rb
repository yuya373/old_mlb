class PitcherFavorite < ActiveRecord::Base
  validates_uniqueness_of :pitcher_id, scope: :user_id
  belongs_to :pitcher
  belongs_to :user
end
