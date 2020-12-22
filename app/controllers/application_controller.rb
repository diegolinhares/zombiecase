class ApplicationController < ActionController::API
  protected
  
  def render_json(status, json = {})
    render status: status, json: json
  end
end
