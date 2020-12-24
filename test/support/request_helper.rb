# frozen_string_literal: true

module RequestHelper
  def json_response
    JSON.parse(response.body, symbolize_names: true)
  end
end
