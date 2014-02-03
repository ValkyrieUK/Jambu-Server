FactoryGirl.define do
  factory :user do
    provider              'twitter'
    username              'BillyBob'
    image_url             'http://...'
    full_name             'Bill Bob'
    uid                   '1234'
    colour                'red'
  end
end
