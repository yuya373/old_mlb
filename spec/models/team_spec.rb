require 'spec_helper'

describe Team do
  it {should have_many(:batters)}
  it {should have_many(:pitchers)}
  it {should have_many(:home_team_game).class_name('Game')}
  it {should have_many(:away_team_game).class_name('Game')}

  it {should have_db_index(:team_id)}
  it {should have_one(:favorite)}

end
