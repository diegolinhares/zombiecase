# frozen_string_literal: true

module Survivors
  class UpdateLocation < Micro::Case
    flow([Find, self])

    attribute :survivor
    attribute :params

    def call!
      latitude, longitude = params.values_at(:latitude, :longitude)

      if survivor.update(latitude: latitude, longitude: longitude)
        Success(result: { survivor: survivor })
      else
        Failure :invalid_survivor, result: { survivor: survivor.errors.as_json }
      end
    end
  end
end
