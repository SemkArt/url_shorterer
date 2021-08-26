require 'rails_helper'

RSpec.describe Stat, type: :model do
  describe 'create' do
    subject(:create_stat) { described_class.create!(params) }

    context 'valid_params' do
      let(:url) { create(:url) }

      let(:params) do
        {
          ip: '192.168.0.1',
          url_id: url.id
        }
      end

      it 'creates Stat' do
        expect { create_stat }.to change(Stat, :count).by(1)
        expect(Stat.last.views).to eq(0)
      end
    end
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
