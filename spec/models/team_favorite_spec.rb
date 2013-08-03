require 'spec_helper'

describe TeamFavorite do
  it {should validate_uniqueness_of(:team_id).scoped_to(:user_id)}
  it {should belong_to(:team)}
  it {should belong_to(:user)}
end

