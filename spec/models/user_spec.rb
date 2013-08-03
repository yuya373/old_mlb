require 'spec_helper'

describe User do
  it {should have_many(:team_favorites)}
  it {should have_many(:pitcher_favorites)}
  it {should have_many(:batter_favorites)}
end
