class SurvivorsController < ApplicationController
  def create
    Survivors::Create
      .call(survivor_params.to_h)
      .then(Survivors::SerializeAsJson)
      .on_success { |result| render_created_survivor(result) }
      .on_failure(:invalid_survivor) { |data| render_unprocessable_survivor(data[:survivor]) }
  end

  private

  def survivor_params
    params.require(:survivor).permit(:name, :age, :gender, :latitude, :longitude, inventory: {})
  end

  def render_created_survivor(result)
    render_json(:created, survivor: result[:survivor_as_json])
  end

  def render_unprocessable_survivor(json)
    render_json(:unprocessable_entity, survivor: json)
  end
end
