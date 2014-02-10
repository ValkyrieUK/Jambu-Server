require 'faker'

namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    5000.times do |n|
      username  = Faker::Company.name
      full_name  = Faker::Company.name
      uid_int = 1900+rand(999999999999)
      uid = uid_int.to_s
      colour = 'blue'
      provider = 'twitter'
      User.create!(:username => username,
                    :full_name => full_name,
                    :uid => uid,
                    :colour => colour,
                    :provider => provider,
                    :image_url => 'https://pbs.twimg.com/profile_images/2955559089/83f09d26307253decde4d58ecd14c2e9.jpeg',
                    :image_thumbnail => 'http://www.tennisalternative.com/images/avatars/100x100[283].jpg')
    end
  end

    task :friendbomb => environment do
     10000.times do |n|
      user_id = rand(5000)
      friend_id = rand(5000)
      Friendship.create!(user_id: user_id, friend_id: friend_id)
    end
  end
end