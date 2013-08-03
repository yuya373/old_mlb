require 'spec_helper'

describe "favorites/edit" do
  before(:each) do
    @favorite = assign(:favorite, stub_model(Favorite,
      :team_id => 1,
      :p_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit favorite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", favorite_path(@favorite), "post" do
      assert_select "input#favorite_team_id[name=?]", "favorite[team_id]"
      assert_select "input#favorite_p_id[name=?]", "favorite[p_id]"
      assert_select "input#favorite_user_id[name=?]", "favorite[user_id]"
    end
  end
end
