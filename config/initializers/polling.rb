# scheduler = Rufus::Scheduler.new
# scheduler.every '10m' do
def loop_run
  loop do
    now = (Time.now.to_i + 60).to_s
    puts Time.now.to_i
    if Event.where(['time_of_event < ?', now])
      sleep 1
      event = Event.where(['time_of_event < ?', now]).each
      Event.where(['time_of_event < ?', now]).each do |e|
        e.update(time_of_event: 'in progress or over')
        e.attending_users.each do |i|
          APNS.send_notification(i.device_token, "#{e.title} will begin in 60 seconds") unless i.device_token == 'NONE' || i.device_token.nil?
          sleep 1 
        end
      end
    end
  end
end

loop_run