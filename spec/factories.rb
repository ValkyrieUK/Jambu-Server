FactoryGirl.define do
  factory :user do
    id                    '1'
    provider              'twitter'
    username              'BillyBob'
    image_url             'http://...'
    image_thumbnail       'http://...'
    full_name             'Bill Bob'
    uid                   '1234'
    colour                'red'
  end
end
