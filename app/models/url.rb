class Url < ApplicationRecord
  has_many :stats

  before_create :generate_short_url

  validates :original, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  def update_stat(ip)
    stat = Stat.find_or_create_by!(ip: ip, url_id: id)
    stat.increment!(:views)
  end

  private

  def generate_short_url
    self.short = loop do
      time = (Time.now.to_f * 1000).to_i.to_s
      short_url = "#{SecureRandom.hex[0..4]}#{time[-4, time.length]}"
      break short_url unless Url.where(short: short_url).exists?
    end
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
