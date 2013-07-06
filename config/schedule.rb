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
set :environment, :development
set :output, { :error => 'log/error.log', :standard => 'log/cron.log' }
job_type :rbenv_bundle_runner, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && rails runner -e :environment ':task' :output"


# every 1.minutes do
# 　runner "Batter.test"
# end


every 1.day, :at => '2:26 am' do
  rbenv_bundle_runner "Team.get"
  rbenv_bundle_runner "Batter.get"
  rbenv_bundle_runner "Pitcher.get"
  rbenv_bundle_runner "Pitching.get"
  rbenv_bundle_runner "Atbat.get"
  rbenv_bundle_runner "PitchTypeDetail.get"
  rbenv_bundle_runner "PitchTendency.get"

end