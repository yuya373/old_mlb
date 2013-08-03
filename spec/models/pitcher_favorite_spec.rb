require 'spec_helper'

describe PitcherFavorite do
  it {should validate_uniqueness_of(:pitcher_id).scoped_to(:user_id)}
  it {should belong_to(:pitcher)}
  it {should belong_to(:user)}
end
