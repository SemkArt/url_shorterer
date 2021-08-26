FactoryBot.define do
  factory :stat do
    association :url
    ip { Faker::Internet.ip_v4_address }
  end
end
