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
                    :image_url => 'https://pbs.twimg.com/profile_images/2955559089/83f09d26307253decde4d58ecd14c2e9.jpeg')
    end
  end
end