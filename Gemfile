source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'json'
gem 'activeadmin', github: 'gregbell/active_admin'

group :production do
  gem 'pg'
end

group :test, :development do
  gem 'rubocop'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails', require: false
  gem 'faker'
  gem 'brakeman'
  gem 'rails-erd'
end
