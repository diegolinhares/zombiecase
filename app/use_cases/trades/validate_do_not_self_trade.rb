# frozen_string_literal: true

module Trades
  class ValidateDoNotSelfTrade < Micro::Case
    attribute :survivor_id
    attribute :params

    def call!
      for_survivor_id = params.dig(:for, :survivor_id)

      validation_errors = {}
      validation_errors[:for] = [{ survivor_id: 'not allowed to trade with self' }] if for_survivor_id == survivor_id

      return Success(:valid_attributes) if validation_errors.empty?

      Failure(:invalid_attributes, result: { errors: validation_errors })
    end
  end
end
