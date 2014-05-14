
namespace :notify do
  desc 'Check database for events about to occour'
  task :push => :environment do
    include ActionView::Helpers::DateHelper
    now = (Time.now.to_i + 900).to_s
    if Event.where(['time_of_event < ? AND canceled = ? AND notified = ?', now, 'false', nil])
      Event.where(['time_of_event < ? AND canceled = ? AND notified = ?', now, 'false', nil]).each do |e|
        time_until = distance_of_time_in_words(now.to_i, e.time_of_event.to_i)
        e.attendees.each do |i|
          user = User.find(i.user_id)
          user.device_tokens.each do |p|
            if p.os == 'iOS'
              APNS.send_notification(p.token, :alert => "#{e.title} will begin in #{time_until}!",
                                     :sound => 'default', :other => {:p => 'esoon', :pid => e.id}) unless p.token == 'NONE' || p.token.nil? || i.going? == false
            else
              gcm ||= GCM.new(Rails.application.config.gcm_key)
              message = { data: { message: "#{e.title} will begin in #{time_until}!" } }
              gcm.send_notification(p.token, message) unless p.token == 'NONE' || p.token.nil?
            end
          end
        end
        e.update(notified: true)
      end
      if Event.where(['time_of_event_end < ? AND canceled = ? AND notified = ?', Time.now.to_i.to_s, 'false', true])
        Event.where(['time_of_event_end < ? AND canceled = ? AND notified = ?', Time.now.to_i.to_s, 'false', true]).each do |i|
          i.update_attribute(canceled: 'true')
        end
      end
    end
  end
end
