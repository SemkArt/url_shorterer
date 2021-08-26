require 'rails_helper'

describe '/urls', type: :request do
  describe 'POST /urls' do
    subject(:make_request) { run(:post, '/urls/', params: params.to_json, headers: {}) }
    let(:params) { {} }

    context 'request without params' do
      it 'respond with error' do
        make_request
        expect(json_response['error']).to eq('Validation failed: Original is invalid')
      end
    end

    context 'request with valid params' do
      let(:params) { { url: 'http://valid.url' } }

      it 'createss new url' do
        expect { make_request }.to change(Url, :count).by(1)
        expect(Url.last.original).to eq(params[:url])
      end

      it 'respond with generated short URL' do
        make_request
        expect(json_response['short']).to eq(Url.last.short)
      end
    end
  end

  describe 'GET /urls/:short_url' do
    subject(:make_request) { run(:get, "/urls/#{short_url}", params: {}, headers: {}) }

    let(:short_url) { 'saddf21' }

    context 'url NOT exist' do
      it 'respond with error' do
        make_request
        expect(json_response['error']).to eq('Not found')
      end
    end

    context 'url exist' do
      let!(:url) { create(:url) }
      let(:short_url) { url.short }

      it 'respond with original url' do
        make_request
        expect(json_response['url']).to eq(url.original)
      end

      it 'will increment views' do
        make_request
        expect(url.reload.stats.last.views).to eq(1)
        expect(url.reload.stats.last.ip).to eq('127.0.0.1')
      end
    end
  end

  describe 'GET /urls/:short_url/stat' do
    subject(:make_request) { run(:get, "/urls/#{short_url}/stats", params: {}, headers: {}) }

    let(:short_url) { 'saddf21' }

    context 'url NOT exist' do
      it 'respond with error' do
        make_request
        expect(json_response['error']).to eq('Not found')
      end
    end

    context 'url exist' do
      let!(:url) { create(:url) }
      let(:short_url) { url.short }

      context 'stats for url doesn`t exist' do
        it 'respond with views stat' do
          make_request
          expect(json_response['views']).to eq([])
        end
      end

      context 'stats for url exists' do
        let!(:stat) { create(:stat, ip: '192.168.0.1', views: 2, url: url) }

        it 'respond with views stat' do
          make_request
          expect(json_response['views']).to eq([{ 'ip' => '192.168.0.1', 'views' => 2 }])
        end
      end
    end
  end
end
