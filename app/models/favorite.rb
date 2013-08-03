class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :team, foreign_key: 'team_id'
  belongs_to :pitcher, foreign_key: 'p_id'
  belongs_to :batter, foreign_key: 'b_id'

  validates_uniqueness_of :p_id, scope: :user_id, message: "同じ選手または同じチームは重複して選べません"
  validates_uniqueness_of :b_id, scope: :user_id
  validates_uniqueness_of :team_id, scope: :user_id
end