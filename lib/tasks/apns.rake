
namespace :apns do
  desc 'Check database for events about to occour'
  task :ping => :environment do
    # include ActionView::Helpers::DateHelper
    APNS.send_notification("B9C92970EDBB68A2D4D012B2404A2E7F9E4A6F12E0263B35E5B731D5ED763F69", "Something working!")
    now = (Time.now.to_i + 900).to_s
    if Event.where(['time_of_event < ?', now])
      Event.where(['time_of_event < ?', now]).each do |e|
        # time_until = distance_of_time_in_words(now.to_i, e.time_of_event.to_i)
        e.attendees.each do |i|
          user = User.find(i.user_id)
          APNS.send_notification(user.device_token, "#{e.title} will be starting soon}!") unless user.device_token == 'NONE' || user.device_token.nil? || i.going? == false
          sleep 1
        end
        e.update(time_of_event: 'in progress or over')
      end
    end
    sleep 3
  end
end