include ActionView::Helpers::DateHelper
Thread.new do
  while true do
    puts Time.now.to_i
    now = (Time.now.to_i + 900).to_s
    if Event.where(['time_of_event < ?', now])
      event = Event.where(['time_of_event < ?', now]).each
      Event.where(['time_of_event < ?', now]).each do |e|
        e.attending_users.each do |i|
          APNS.send_notification(i.device_token, "#{e.title} will be starting in #{distance_of_time_in_words(now, e.time_of_event)}!") unless i.device_token == 'NONE' || i.device_token.nil?
          sleep 1 
        end
        e.update(time_of_event: 'in progress or over')
      end
    end
    sleep 180
  end
end