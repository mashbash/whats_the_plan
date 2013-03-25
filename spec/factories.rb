FactoryGirl.define do
  sequence(:name)      {|n| "john#{n}"}
  sequence(:email)     {|n| "user#{n}@example.com"}
  streets  =             ["Golden Gate Bridge", "Coit Tower", "Golden Gate Park",
                          "Muir Woods, California", "Alcatraz", "Grace Cathedral, SF"]

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

    factory :plan_with_activities do
      before(:create) do |plan|
        6.times do |index|
          plan.activities << build(:activity, :street => streets[index],
                                              :meal   => index % 2)
        end
      end
    end

    factory :plan_with_all_meals do
      before(:create) do |plan|
        6.times do |index|
          plan.activities << build(:activity, :street => streets[index],
                                              :meal   => 1)
        end
      end
    end

    factory :plan_with_no_meals do
      before(:create) do |plan|
        6.times do |index|
          plan.activities << build(:activity, :street => streets[index],
                                              :meal   => 0)
        end
      end
    end
  end

  factory :activity do
    title               "Coit Tower"
    street              "1 Telegraph Hill Blvd"
    longitude           37.8023
    latitude            -122.4057
    meal                { [0, 1].sample }
    image_url           "http://s3-media1.ak.yelpcdn.com/bphoto/p-Y3H1hxM9rDU7R7fqN30A/ms.jpg"
  end

  factory :activity_plan do
    plan
    activity
    add_attribute :sequence, 1
  end
end
