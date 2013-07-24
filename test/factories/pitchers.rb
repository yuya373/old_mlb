# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pitcher do
    p_id 1
    name "MyString"
    active_sw "MyString"
    status_cd "MyString"
    last_name "MyString"
    name_display_first_last "MyString"
    name_display_first_last "MyString"
    name_display_roster "MyString"
    bats "MyString"
    throws "MyString"
    pos "MyString"
    jersey_number 1
    year 1
    team_id 1
    team_abbrev "MyString"
    league_id 1
    league "MyString"
    league_games 1
    ip 1
    ip_sort 1.5
    er 1
    era 1.5
    era_sort 1.5
    h 1
    r 1
    hr 1
    hb 1
    bb 1
    ibb 1
    so 1
    wp 1
    avg 1.5
    avg_sort 1.5
    slg 1.5
    slg_sort 1.5
    whip 1.5
    whip_sort 1.5
    pct 1.5
    pct_sort 1.5
    ab 1
    sf 1
    sac 1
    gidp 1
    p_inh_runner 1
    p_inh_runner_scored 1
    ao 1
  end
end
