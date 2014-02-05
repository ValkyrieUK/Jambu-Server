class Attendee < ActiveRecord::Base
  belongs_to :user
  # belongs_to :attendee, class_name: 'User'
end
