class TeamFavorite < ActiveRecord::Base
  validates_uniqueness_of :team_id, scope: :user_id
  belongs_to :team
  belongs_to :user
end
