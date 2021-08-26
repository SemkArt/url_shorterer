module Helpers
  module Requests
    extend ActiveSupport::Concern

    def json_response
      JSON.parse(response.body)
    end

    def request_headers
      { 'Content-Type' => 'application/json', 'HTTP_X_FORWARDED_FOR' => '127.0.0.1' }
    end

    def run(method, path, params: {}, headers: {})
      send(
        method, path.to_s,
        params: params,
        headers: request_headers.merge(headers)
      )
    end
  end
end
