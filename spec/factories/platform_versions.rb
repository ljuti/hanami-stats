FactoryGirl.define do
  factory :platform_version do
    version "1.2.3"
    count 123
    platform "linux"

    trait :android do
      platform "android"
    end

    trait :ios do
      platform "ios"
    end

    trait :windows do
      platform "windows-phone"
    end
  end
end
