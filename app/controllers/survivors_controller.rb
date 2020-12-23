class SurvivorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_survivor

  def create
    Survivors::Create
      .call(survivor_params.to_h)
      .then(Survivors::SerializeAsJson)
      .on_success { |result| render_created_survivor(result) }
      .on_failure(:invalid_survivor) { |data| render_unprocessable_survivor(data[:survivor]) }
  end

  def update
    Survivors::UpdateLocation
      .call(survivor_id: params[:id], params: survivor_params)
      .then(Survivors::SerializeAsJson)
      .on_success { |result| render_survivor_as_json(result) }
      .on_failure(:not_found_survivor) { |data| render_record_not_found(data[:survivor]) }
      .on_failure(:invalid_survivor) { |data| render_unprocessable_survivor(data[:survivor]) }
  end

  private

  def survivor_params
    params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, inventory: {})
  end

  def render_survivor_as_json(result)
    render_json(:ok, survivor: result[:survivor_as_json])
  end

  def render_created_survivor(result)
    render_json(:created, survivor: result[:survivor_as_json])
  end

  def render_unprocessable_survivor(json)
    render_json(:unprocessable_entity, survivor: json)
  end

  def render_not_found_survivor
    render_json(:not_found, survivor: { id: 'not found' })
  end
end
