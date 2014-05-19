namespace :old_events do
  desc 'Check database for events about to occour'
  task :cancel => :environment do
    if Event.where(['time_of_event_end < ? AND canceled = ? AND notified = ?', Time.now.to_i.to_s, 'false', true])
      Event.where(['time_of_event_end < ? AND canceled = ? AND notified = ?', Time.now.to_i.to_s, 'false', true]).each do |i|
        i.update_attribute(:canceled, 'true')
      end
    end
  end
end