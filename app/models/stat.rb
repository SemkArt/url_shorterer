class Stat < ApplicationRecord
  belongs_to :url

  def as_json
    {
      ip: ip,
      views: views
    }
  end
end

# == Schema Information
#
# Table name: stats
#
#  id         :integer          not null, primary key
#  url_id     :integer          indexed
#  ip         :string
#  views      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stats_on_url_id  (url_id)
#
