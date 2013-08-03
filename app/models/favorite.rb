class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :team, foreign_key: 'team_id'
  belongs_to :pitcher, foreign_key: 'p_id'
  belongs_to :batter, foreign_key: 'b_id'
end
