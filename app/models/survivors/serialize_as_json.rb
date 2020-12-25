# frozen_string_literal: true

module Survivors
  class SerializeAsJson < Micro::Case
    attribute :survivor
    attribute :serializer

    def call!
      json = serializer.new(survivor)

      Success(result: { survivor_as_json: json })
    end
  end
end
