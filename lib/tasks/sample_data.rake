require 'faker'

namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    10.times do |n|
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
                    :image_url => 'http://lorempixel.com/200/200/',
                    :image_thumbnail => 'http://lorempixel.com/200/200/')
    end
  end

    task :friendbomb => :environment do
     10000.times do |n|
      user_id = rand(5000)
      friend_id = rand(5000)
      Friendship.create!(user_id: user_id, friend_id: friend_id)
    end
  end
end