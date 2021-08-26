require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'create' do
    subject(:create_url) { described_class.create!(params) }

    context 'valid_params' do
      let(:params) { { original: 'http://example.com' } }

      it 'creates Url' do
        expect { create_url }.to change(Url, :count).by(1)
        expect(Url.last.short.to_s.size).to eq(9)
      end
    end
  end

  describe '#update_stat' do
    subject(:update_stat) { url.update_stat(ip) }

    let(:url) { create(:url) }
    let(:ip) { '192.168.0.1' }

    context 'stat already exist' do
      let!(:stat) { create(:stat, url: url, ip: ip) }

      it 'will increment views' do
        update_stat
        expect(stat.reload.views).to eq(1)
      end
    end

    context 'stat doesn`t exist' do
      it 'will create new stat' do
        expect { update_stat }.to change(Stat, :count).by(1)
      end

      it 'will increment views' do
        update_stat
        expect(url.reload.stats.first.views).to eq(1)
      end
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
