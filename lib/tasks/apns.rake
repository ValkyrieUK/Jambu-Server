namespace :apns do
  desc 'check events occuring soon'
  task :push => :environment do
  #   puts Time.now.to_i
  #   now = (Time.now.to_i - 60).to_s
  #   if Event.where(['time_of_event < ?', now])
  #     sleep 1
  #     event = Event.where(['time_of_event < ?', now]).each
  #     Event.where(['time_of_event < ?', now]).each do |e|
  #       e.update(time_of_event: 'in progress or over')
  #       e.attending_users.each do |i|
          device_token = 'B9C92970EDBB68A2D4D012B2404A2E7F9E4A6F12E0263B35E5B731D5ED763F69'
          APNS.send_notification(device_token, "PUSH!") unless device_token == 'NONE' || device_token.nil?
  #         sleep 1 
  #       end
  #     end
  #   end
  end
end