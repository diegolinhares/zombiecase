# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :verify_json_api_required_headers

  protected

  def render_json(status, json = {})
    render status: status, json: json
  end

  private

  REQUIRED_HEADERS = ['Accept', 'Content-Type'].freeze
  MIME_TYPE_JSON_API = 'application/vnd.api+json'

  def verify_json_api_required_headers
    REQUIRED_HEADERS.each do |required_header|
      header = request.headers[required_header]

      next if header&.include?(MIME_TYPE_JSON_API)

      case required_header
      when 'Accept'
        return render json: { error: 'Not Acceptable' }, status: :not_acceptable
      when 'Content-Type'
        render json: { error: 'Unsupported Media Type' }, status: :unsupported_media_type
      end
    end
  end
end
