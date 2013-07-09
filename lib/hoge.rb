class Hoge
  def self.test
    Player.delete_all

team = Team.where("team_id not ?",nil)
team.each do |t|

  url = "http://gd2.mlb.com/components/team/stats/#{t.team_id}-stats.xml"
  doc = Nokogiri::XML(open(url))
  batter = doc.css('TeamStats batter')
  batter.each do |b|
    @batter = {}
    @batter[:p_id] = b.attribute('id').text
    @batter[:name] = b.attribute('name').text
    @batter[:bats] = b.attribute('BATS').text
    @batter[:throws] = b.attribute('THROWS').text
    @batter[:pos] =  b.attribute('POS').text
    @batter[:jersey_number] = b.attribute('JERSEY_NUMBER').text
    @batter[:team_id] = b.attribute('TEAM_ID').text
    @batter[:league_id] = b.attribute('LEAGUE_ID').text,
    @batter[:game] = b.attribute('G').text
    Player.create(
      :p_id => @batter[:p_id],
      :name => @batter[:name],
      :bats => @batter[:bats],
      :throws => @batter[:throws],
      :pos => @batter[:pos],
      :jersey_number => @batter[:jersey_number],
      :team_id => @batter[:team_id],
      :league_id => @batter[:league_id],
      :game => @batter[:game]
      )
  end
end
  end
end
