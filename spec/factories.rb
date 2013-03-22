FactoryGirl.define do
  sequence(:name)        {|n| "john#{n}"}
  sequence(:email)       {|n| "user#{n}@example.com"}

  factory :user do
    name
    email
    password               "password"
    password_confirmation  "password"
  end

  factory :plan do
    user
    title      { Faker::Lorem.word }
    start_date 1.year.ago
    end_date   1.day.ago
  end

  factory :activity do
    title      { Faker::Lorem.word }
    street      "45 World Avenue"
    city        "San Francisco"
    state       "CA" 
    zip_code    94108
    country     "USA"
    latitude    42.345435345
    longitude   123.43534666
    meal        0
  end

  factory :activity_plan do
    plan
    activity
    add_attribute :sequence, 1
  end  
end    
