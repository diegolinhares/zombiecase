# frozen_string_literal: true

module RequestHelper
  def json_api_headers
    {
      'Accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  end

  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end
