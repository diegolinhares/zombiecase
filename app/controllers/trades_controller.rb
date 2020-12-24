class TradesController < ApplicationController
  def create
    Trades::Create
      .call(survivor_id: params[:survivor_id], params: trades_params)
      .on_success { |result| render_survivor(result) }
      .on_failure(:invalid_attributes) { |data| render_trade_errors(data[:errors]) }
  end

  private

  def trades_params
    params.require(:trade).permit(offer: {}, for: {})
  end

  def render_survivor(result)
    render_json(:ok, data: result[:survivor])
  end

  def render_trade_errors(json)
    render_json(:unprocessable_entity, errors: json)
  end
end
    