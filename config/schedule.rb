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
# set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

def check
  puts Time.now.to_i
  now = (Time.now.to_i - 60).to_s
  if Event.where(['time_of_event < ?', now])
    sleep 1
    event = Event.where(['time_of_event < ?', now]).each
    Event.where(['time_of_event < ?', now]).each do |e|
      e.update(time_of_event: 'in progress or over')
      e.attending_users.each do |i|
        APNS.send_notification(device_token, "PUSH!") unless device_token == 'NONE' || device_token.nil?
        sleep 1 
        end
      end
    end
  end
end
loop do check end