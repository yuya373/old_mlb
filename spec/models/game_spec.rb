require 'spec_helper'

describe Game do
  it {should have_many(:line_scores)}
  it {should have_many(:benches)}
  it {should have_many(:game_batters)}
  it {should have_many(:game_pitchers)}
  it {should have_many(:atbats)}
  it {should have_many(:medias)}
  it {should belong_to(:home_team).class_name('Team')}
  it {should belong_to(:away_team).class_name('Team')}
end
