require 'spec_helper'

describe BatterFavorite do
  it {should validate_uniqueness_of(:batter_id).scoped_to(:user_id)}
  it {should belong_to(:batter)}
  it {should belong_to(:user)}
end
