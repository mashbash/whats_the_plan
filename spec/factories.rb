FactoryGirl.define do
  factory :user do
    sequence(:name)        {|n| "john#{n}"}
    sequence(:email)       {|n| "user#{n}@example.com"}
    password               "password"
    password_confirmation  "password"
  end

  factory :plan do
    sequence(:title)      {|n| "title#{n}"}
    start_date            { 1.day.ago }
    end_date              { 1.year.ago }
  end
end    


