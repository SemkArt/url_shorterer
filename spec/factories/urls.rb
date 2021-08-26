FactoryBot.define do
  factory :url do
    original { Faker::Internet.url }
  end
end

# == Schema Information
#
# Table name: urls
#
#  id         :integer          not null, primary key
#  original   :string
#  short      :string           indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_short  (short) UNIQUE
#
