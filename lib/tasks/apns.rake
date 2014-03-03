
namespace :apns do
  desc 'Check database for events about to occour'
  task :ping => :environment do
    include ActionView::Helpers::DateHelper
    now = (Time.now.to_i + 900).to_s
    if Event.where(['time_of_event < ?', now])
      Event.where(['time_of_event < ?', now]).each do |e|
        time_until = distance_of_time_in_words(now.to_i, e.time_of_event.to_i)
        e.attendees.each do |i|
          user = User.find(i.user_id)
          APNS.send_notification(user.device_token, "#{e.title} will begin in #{time_until}!") unless user.device_token == 'NONE' || user.device_token.nil? || i.going? == false
        end
        e.update(time_of_event: 'in progress or over')
      end
    end
  end
end