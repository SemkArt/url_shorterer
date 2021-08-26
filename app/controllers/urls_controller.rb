class UrlsController < ApplicationController
  before_action :load_url, only: [:show, :stats]

  # POST /urls
  def create
    url = Url.create!(original: url_params[:url])
    render json: { short: url.short }
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Ошибка создания Url: #{e.inspect}"
    render json: { error: e.message }
  end

  # GET /urls/:short_url
  def show
    @url.update_stat(request.env['HTTP_X_FORWARDED_FOR'])
    render json: { url: @url.original }
  end

  # GET /urls/:short_url/stats
  def stats
    render json: { views: @url.stats.as_json }
  end

  private

  def url_params
    params.permit(:url)
  end

  def load_url
    @url = Url.find_by(short: params[:short_url])
    render json: { error: 'Not found' } unless @url
  end
end
