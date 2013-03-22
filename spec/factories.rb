FactoryGirl.define do
  factory :user do#, :aliases => [:user1] do
    sequence(:name)        {|n| "john#{n}"}
    sequence(:email)       {|n| "user#{n}@example.com"}
    password               "password"
    password_confirmation  "password"
  end

  factory :plan do
    # user_id                
    sequence(:title)      {|n| "title#{n}"}
    start_date            { DateTime.now }
    end_date              { DateTime.now }
  end
end    


