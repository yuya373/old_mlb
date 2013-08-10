# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, :production
set :output, { :error => 'log/error.log', :standard => 'log/cron.log' }
job_type :rbenv_bundle_runner, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && rails runner -e development ':task' :output"
job_type :sakura_runner, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && rails runner -e production ':task' :output"



# every 1.minutes do
#   sakura_runner "p 'SUCCESS!!!'"

# end


# every 1.day, :at => '19:59 pm' do
#   rbenv_bundle_runner "Team.get"
#   rbenv_bundle_runner "Batter.get"
#   rbenv_bundle_runner "Pitcher.get"
#   rbenv_bundle_runner "Pitching.get"
#   rbenv_bundle_runner "Atbat.get"
#   rbenv_bundle_runner "PitchTypeDetail.batter_get"
#   rbenv_bundle_runner "PitchTypeDetail.pitcher_get"
#   rbenv_bundle_runner "PitchTendency.get"

# end
every 1.day, :at => '13:00' do
  sakura_runner "Team.get"
end


every 1.day, :at => '14:00' do
  sakura_runner "Batter.get"
  sakura_runner "Pitcher.get"
  sakura_runner "Pitching.get"
  sakura_runner "Atbat.get"
  sakura_runner "PitchTypeDetail.batter_get"
  sakura_runner "PitchTypeDetail.pitcher_get"
  sakura_runner "PitchTendency.get"
  sakura_runner "Bench.get"
  sakura_runner "Game.get"
  sakura_runner "GameBatter.get"
  sakura_runner "GamePitcher.get"
  sakura_runner "LineScore.get"
  sakura_runner "Media.get"
  sakura_runner "Media.cg_get"
end

every 1.day, at: '15:00' do
  sakura_runner "Game.get"
  sakura_runner "GameBatter.get"
  sakura_runner "GamePitcher.get"
  sakura_runner "LineScore.get"
  sakura_runner "Media.get"
  sakura_runner "Media.cg_get"
end


every 1.day, :at => '17:00' do
  sakura_runner "Batter.get"
  sakura_runner "Pitcher.get"
  sakura_runner "Pitching.get"
  sakura_runner "Atbat.get"
  sakura_runner "PitchTypeDetail.batter_get"
  sakura_runner "PitchTypeDetail.pitcher_get"
  sakura_runner "PitchTendency.get"
  sakura_runner "Bench.get"
  sakura_runner "Game.get"
  sakura_runner "GameBatter.get"
  sakura_runner "GamePitcher.get"
  sakura_runner "LineScore.get"
  sakura_runner "Media.get"
  sakura_runner "Media.cg_get"

end

every 1.day, at: '20:00' do
  sakura_runner "Media.get"
  sakura_runner "Media.cg_get"
end

